import 'dart:convert';

import 'package:acquire_lms_mobile_app/models/user_model.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/app_bar_widget.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class LibraryCardScreen extends StatelessWidget {
  final User user;
  const LibraryCardScreen({super.key, required this.user});

  String getCombinedName(User user) {
    String middleInitial =
        user.middleName != null && user.middleName!.isNotEmpty
            ? '${user.middleName![0]}.'
            : '';
    String suffix =
        user.suffix != null && user.suffix!.isNotEmpty ? ' ${user.suffix}' : '';
    return '${user.firstName} $middleInitial. ${user.lastName} $suffix.';
  }

  String encodeUserData(User user) {
    final userData = {
      'LibraryCardNumber': user.libraryCardNumber,
      'SchoolIdNumber': user.schoolIdNumber,
      'Name': getCombinedName(user),
      'Department': user.department,
      'Course': user.course,
      'ContactNumber': user.contactNumber,
      'EmailAddress': user.emailAddress,
      'AccountType': user.accountType
          .toString(), // Converting account type to string for QR code
    };
    return jsonEncode(userData);
  }

  @override
  Widget build(BuildContext context) {
    final qrData = encodeUserData(user);
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
           context.back(); 
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
        title: const Row(
          children: [
            AcquireTitle(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            verticalSpacing(16),
            const ScreenHeader(headerText: 'How to use your Library Card'),
            const SizedBox(height: 8),
            const Text(
              'Your library card serves as your official identification for accessing library resources.\n\n'
              'Please follow these instructions:\n'
              '1. Present your library card at the library entrance.\n'
              '2. Ensure that your library card is visible when borrowing library materials.\n'
              '3. For any issues with your library card, contact the library help desk.\n\n'
              'To download your library card for digital use, click the "Download Library Card" button below.',
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 343,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.red,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/Logo.png',
                                    height: 50,
                                  ),
                                  const SizedBox(width: 8),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Library Card',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'League Spartan',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      Text(
                                        'University of Nueva Caceres',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontFamily: 'League Spartan',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 10.0, 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Student ID',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'League Spartan',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    user.schoolIdNumber!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.libraryCardNumber,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${getCombinedName(user)}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Department: ${user.department}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Course: ${user.course}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Contact Number: ${user.contactNumber}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          Text(
                            "Email Address: ${user.emailAddress}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // _downloadLibraryCard(context);
              },
              child: const Text('Download Library Card'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                // Implement sign in functionality
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
