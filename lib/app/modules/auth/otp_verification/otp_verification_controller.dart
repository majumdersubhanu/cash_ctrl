import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class OtpVerificationController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> otpVerification(BuildContext context,
      Map<String, Object?> formValue, String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Get.snackbar("OTP", '123456');

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve verification code
        await auth
            .signInWithCredential(credential)
            .then((value) => Get.offAllNamed(Routes.BASE_PAGE));
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Save the verification ID for future use
        String smsCode = formValue['otp'].toString(); // Code input by the user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        // Sign the user in with the credential
        await auth
            .signInWithCredential(credential)
            .then((value) => Get.offAllNamed(Routes.BASE_PAGE));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }
}
