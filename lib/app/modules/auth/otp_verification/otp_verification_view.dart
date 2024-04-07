import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  OtpVerificationView({super.key});

  final FormGroup _formGroup = FormGroup({
    'otp': FormControl<String>(
      validators: [
        Validators.required,
        Validators.number,
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
                  'Otp Verification',
                  style: Get.theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Enter the OTP sent via sms',
                  style: Get.theme.textTheme.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'otp',
                  autofillHints: const [
                    AutofillHints.oneTimeCode,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    hintText: 'Enter the sms code',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'OTP can not be empty',
                  },
                  keyboardType: TextInputType.number,
                ),
                const Gap(40),
                ElevatedButton(
                    onPressed: () {
                      if (_formGroup.valid) {
                        String phoneNumber = Get.arguments;
                        _handleSubmit(context, _formGroup.value, phoneNumber);
                      } else {
                        _formGroup.markAllAsTouched();
                      }
                    },
                    child: const Text('Verify OTP')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context, Map<String, Object?> formValue,
      String phoneNumber) {
    controller.otpVerification(context, formValue, phoneNumber);
  }
}
