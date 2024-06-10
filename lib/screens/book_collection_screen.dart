import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/home_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/app_bar_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/book_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/build_app_drawer.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  HomeProvider? _provider;
  bool _isExpanded = false;
  late Animation<double> _translateButton;
  late Animation<double> _buttonAnimatedIcon;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });

    _buttonAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 100,
      end: -20,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = Provider.of<HomeProvider>(context, listen: false);
      _provider?.adminGetBooks();
      
    });

    @override
    dispose() {
      _animationController.dispose();
      super.dispose();
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getBooksApi();
      }
    });
  }

  _toggle() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) => SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Scaffold(
            floatingActionButton: _floatingActionWidget(),
            appBar: AppBar(
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.red),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: const Color(0xFF909090),
                  height: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 13.0),
                ),
              ),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80,
              title: const Row(
                children: [
                  AcquireTitle(),
                ],
              ),
            ),

            endDrawer: const BuildAppDrawer(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(30),
                const ScreenHeader(headerText: 'Book Collection'),
                verticalSpacing(15),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for books...'),
                    onSubmitted: (value) {
                      if (value.trim().isEmpty) {
                        return; // Do nothing if the input is empty or just whitespace
                      }
                      _provider?.query = value;
                      _provider?.books.clear();
                      _getBooksApi();
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: provider.books.length,
                    itemBuilder: (context, position) {
                      final book = provider.books[position];
                      return InkWell(
                        onTap: () {
                          _openBookDetail(book);
                        },
                        child: BookWidget(
                          title: book.title,
                          subtitle: book.subtitle ?? book.description,
                          thumbnail: book.thumbnail,
                          author: book.authors?.join(", ") ?? "Unknown Author",
                          availableCopies: book.availableCopies,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(color: Color(0xffDADADA)),
                  ),
                ),
                if (provider.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingActionWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4,
            0.0,
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            tooltip: "Manual add book",
            backgroundColor: Colors.blue,
            onPressed: () {context.pushRoute(const RecordBookRoute());},
            heroTag: null,
            child: const Icon(
              Icons.edit_note_rounded,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0,
            _translateButton.value * 3,
            0,
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            tooltip: "Scan barcode to add",
            backgroundColor: Colors.red,
            onPressed: () {/* Do something */},
            heroTag: null,
            child: const Icon(
              Icons.qr_code_scanner,
            ), 
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0,
            _translateButton.value * 2,
            0,
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            tooltip: "Search to add",
            backgroundColor: Colors.blueGrey.shade400, 
            onPressed: () {context.pushRoute(const SearchAddBook());},
            heroTag: null,
            child: const Icon(Icons.screen_search_desktop_outlined), 
          ),
        ),
        // This is the primary FAB
        FloatingActionButton(
          shape: const CircleBorder(),
          tooltip: "Add book",
          onPressed: _toggle,
          heroTag: null,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
              progress: _buttonAnimatedIcon,
          ), 
        ),
      ],
    );
  }

  void _openBookDetail(BookModel book) {
    context.pushRoute(AdminBookDetailsScreen(bookId: book.id));
  }

  void _getBooksApi() {
    _provider?.showLoading();
    _provider?.adminGetBooks();
  }
}
