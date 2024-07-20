import 'dart:convert';
import 'package:acquire_lms_mobile_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;

  String _userRole = 'Student'; // default role

  String get userRole => _userRole;

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }

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
          await fetchUserRole(); 
          print('Login successful. User ID: ${data['userId']}, Role: $userRole');
          notifyListeners();
          return true; 
        } else {
          print("Login failed: ${data['message']}");
          return false; 
        }
      } else {
        print("loginProvider Server error: ${response.statusCode}");
        print("Error message: ${response.body}");
        return false; 
      }
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }

  Future<void> fetchUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    print(userId); 
    if (userId == null) return;

    final response = await http.post(
      Uri.parse("http://127.0.0.1/UsersDb/get_role.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setUserRole(responseData['role']);
    } else {
      // Handle error
      print('Error: ${response.body}');
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
