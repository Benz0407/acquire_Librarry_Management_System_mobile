import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: BookDetailScreen.page,  path: "/book-detail-screen/:bookId"),
    AutoRoute(page: NotFoundScreen.page, path: "*"),
    AutoRoute(page: CollectionScreen.page, path: "/collection"),
    AutoRoute(page: RecordBookRoute.page, path: "/recordbook"), 
    AutoRoute(page: LibraryCardScreen.page, path: "/librarycard"),
    AutoRoute(page: RegistrationFormScreen.page, path: "/register"),
    AutoRoute(page: CatalogScreen.page, path: "/catalog"),
    AutoRoute(page: AdminBookDetailsScreen.page, path: "/admin-book-detail-screen/:bookId"), 
    AutoRoute(page: ModifyBookScreen.page, path: "/admin-modify-book-screen/:bookId"), 
    AutoRoute(page: OtpScreen.page, path: "/otp/:myauth/:schoolId"), 
    AutoRoute(page: SendEmailOtp.page, path: "/send-otp"), 
   



  ];  
  
}

