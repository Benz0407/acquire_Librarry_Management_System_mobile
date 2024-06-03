// import 'dart:convert';

// import 'package:acquire_lms_mobile_app/models/book_model.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;

// class HomeProvider with ChangeNotifier {
//   List<BookModel> books = [];
//   int page = 0;
//   bool isLoading = true;
//   String? query = "Informating Technology";

//   Future<void> getBooks() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=$page&maxResults=40"));

//       //print("response.body ${response.body}");
//       final items = jsonDecode(response.body)['items'];
//       List<BookModel> bookList = [];
//       for (var item in items) {
//         bookList.add(BookModel.fromApi(item));
//       }

//       books.addAll(bookList);
//       page += 40;
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       // print("error get books $e");
//     }
//   }

//   void showLoading() {
//     isLoading = true;
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeProvider with ChangeNotifier {
  final String localApiUrl = 'http://127.0.0.1/UsersDb/books.php';

  List<BookModel> books = [];
  bool isLoading = false;
  String? query = "Informating Technology";
  int page = 0;
  Future<void> getBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      books.clear();
      await _fetchBooksFromLocal();
      await _fetchBooksFromGoogleBooks();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchBooksFromLocal() async {
    final response = await http.get(
      Uri.parse(localApiUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<BookModel> localBooks = (data['books'] as List)
          .map((item) => BookModel.fromJson(item))
          .toList();
      books.addAll(localBooks);
    } else {
      print('Failed to fetch local books: ${response.body}');
    }
  }

  Future<void> _fetchBooksFromGoogleBooks() async {
    final response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=$page&maxResults=40"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<BookModel> googleBooks = (data['items'] as List)
          .map((item) => BookModel.fromApi(item))
          .toList();
      books.addAll(googleBooks);
    } else {
      print('Failed to fetch Google Books: ${response.body}');
    }
  }

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  Future <void> deleteBook(String bookId) async {

  }
  

}
