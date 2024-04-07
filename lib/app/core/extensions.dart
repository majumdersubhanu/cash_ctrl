import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension BuildContextEntension<T> on BuildContext {
  showSnackbar(String title, String message) {
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

  showWorkInProgress() =>
      showSnackbar('WIP', 'Hey there, 👋 we\'re working to get this up ASAP');
}
