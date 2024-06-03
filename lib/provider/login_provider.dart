import 'dart:convert';
import 'package:acquire_lms_mobile_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;

  Future<bool> loginUser(User user) async {
    final url = Uri.parse("http://127.0.0.1/UsersDb/login.php");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "LibraryCardNumber": user.libraryCardNumber,
      "Password": user.password
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == "success") {
          // print("Login successful");
          await _saveUserSession(data['userId']);
          notifyListeners();
          return true; 
        } else {
          // print("Login failed: ${data['message']}");
          return false; 
        }
      } else {
        // print("loginProvider Server error: ${response.statusCode}");
        // print("Error message: ${response.body}");
        return false; 
      }
    } catch (e) {
      // print("An error occurred: $e");
      return false;
    }
  }

  Future<void> _saveUserSession(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<void> signOutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    // print("User signed out");
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId');
  }
}
