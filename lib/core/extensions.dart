import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        dismissDirection: DismissDirection.down,
      ),
    );
  }

  showWorkInProgress() => showSnackBar('Work In Progress');
}

extension BreakpointUtils on BoxConstraints {
  bool get isTablet => maxWidth > 730;

  bool get isDesktop => maxWidth > 1200;

  bool get isMobile => !isTablet && !isDesktop;
}

// Use them
extension DeviceTypeExtension on BuildContext {
  bool get isDesktop => MediaQuery.of(this).size.width > 600.0;

  bool get isMobile => MediaQuery.of(this).size.width <= 600.0;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension NullableStringExtensions<E> on String? {
  /// Returns `true` if this string is `null` or empty.
  bool get isNotOkay {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if this string is not `null` and not empty.
  bool get isOkay {
    return this?.isNotEmpty ?? false;
  }
}

/// To Check if request is success [DIO]
extension DioRequestStatus on Response {
  bool get ok => statusCode == 200 || statusCode == 204 || statusCode == 201;
}

extension TextThemeExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ColorExtensions on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;

  Color get secondaryHeaderColor => Theme.of(this).secondaryHeaderColor;

  Color get indicatorColor => Theme.of(this).indicatorColor;
}

extension StringExtension on String {
  String get toTitleCase {
    return split(RegExp('[_ ]'))
        .map((str) => str[0].toUpperCase() + str.substring(1).toLowerCase())
        .join(' ');
  }
}
