import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpProvider with ChangeNotifier {

  Future<String?> getDepartmentName(String departmentId) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1/UsersDb/departments.php'),
        body: {'DepartmentId': departmentId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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
      final response = await http.post(
        Uri.parse('http://127.0.0.1/UsersDb/courses.php'),
        body: {'CourseId': courseId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
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


  Future<String?> getEmailFromSchoolId(String schoolId) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1/UsersDb/get_email.php'),
      body: {'schoolId': schoolId},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['email'];
    } else {
      print("Error fetching email: ${response.body}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String schoolId) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1/UsersDb/get_user_details.php'),
      body: {'schoolId': schoolId},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['error'] != null) {
        print("Error fetching user details: ${data['error']}");
        return null;
      }

      final departmentName = await getDepartmentName(data['Department'].toString());
      final courseName = await getCourseName(data['Course'].toString());
      data['departmentName'] = departmentName;
      data['courseName'] = courseName;
      return data;
    } else {
      print("Error fetching user details: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Exception while fetching user details: $e");
    return null;
  }
}

}
