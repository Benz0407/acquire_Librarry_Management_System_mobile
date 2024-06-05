// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:acquire_lms_mobile_app/models/user_model.dart' as _i16;
import 'package:acquire_lms_mobile_app/screens/admin_book_detail_screen.dart'
    as _i1;
import 'package:acquire_lms_mobile_app/screens/book_collection_screen.dart'
    as _i4;
import 'package:acquire_lms_mobile_app/screens/book_detail_screen.dart' as _i2;
import 'package:acquire_lms_mobile_app/screens/catalog_screen.dart' as _i3;
import 'package:acquire_lms_mobile_app/screens/generate_library_card_screen.dart'
    as _i5;
import 'package:acquire_lms_mobile_app/screens/login_page.dart' as _i6;
import 'package:acquire_lms_mobile_app/screens/modify_book_screen.dart' as _i7;
import 'package:acquire_lms_mobile_app/screens/not_found_screen.dart' as _i8;
import 'package:acquire_lms_mobile_app/screens/otp_screen.dart' as _i9;
import 'package:acquire_lms_mobile_app/screens/record_book_screen.dart' as _i10;
import 'package:acquire_lms_mobile_app/screens/record_book_search.dart' as _i12;
import 'package:acquire_lms_mobile_app/screens/register_screen.dart' as _i11;
import 'package:acquire_lms_mobile_app/screens/send_otp.dart' as _i13;
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:email_otp/email_otp.dart' as _i17;
import 'package:flutter/material.dart' as _i15;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AdminBookDetailsScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdminBookDetailsScreenArgs>(
          orElse: () => AdminBookDetailsScreenArgs(
              bookId: pathParams.optString('bookId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AdminBookDetailsScreen(
          key: args.key,
          bookId: args.bookId,
        ),
      );
    },
    BookDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookDetailScreenArgs>(
          orElse: () =>
              BookDetailScreenArgs(bookId: pathParams.optString('bookId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BookDetailScreen(
          key: args.key,
          bookId: args.bookId,
        ),
      );
    },
    CatalogScreen.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CatalogScreen(),
      );
    },
    CollectionScreen.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CollectionScreen(),
      );
    },
    LibraryCardScreen.name: (routeData) {
      final args = routeData.argsAs<LibraryCardScreenArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LibraryCardScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
    ModifyBookScreen.name: (routeData) {
      final args = routeData.argsAs<ModifyBookScreenArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ModifyBookScreen(
          key: args.key,
          bookId: args.bookId,
        ),
      );
    },
    NotFoundScreen.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.NotFoundScreen(),
      );
    },
    Otp.name: (routeData) {
      final args = routeData.argsAs<OtpArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.Otp(
          key: args.key,
          otpController: args.otpController,
        ),
      );
    },
    OtpScreen.name: (routeData) {
      final args = routeData.argsAs<OtpScreenArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.OtpScreen(
          key: args.key,
          myauth: args.myauth,
          schoolId: args.schoolId,
        ),
      );
    },
    RecordBookRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RecordBookPage(),
      );
    },
    RegistrationFormScreen.name: (routeData) {
      final args = routeData.argsAs<RegistrationFormScreenArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.RegistrationFormScreen(
          key: args.key,
          userDetails: args.userDetails,
        ),
      );
    },
    SearchAddBook.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SearchAddBook(),
      );
    },
    SendEmailOtp.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SendEmailOtp(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminBookDetailsScreen]
class AdminBookDetailsScreen
    extends _i14.PageRouteInfo<AdminBookDetailsScreenArgs> {
  AdminBookDetailsScreen({
    _i15.Key? key,
    String? bookId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          AdminBookDetailsScreen.name,
          args: AdminBookDetailsScreenArgs(
            key: key,
            bookId: bookId,
          ),
          rawPathParams: {'bookId': bookId},
          initialChildren: children,
        );

  static const String name = 'AdminBookDetailsScreen';

  static const _i14.PageInfo<AdminBookDetailsScreenArgs> page =
      _i14.PageInfo<AdminBookDetailsScreenArgs>(name);
}

class AdminBookDetailsScreenArgs {
  const AdminBookDetailsScreenArgs({
    this.key,
    this.bookId,
  });

  final _i15.Key? key;

  final String? bookId;

  @override
  String toString() {
    return 'AdminBookDetailsScreenArgs{key: $key, bookId: $bookId}';
  }
}

/// generated route for
/// [_i2.BookDetailScreen]
class BookDetailScreen extends _i14.PageRouteInfo<BookDetailScreenArgs> {
  BookDetailScreen({
    _i15.Key? key,
    String? bookId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          BookDetailScreen.name,
          args: BookDetailScreenArgs(
            key: key,
            bookId: bookId,
          ),
          rawPathParams: {'bookId': bookId},
          initialChildren: children,
        );

  static const String name = 'BookDetailScreen';

  static const _i14.PageInfo<BookDetailScreenArgs> page =
      _i14.PageInfo<BookDetailScreenArgs>(name);
}

class BookDetailScreenArgs {
  const BookDetailScreenArgs({
    this.key,
    this.bookId,
  });

  final _i15.Key? key;

  final String? bookId;

  @override
  String toString() {
    return 'BookDetailScreenArgs{key: $key, bookId: $bookId}';
  }
}

/// generated route for
/// [_i3.CatalogScreen]
class CatalogScreen extends _i14.PageRouteInfo<void> {
  const CatalogScreen({List<_i14.PageRouteInfo>? children})
      : super(
          CatalogScreen.name,
          initialChildren: children,
        );

  static const String name = 'CatalogScreen';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CollectionScreen]
class CollectionScreen extends _i14.PageRouteInfo<void> {
  const CollectionScreen({List<_i14.PageRouteInfo>? children})
      : super(
          CollectionScreen.name,
          initialChildren: children,
        );

  static const String name = 'CollectionScreen';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LibraryCardScreen]
class LibraryCardScreen extends _i14.PageRouteInfo<LibraryCardScreenArgs> {
  LibraryCardScreen({
    _i15.Key? key,
    required _i16.User user,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LibraryCardScreen.name,
          args: LibraryCardScreenArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'LibraryCardScreen';

  static const _i14.PageInfo<LibraryCardScreenArgs> page =
      _i14.PageInfo<LibraryCardScreenArgs>(name);
}

class LibraryCardScreenArgs {
  const LibraryCardScreenArgs({
    this.key,
    required this.user,
  });

  final _i15.Key? key;

  final _i16.User user;

  @override
  String toString() {
    return 'LibraryCardScreenArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ModifyBookScreen]
class ModifyBookScreen extends _i14.PageRouteInfo<ModifyBookScreenArgs> {
  ModifyBookScreen({
    _i15.Key? key,
    required String bookId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ModifyBookScreen.name,
          args: ModifyBookScreenArgs(
            key: key,
            bookId: bookId,
          ),
          initialChildren: children,
        );

  static const String name = 'ModifyBookScreen';

  static const _i14.PageInfo<ModifyBookScreenArgs> page =
      _i14.PageInfo<ModifyBookScreenArgs>(name);
}

class ModifyBookScreenArgs {
  const ModifyBookScreenArgs({
    this.key,
    required this.bookId,
  });

  final _i15.Key? key;

  final String bookId;

  @override
  String toString() {
    return 'ModifyBookScreenArgs{key: $key, bookId: $bookId}';
  }
}

/// generated route for
/// [_i8.NotFoundScreen]
class NotFoundScreen extends _i14.PageRouteInfo<void> {
  const NotFoundScreen({List<_i14.PageRouteInfo>? children})
      : super(
          NotFoundScreen.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundScreen';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i9.Otp]
class Otp extends _i14.PageRouteInfo<OtpArgs> {
  Otp({
    _i15.Key? key,
    required _i15.TextEditingController otpController,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          Otp.name,
          args: OtpArgs(
            key: key,
            otpController: otpController,
          ),
          initialChildren: children,
        );

  static const String name = 'Otp';

  static const _i14.PageInfo<OtpArgs> page = _i14.PageInfo<OtpArgs>(name);
}

class OtpArgs {
  const OtpArgs({
    this.key,
    required this.otpController,
  });

  final _i15.Key? key;

  final _i15.TextEditingController otpController;

  @override
  String toString() {
    return 'OtpArgs{key: $key, otpController: $otpController}';
  }
}

/// generated route for
/// [_i9.OtpScreen]
class OtpScreen extends _i14.PageRouteInfo<OtpScreenArgs> {
  OtpScreen({
    _i15.Key? key,
    required _i17.EmailOTP myauth,
    required String schoolId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          OtpScreen.name,
          args: OtpScreenArgs(
            key: key,
            myauth: myauth,
            schoolId: schoolId,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpScreen';

  static const _i14.PageInfo<OtpScreenArgs> page =
      _i14.PageInfo<OtpScreenArgs>(name);
}

class OtpScreenArgs {
  const OtpScreenArgs({
    this.key,
    required this.myauth,
    required this.schoolId,
  });

  final _i15.Key? key;

  final _i17.EmailOTP myauth;

  final String schoolId;

  @override
  String toString() {
    return 'OtpScreenArgs{key: $key, myauth: $myauth, schoolId: $schoolId}';
  }
}

/// generated route for
/// [_i10.RecordBookPage]
class RecordBookRoute extends _i14.PageRouteInfo<void> {
  const RecordBookRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RecordBookRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordBookRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RegistrationFormScreen]
class RegistrationFormScreen
    extends _i14.PageRouteInfo<RegistrationFormScreenArgs> {
  RegistrationFormScreen({
    _i15.Key? key,
    required Map<String, dynamic> userDetails,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          RegistrationFormScreen.name,
          args: RegistrationFormScreenArgs(
            key: key,
            userDetails: userDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationFormScreen';

  static const _i14.PageInfo<RegistrationFormScreenArgs> page =
      _i14.PageInfo<RegistrationFormScreenArgs>(name);
}

class RegistrationFormScreenArgs {
  const RegistrationFormScreenArgs({
    this.key,
    required this.userDetails,
  });

  final _i15.Key? key;

  final Map<String, dynamic> userDetails;

  @override
  String toString() {
    return 'RegistrationFormScreenArgs{key: $key, userDetails: $userDetails}';
  }
}

/// generated route for
/// [_i12.SearchAddBook]
class SearchAddBook extends _i14.PageRouteInfo<void> {
  const SearchAddBook({List<_i14.PageRouteInfo>? children})
      : super(
          SearchAddBook.name,
          initialChildren: children,
        );

  static const String name = 'SearchAddBook';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SendEmailOtp]
class SendEmailOtp extends _i14.PageRouteInfo<void> {
  const SendEmailOtp({List<_i14.PageRouteInfo>? children})
      : super(
          SendEmailOtp.name,
          initialChildren: children,
        );

  static const String name = 'SendEmailOtp';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
