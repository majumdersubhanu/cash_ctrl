import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          value.user?.updateDisplayName(formValue['display_name'].toString());

          value.user?.sendEmailVerification();

          if (formValue['phone_number'] != null) {
            Get.toNamed(Routes.OTP_VERIFICATION,
                arguments: formValue['phone_number'].toString());
          } else {
            context.showAwesomeSnackBar(
                'Hooray!',
                'Welcome to Cash Ctrl, ${value.user?.displayName.toString()}',
                ContentType.success);

            Get.offAllNamed(Routes.PROFILE_COMPLETION);
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        context.showAwesomeSnackBar('Oh oh!',
            'The password provided is too weak.', ContentType.warning);
      } else if (e.code == 'email-already-in-use') {
        context.showAwesomeSnackBar(
            'Oh oh!',
            'An account already exists for that email, please login',
            ContentType.failure);
      }
    } catch (e) {
      print(e);
    }
  }
}
