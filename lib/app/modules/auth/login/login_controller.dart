import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/extensions.dart';
import '../../../routes/app_pages.dart';
import '../../base_page/base_page_binding.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    alreadyLoggedIn();
  }

  RxBool visible = true.obs;

  final visibilityIconMap = const {
    true: Ionicons.eye_off_outline,
    false: Ionicons.eye_outline,
  };

  toggleVisibility() {
    visible.value = !(visible.value);
  }

  alreadyLoggedIn() {
    BasePageBinding().dependencies();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offNamed(Routes.BASE_PAGE);
      }
    });
  }

  login(BuildContext context, Map<String, Object?> formValue) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: formValue['email'].toString(),
        password: formValue['password'].toString(),
      )
          .then((value) {
        if (value.user != null) {
          context.showThemedSnackbar(
              'Hooray!', 'Welcome back, ${value.user?.displayName}');
          Get.offNamed(Routes.BASE_PAGE);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        context.showThemedSnackbar(
            'Aw snap!', 'We didn\'t find any user with those credentials');
      }
    }
  }
}
