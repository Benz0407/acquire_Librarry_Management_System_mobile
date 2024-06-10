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
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  HomeProvider? _provider;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = Provider.of<HomeProvider>(context, listen: false);
      _provider?.getBooks();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getBooksApi();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) => SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 08.0, horizontal: 8.0),
          child: Scaffold(
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
                const ScreenHeader(headerText: 'Book Catalog'),
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

  void _openBookDetail(BookModel book) {
    context.pushRoute(BookDetailScreen(bookId: book.id));
  }

  void _getBooksApi() {
    _provider?.showLoading();
    _provider?.getBooks();
  }
}
