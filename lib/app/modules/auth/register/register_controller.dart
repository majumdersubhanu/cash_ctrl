import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/extensions.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool visible = true.obs;

  final visibilityIconMap = const {
    true: Icons.visibility_off,
    false: Icons.visibility,
  };

  toggleVisibility() {
    visible.value = !(visible.value);
  }

  Future<void> register(
      BuildContext context, Map<String, Object?> formValue) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth
          .createUserWithEmailAndPassword(
        email: formValue['email'].toString(),
        password: formValue['password'].toString(),
      )
          .then((value) async {
        if (value.user != null) {
          await value.user
              ?.updateDisplayName(formValue['display_name'].toString());

          value.user?.sendEmailVerification();

          if (formValue['phone_number'] != null) {
            Get.toNamed(Routes.OTP_VERIFICATION,
                arguments: formValue['phone_number'].toString());
          } else {
            context.showSnackbar('Hooray!',
                'Welcome to Cash Ctrl, ${formValue['display_name'].toString()}');

            Get.offAllNamed(Routes.PROFILE_COMPLETION);
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        context.showSnackbar('Oh oh!', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        context.showSnackbar(
            'Oh oh!', 'An account already exists for that email, please login');
      }
    } catch (e) {
      print(e);
    }
  }
}
