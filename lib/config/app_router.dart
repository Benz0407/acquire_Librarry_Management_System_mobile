import 'package:acquire_lms_mobile_app/provider/login_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'app_router.gr.dart';

class RoleGuard extends AutoRouteGuard {
  final List<String> allowedRoles;

  RoleGuard(this.allowedRoles);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final BuildContext context = router.navigatorKey.currentContext!;
    final loginProvider = context.read<LoginProvider>();
    if (allowedRoles.contains(loginProvider.userRole)) {
      resolver.next(true); // allow navigation
    } else {
      router.replace(const NotFoundScreen()); // redirect to NotFoundScreen
    }
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: BookDetailScreen.page,  path: "/book-detail-screen/:bookId"),
    AutoRoute(page: NotFoundScreen.page, path: "*"),
    AutoRoute(  
          page: CollectionScreen.page,
          path: "/collection",
          guards: [RoleGuard(['Librarian', 'Library Admin'])],
        ),
    AutoRoute(page: RecordBookRoute.page, path: "/recordbook"), 
    AutoRoute(page: LibraryCardScreen.page, path: "/librarycard"),
    AutoRoute(page: RegistrationFormScreen.page, path: "/register"),
    AutoRoute(page: CatalogScreen.page, path: "/catalog"),
    AutoRoute(page: AdminBookDetailsScreen.page, path: "/admin-book-detail-screen/:bookId"), 
    AutoRoute(page: ModifyBookScreen.page, path: "/admin-modify-book-screen/:bookId"), 
    AutoRoute(page: OtpScreen.page, path: "/otp/:myauth/:schoolId"), 
    AutoRoute(page: SendEmailOtp.page, path: "/send-otp"), 
    AutoRoute(page: SearchAddBook.page, path: "/searchAdd"), 
  ];  
  
}

