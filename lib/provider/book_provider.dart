import 'dart:convert';
import 'package:acquire_lms_mobile_app/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BooksProvider with ChangeNotifier {
  final String baseUrl = "http://127.0.0.1/UsersDb/books.php";
  List<BookModel> _bookcatalog = [];

  List<BookModel> get bookshelf => _bookcatalog;

  Future<void> addBook(BookModel book) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'action': 'addBook',
          ...book.toJson(),
        }),
      );

      if (response.statusCode == 201) {
        fetchBooks();
      } else {
        print('Failed to add book: ${response.body}');
      }
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  Future<void> updateBook(BookModel book) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'action': 'updateBook',
          ...book.toJson(),
        }),
      );

      if (response.statusCode == 200) {
        fetchBooks();
      } else {
        print('Failed to update book: ${response.body}');
      }
    } catch (e) {
      print('Error updating book: $e');
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'action': 'deleteBook',
          'id': id,
        }),
      );

      if (response.statusCode == 200) {
        fetchBooks();
      } else {
        print('Failed to delete book: ${response.body}');
      }
    } catch (e) {
      print('Error deleting book: $e');
    }
  }

Future<void> fetchBooks() async {
  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;
      final data = jsonDecode(responseData);
      _bookcatalog = (data['books'] as List)
          .map((item) => BookModel.fromJson(item))
          .toList();
           print('Response body: ${response.body}');
      notifyListeners();
    } else {
      print('Failed to fetch books: ${response.body}');
    }
  } catch (e) {
    print('Error fetching books: $e');
  }
}


}
