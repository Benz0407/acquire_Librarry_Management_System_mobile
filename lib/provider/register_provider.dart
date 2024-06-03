import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:acquire_lms_mobile_app/models/user_model.dart';
// import 'package:uuid/uuid.dart';

class RegisterProvider with ChangeNotifier {
  bool isLoading = true;
  List<String> departments = [];
  List<String> courses = [];

  Future<bool> isLibraryCardNumberUnique(String cardNumber) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1/UsersDb/register.php"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'action': 'checkLibraryCardNumber',
        'LibraryCardNumber': cardNumber,
      }),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData['isUnique'];
    } else {
      // Handle error
      return false;
    }
  }

  Future<String> generateUniqueLibraryCardNumber() async {
    String cardNumber = '';
    bool isUnique = false;

    while (!isUnique) {
      cardNumber = _generateRandom14DigitNumber();
      isUnique = await isLibraryCardNumberUnique(cardNumber);
    }

    return cardNumber;
  }

  String _generateRandom14DigitNumber() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 14; i++) {
      number += random.nextInt(10).toString();
    }
    return number;
  }

  Future<void> registerUser(User user) async {
    try {
      
      final response = await http.post(
        Uri.parse("http://127.0.0.1/UsersDb/register.php"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );
      print("response.body ${response.body}");
      if (response.statusCode == 201) {
        // Successfully registered
        print('User registered successfully');
      } else {
        // Handle error
        print('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print("error register $e");
    }
  }

Future<String?> getDepartmentName(String departmentId) async {
  try {
    print("Fetching department name for ID: $departmentId");
    final response = await http.post(
      Uri.parse('http://127.0.0.1/UsersDb/departments.php'),
      body: {'DepartmentId': departmentId},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Department name fetched successfully: ${data['DepartmentName']}");
      return data['DepartmentName'];
    } else {
      print("Error fetching department name: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception while fetching department name: $e");
    return null;
  }
}

Future<String?> getCourseName(String courseId) async {
  try {
    print("Fetching course name for ID: $courseId");
    final response = await http.post(
      Uri.parse('http://127.0.0.1/UsersDb/courses.php'),
      body: {'CourseId': courseId},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Course name fetched successfully: ${data['CourseName']}");
      return data['CourseName'];
    } else {
      print("Error fetching course name: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception while fetching course name: $e");
    return null;
  }
}


  void showLoading() {
    isLoading = true;
    notifyListeners();
  }
}
