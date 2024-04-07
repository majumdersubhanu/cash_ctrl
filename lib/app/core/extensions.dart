import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

extension TextCapitalization on String {
  get capitalizeFirstOfEach =>
      split(" ").map((e) => e.capitalizeFirst).join(" ");
}
