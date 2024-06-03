import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/user_model.dart';
import 'package:acquire_lms_mobile_app/provider/register_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/login_text_field.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<Map<String, dynamic>> roles = [
  {'name': 'LibraryAdmin', 'value': 1},
  {'name': 'Librarian', 'value': 2},
  {'name': 'Student Assistant', 'value': 3},
  {'name': 'Faculty', 'value': 4},
  {'name': 'Student', 'value': 5},
];

@RoutePage()
class RegistrationFormScreen extends StatefulWidget {
  final Map<String, dynamic> userDetails;

  const RegistrationFormScreen({super.key, required this.userDetails});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  
  int? selectedRole;
  final libraryCardNumber = TextEditingController();
  final schoolIdNumber = TextEditingController();
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final suffix = TextEditingController();
  final department = TextEditingController();
  final course = TextEditingController();
  final contactNumber = TextEditingController();
  final emailAddress = TextEditingController();
  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _registerProvider = RegisterProvider();

  bool isVisible = false;

 

  @override
  void initState() {
    super.initState();
    _populateFormFields();
    _generateAndSetLibraryCardNumber();
  }

  Future<void> _populateFormFields() async {
    schoolIdNumber.text = widget.userDetails['SchoolId'] ?? '';
    firstName.text = widget.userDetails['FirstName'] ?? '';
    middleName.text = widget.userDetails['MiddleName'] ?? '';
    lastName.text = widget.userDetails['LastName'] ?? '';
    suffix.text = widget.userDetails['Suffix'] ?? '';
    department.text = widget.userDetails['departmentName'] ?? '';
    course.text = widget.userDetails['courseName'] ?? '';
    contactNumber.text = widget.userDetails['ContactNumber'] ?? '';
    emailAddress.text = widget.userDetails['EmailAdd'] ?? '';
  }

  Future<void> _generateAndSetLibraryCardNumber() async {
    await Future.delayed(Duration.zero);
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    String cardNumber = await provider.generateUniqueLibraryCardNumber();
    setState(() {
      libraryCardNumber.text = cardNumber;
    });
  }

  void _registerUser() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        accountType: selectedRole,
        libraryCardNumber: libraryCardNumber.text,
        schoolIdNumber: schoolIdNumber.text,
        emailAddress: emailAddress.text,
        password: password.text,
        firstName: firstName.text,
        middleName: middleName.text,
        lastName: lastName.text,
        suffix: suffix.text,
        department: department.text,
        course: course.text,
        contactNumber: contactNumber.text,
      );

      _registerProvider.registerUser(user).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user: $error')),
        );
      });

      // Pass user details to the next screen
      context.router.push(LibraryCardScreen(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 125,
          leading: TextButton(
          onPressed: () {
           context.back(); 
          },
          child: const Text(
            'Back',
            style: TextStyle(color: Colors.red),
          ),
        ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/bookmark-5-128.png'),
            ],
          ),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 75,
                    child: Image.asset(
                      'assets/Logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  horizontalSpacing(25),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'A',
                              style: TextStyle(
                                color: Color(0xFFCC0000),
                                fontSize: 50,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'CQUIRE',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 50,
                                fontFamily: 'League Spartan',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
             const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenHeader(headerText: "Registration"),
                ],
              ),
              verticalSpacing(60),
              DropdownButtonFormField<int>(
                value: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
                items: roles.map<DropdownMenuItem<int>>((role) {
                  return DropdownMenuItem<int>(
                    value: role['value'] as int,
                    child: Text(role['name']),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: "Library Card",
                controller: libraryCardNumber,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'School ID Number',
                controller: schoolIdNumber,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'First Name',
                controller: firstName,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Middle Name',
                controller: middleName,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Last Name',
                controller: lastName,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Suffix',
                controller: suffix,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Department',
                controller: department,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Course',
                controller: course,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Contact Number',
                controller: contactNumber,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Email Address',
                controller: emailAddress,
                readOnly: true,
              ),
              verticalSpacing(16),
              CustomTextField(
                labelText: 'Password',
                controller: password,
                isPassword: true,
                validator: (value) {
                  return null;
                },
              ),
              verticalSpacing(16),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle checkbox state change
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to the User\'s Agreement.',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpacing(16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registerUser();
                     context.router.push(LibraryCardScreen(user: User.fromJson(widget.userDetails)));
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
