import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

extension BuildContextEntension<T> on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  showThemedSnackbar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      snackStyle: SnackStyle.FLOATING,
      isDismissible: true,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset('assets/ic_launcher.png'),
      ),
    );
  }

  showWIP() => showThemedSnackbar(
      'WIP', 'Hey there, 👋 we\'re working to get this up ASAP');
}
