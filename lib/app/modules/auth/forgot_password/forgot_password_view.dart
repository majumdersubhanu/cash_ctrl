import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/extensions.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({super.key});

  final FormGroup _formGroup = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          primary: true,
          child: ReactiveForm(
            formGroup: _formGroup,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              textDirection: TextDirection.ltr,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  'Reset',
                  style: Get.theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Don\'t worry, we\'ll send you a password reset link',
                  style: Get.theme.textTheme.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'email',
                  autofillHints: const [
                    AutofillHints.email,
                    AutofillHints.telephoneNumber,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'john.doe@xyz.com',
                    prefixIcon: Icon(Ionicons.mail_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.email: (error) =>
                        'Please enter a valid email',
                    ValidationMessage.required: (error) =>
                        'Email can not be empty',
                  },
                ),
                const Gap(40),
                ElevatedButton(
                    onPressed: () => _handleSubmit(context, _formGroup.value),
                    child: const Text('Send password reset link'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context, Map<String, Object?> value) {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: value['email'].toString())
        .whenComplete(() {
      context.showSnackbar(
          'Email Sent', 'Password reset email has been sent to your email');
    });

    Get.back();
  }
}
