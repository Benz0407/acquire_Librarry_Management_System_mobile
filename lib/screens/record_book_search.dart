import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:acquire_lms_mobile_app/provider/home_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/app_bar_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/build_app_drawer.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/search_book_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@RoutePage()
class SearchAddBook extends StatefulWidget {
  const SearchAddBook({super.key});

  @override
  State<SearchAddBook> createState() => _SearchAddBookState();
}

class _SearchAddBookState extends State<SearchAddBook>
    with SingleTickerProviderStateMixin {
  late BooksProvider _bookProvider;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  HomeProvider? _provider;
  bool _isExpanded = false;
  bool _showSearchResults = false;
  late Animation<double> _translateButton;
  late Animation<double> _buttonAnimatedIcon;
  late AnimationController _animationController;
  List<BookModel> _searchResults = [];

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
    _bookProvider = Provider.of<BooksProvider>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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
              leading: TextButton(
                onPressed: () {
                  context.pushRoute(const CollectionScreen());
                },
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.red),
                ),
              ),
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
                const ScreenHeader(headerText: 'Record Book'),
                verticalSpacing(15),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for books...',
                    ),
                    onChanged: (value) {
                      _searchBooks(value);
                    },
                  ),
                ),
                if (_showSearchResults)
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, position) {
                        final book = _searchResults[position];
                        return InkWell(
                          onTap: () {
                            _openBookDetail(book);
                          },
                          child: SearchBookWidget(
                            id: book.id,
                            title: book.title,
                            subtitle: book.subtitle ?? book.description,
                            thumbnail: book.thumbnail,
                            author: book.authors,
                            bookUrl: book.bookUrl,
                            edition: book.edition,
                            publisher: book.publisher,
                            isbn: book.isbn,
                            length: book.length,
                            subjects: book.subjects,
                            categories: book.categories,
                            availableCopies: book.availableCopies,
                            onAddToCatalogPressed: () =>
                                _addToCatalogPressed(book),
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
            onPressed: () {
              context.pushRoute(const RecordBookRoute());
            },
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
            onPressed: () {/* Do something */},
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
    _provider?.getBooks();
  }

  void _searchBooks(String query) async {
    if (query.isEmpty) {
      setState(() {
        _showSearchResults = false;
        _searchResults.clear();
      });
      return;
    }

    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<BookModel> books = [];
      if (jsonData['items'] != null) {
        for (final item in jsonData['items']) {
          final volumeInfo = item['volumeInfo'];
          final String id = item['id'];
          final String title = volumeInfo['title'] ?? 'Unknown Title';
          final String subtitle = volumeInfo['subtitle'] ?? '';
          final List<dynamic>? authorsList = volumeInfo['authors'];
          List<String>? authors;
          if (authorsList != null) {
            authors = authorsList.cast<String>(); // Convert to List<String>
          }
          final String? bookUrl = item['volumeInfo']['previewLink'] ??
              item['volumeInfo']['infoLink'];
          final String? thumbnail = volumeInfo['imageLinks']?['thumbnail'];
          // Description
          final String? description = volumeInfo['description'];
          final int availableCopies = 1; // Assume one available copy
          final String? edition = volumeInfo['edition'] ?? 'Unknown';
          final String? publisher = volumeInfo['publisher'];
          final List<dynamic>? identifiers = volumeInfo['industryIdentifiers'];
          final String? isbn = identifiers != null && identifiers.isNotEmpty
              ? identifiers[0]['identifier']
              : '';
          final String length =
              volumeInfo['pageCount']?.toString() ?? 'Unknown';
          final List<dynamic>? subjectsList = volumeInfo['categories'];
          final List<dynamic>? categoriesList = volumeInfo['categories'];
          final List<String> subjects = [];
          final List<String> categories = [];
          if (subjectsList != null) {
            for (final subject in subjectsList) {
              final String? subjectStr = subject.toString();
              if (subjectStr != null && subjectStr.isNotEmpty) {
                subjects.add(subjectStr);
              }
            }
          }
          if (categoriesList != null) {
            for (final category in categoriesList) {
              final String? categoryStr = category.toString();
              if (categoryStr != null && categoryStr.isNotEmpty) {
                categories.add(categoryStr);
              }
            }
          }

          books.add(BookModel(
            id: id,
            title: title,
            subtitle: subtitle,
            authors: authors != null ? List<String>.from(authors) : null,
            description: description,
            thumbnail: thumbnail,
            availableCopies: availableCopies,
            edition: edition,
            publisher: publisher,
            isbn: isbn,
            subjects: subjects.isNotEmpty ? subjects : null,
            categories: categories.isNotEmpty ? categories : null,
          ));
        }
        setState(() {
          _showSearchResults = true;
          _searchResults = books;
        });
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  void _addToCatalogPressed(BookModel book) {
    _bookProvider.addToCatalog(book);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
