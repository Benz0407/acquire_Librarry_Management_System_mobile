import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:acquire_lms_mobile_app/provider/detail_provider.dart';
import 'package:acquire_lms_mobile_app/provider/home_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/build_app_drawer.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AdminBookDetailsScreen extends StatelessWidget {
  const AdminBookDetailsScreen({super.key, @PathParam('bookId') this.bookId});

  final String? bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: TextButton(
          onPressed: () {
            context.router.navigate(const CollectionScreen());
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.red),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF909090),
            height: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 13.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Center(
          child: Image.asset(
            'assets/Logo.png',
            height: 50,
          ),
        ),
      ),
      endDrawer: const BuildAppDrawer(),
      body: FutureBuilder<BookModel?>(
        future: DetailProvider().getBookDetail(bookId),
        builder: (context, apiResponse) {
          final bookModel = apiResponse.data;
          DetailProvider.bookUrl = bookModel?.bookUrl;

          if (apiResponse.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (apiResponse.connectionState == ConnectionState.done &&
              bookModel == null) {
            return const Center(
              child: Text(
                "Data not found",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacing(40),
                  const ScreenHeader(headerText: 'Book Detail'),
                  verticalSpacing(40),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      "${bookModel?.title}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      bookModel?.subtitle ?? "-",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 10, top: 16),
                        child: Image.network(bookModel?.thumbnail ?? ""),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "By: ${bookModel?.authors ?? "Unknown"}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Publisher: ${bookModel?.publisher ?? "Unknown"}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Published: Unknown",
                                // ${bookModel?.publishedDate ?? "Unknown"}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              Text(
                                "ISBN: ${bookModel?.isbn ?? "Unknown"}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Handle place hold action
                                    },
                                    child: const Text('Place Hold'),
                                  ),
                                  const SizedBox(width: 2),
                                  TextButton(
                                    onPressed: () {
                                      // Handle add to list action
                                    },
                                    child: const Text('Add to List',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(20),
                  Center(
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.red),
                      child: TextButton(
                          onPressed: () async {
                            final url = DetailProvider.bookUrl;
                            if (url != null) {
                              // ignore: deprecated_member_use
                              if (!await launch(url)) {
                                throw 'Could not launch $url';
                              }
                            }
                          },
                          child: const Text(
                            "Know more",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )),
                    ),
                  ),
                  verticalSpacing(20),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: HtmlWidget(bookModel?.description ?? "-"),
                  ),
                  verticalSpacing(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            onPressed: () {
                              _editBook(context, bookId!);
                            },
                            child: const Text(
                              'Modify Book',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * .4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: TextButton(
                            onPressed: () {
                              _deleteBook(context, bookModel?.id);
                            },
                            child: const Text(
                              'Unlist Book',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isBookListNotEmpty(BuildContext context) {
    return Provider.of<HomeProvider>(context, listen: false).books.isNotEmpty;
  }

  void _editBook(BuildContext context, String bookId) {
    context.pushRoute(ModifyBookScreen(bookId: bookId));
  }

  void _deleteBook(BuildContext context, String? bookId) async {
    if (bookId != null) {
      final booksProvider = Provider.of<BooksProvider>(context, listen: false);
      await booksProvider.deleteBook(bookId);
      context.router.navigate(const CatalogScreen()); 
    }
  }
}
