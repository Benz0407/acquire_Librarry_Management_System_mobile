import 'package:acquire_lms_mobile_app/config/app_router.gr.dart';
import 'package:acquire_lms_mobile_app/models/user_model.dart';
import 'package:acquire_lms_mobile_app/provider/login_provider.dart';
import 'package:acquire_lms_mobile_app/utils/spaces.dart';
import 'package:acquire_lms_mobile_app/widgets/screen_title_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:url_launcher/url_launcher.dart';
@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final librarycardnumber = TextEditingController();
  final password = TextEditingController();

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  //We have to create global key for our form
  final _formKey = GlobalKey<FormState>();
  late LoginProvider _loginProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginProvider = Provider.of<LoginProvider>(context);
  }

  Future<bool> _logInUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        libraryCardNumber: librarycardnumber.text,
        password: password.text,
      );

      try {
        final success = await _loginProvider.loginUser(user);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged in successfully')),
          );
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Credentials')),
          );
          return false;
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login user: $error')),
        );
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 125,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/bookmark-5-128.png'),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              verticalSpacing(50),
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
              verticalSpacing(75),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenHeader(headerText: "Login"),
                ],
              ),
              verticalSpacing(50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(.2)),
                      child: TextFormField(
                        controller: librarycardnumber,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Library Card Number is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.library_books),
                          border: InputBorder.none,
                          hintText: "Library Card Number",
                        ),
                      ),
                    ),

                    //Password field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.withOpacity(.2)),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //In here we will create a click to show and hide the password a toggle button
                                  setState(() {
                                    //toggle button
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),

                    const SizedBox(height: 10),
                    //Login button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool success = await _logInUser();
                              if (success) {
                                context.router.replace(const CatalogScreen());
                              }
                            }
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          )),
                    ),

                    //Sign up button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              context.pushRoute(const SendEmailOtp());
                            },
                            child: const Text("SIGN UP", style: TextStyle(color: Colors.red),))
                      ],
                    ),

                    // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                    isLoginTrue
                        ? const Text(
                            "Username or passowrd is incorrect",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
