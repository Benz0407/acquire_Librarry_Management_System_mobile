import 'package:acquire_lms_mobile_app/config/app_router.dart';
import 'package:acquire_lms_mobile_app/helpers/url_strategy_non_web_helper.dart';
import 'package:acquire_lms_mobile_app/provider/book_provider.dart';
import 'package:acquire_lms_mobile_app/provider/home_provider.dart';
import 'package:acquire_lms_mobile_app/provider/login_provider.dart';
import 'package:acquire_lms_mobile_app/provider/otp_provider.dart';
import 'package:acquire_lms_mobile_app/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setUrlWithoutHashTag();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => BooksProvider()), 
        ChangeNotifierProvider(create: (_) => OtpProvider()),
      ],
      child: const AcquireApp(), 
    ),
  );
}

class AcquireApp extends StatelessWidget {
  const AcquireApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.red,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      title: "Acquire Library Management System",
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
