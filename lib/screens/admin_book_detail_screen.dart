import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:acquire_lms_mobile_app/provider/detail_provider.dart';
import 'package:acquire_lms_mobile_app/provider/home_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/app_bar_widget.dart';
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
            context..router.navigate(const CollectionScreen());
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
      bottomNavigationBar: _bottomNavWidget(),
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
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      "${bookModel?.title}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      bookModel?.subtitle ?? "-",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Image.network(bookModel?.thumbnail ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: HtmlWidget(bookModel?.description ?? "-"),
                  ),
                  verticalSpacing(20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _editBook(context, bookModel);
                          },
                          child: const Text("Edit Book"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _deleteBook(context, bookModel?.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Set the background color to red
                          ),
                          child: const Text("Delete Book"),
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

  Widget _bottomNavWidget() {
    final widget = Container(
      color: Colors.blue,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Buy Book",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
    return InkWell(
      child: widget,
      onTap: () async {
        final url = DetailProvider.bookUrl;
        if (url != null) {
          // ignore: deprecated_member_use
          if (!await launch(url)) throw 'Could not launch $url';
        }
      },
    );
  }
  void _editBook(BuildContext context, BookModel? bookModel) {
    // Implement your logic to navigate to the book edit screen
    // For example, you can navigate to an edit screen and pass the bookModel
    if (bookModel != null) {
      // context.pushRoute(ModifyBookScreen(bookModel: bookModel));
    }
  }

  void _deleteBook(BuildContext context, String? bookId) async {
    if (bookId != null) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.deleteBook(bookId);
      Navigator.pop(context); // Go back to the previous screen after deletion
    }
  }
}