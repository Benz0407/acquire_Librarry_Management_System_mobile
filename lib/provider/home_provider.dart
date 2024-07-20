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
      await _fetchBooksFromGoogleBooks();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> adminGetBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      books.clear();
      await _fetchBooksFromLocal();
    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchBooksFromLocal() async {
    try {
      final response = await http.get(
        Uri.parse(localApiUrl),
        headers: {'Content-Type': 'application/json'},
        
      );
  
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['books'] is List) {
          List<BookModel> localBooks = (data['books'] as List)
              .map((item) => BookModel.fromJson(item))
              .toList();
          books.addAll(localBooks);
          localBooks.forEach((book) {
  print('Title: ${book.title}');
  print('Subtitle: ${book.subtitle}');
  print('Authors: ${book.authors}');
  print('Thumbnail: ${book.thumbnail}');
  print('Available Copies: ${book.availableCopies}');
  print('Book Status: ${book.bookStatus}');
  print('----------------------');
});
        } else {
          print('Unexpected response format for local books: ${response.body}');
        }
      } else {
        print('Failed to fetch local books: ${response.body}');
      }
    } catch (e) {
      print("Error fetching local books: $e");
    }
  }

  Future<void> _fetchBooksFromGoogleBooks() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=$page&maxResults=40"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['items'] is List) {
          List<BookModel> googleBooks = (data['items'] as List)
              .map((item) => BookModel.fromApi(item))
              .toList();
          books.addAll(googleBooks);
        } else {
          print(
              'Unexpected response format for Google Books: ${response.body}');
        }
      } else {
        print('Failed to fetch Google Books: ${response.body}');
      }
    } catch (e) {
      print("Error fetching Google Books: $e");
    }
  }

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  List<BookModel> _newBooks = [];

  List<BookModel> get newBooks => _newBooks;


  Future<void> getNewBooks() async {
    const String localApiUrl = 'http://127.0.0.1/UsersDb/books.php'; // Update with your API endpoint

    try {
      final response = await http.get(
        Uri.parse(localApiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['books'] is List) {
          final books = (data['books'] as List<dynamic>)
              .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
              .toList();
          _newBooks = books.where((book) => book.bookStatus == "Approved").toList();
          notifyListeners();
        } else {
          print('Unexpected response format for local books: ${response.body}');
        }
      } else {
        print('Failed to fetch local books: ${response.body}');
      }
    } catch (e) {
      print("Error fetching local books: $e");
    }
  }

}

