import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/extensions.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final FormGroup _formGroup = FormGroup({
    'display_name': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'phone_number': FormControl<String>(
      validators: [
        // Validators.pattern(
        //     r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$"),
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
        Validators.pattern(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"),
      ],
    ),
    'confirm_password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),
  }, validators: [
    Validators.mustMatch('password', 'confirm_password'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
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
                  'Register',
                  style: context.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Hey there 👋, welcome to CashCtrl',
                  style: context.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'display_name',
                  autofillHints: const [
                    AutofillHints.name,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'John Doe',
                    prefixIcon: Icon(Ionicons.person_circle_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Name can not be empty',
                  },
                ),
                const Gap(20),
                ReactiveTextField(
                  formControlName: 'email',
                  autofillHints: const [
                    AutofillHints.email,
                  ],
                  keyboardType: TextInputType.emailAddress,
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
                const Gap(20),
                ReactiveTextField(
                  formControlName: 'phone_number',
                  autofillHints: const [
                    AutofillHints.telephoneNumber,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '+91 1234567890',
                    prefixIcon: Icon(Ionicons.call_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.pattern: (error) =>
                        'Please enter a valid phone number',
                    ValidationMessage.required: (error) =>
                        'Phone number can not be empty',
                  },
                ),
                const Gap(20),
                Obx(
                  () => ReactiveTextField(
                    formControlName: 'password',
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                    obscureText: controller.visible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Ionicons.lock_open_outline),
                      suffixIcon: IconButton(
                        onPressed: () => controller.toggleVisibility(),
                        icon: Icon(controller
                            .visibilityIconMap[controller.visible.value]),
                      ),
                      hintText: 'Enter a password',
                    ),
                    enableSuggestions: true,
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Password can not be empty',
                      ValidationMessage.minLength: (error) =>
                          'Password must be at least 8 characters long',
                      ValidationMessage.pattern: (error) =>
                          'Password is too weak'
                    },
                  ),
                ),
                const Gap(10),
                PasswordCriteriaWidget(
                    passwordControl:
                        _formGroup.control('password') as FormControl<String>),
                const Gap(20),
                Obx(
                  () => ReactiveTextField(
                    formControlName: 'confirm_password',
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                    obscureText: controller.visible.value,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Ionicons.lock_open_outline),
                        hintText: 'Enter password again'),
                    enableSuggestions: true,
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Password can not be empty',
                      ValidationMessage.mustMatch: (error) =>
                          'Passwords must match'
                    },
                  ),
                ),
                const Gap(40),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formGroup.valid) {
                      _handleSubmit(context, _formGroup.value);
                    } else {
                      _formGroup.markAllAsTouched();
                    }
                  },
                  label: const Text('Register with Email'),
                  icon: const Icon(Ionicons.mail),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context, Map<String, Object?> formValue) {
    controller.register(context, formValue);
  }
}

class PasswordCriteriaWidget extends StatelessWidget {
  final FormControl<String> passwordControl;

  const PasswordCriteriaWidget({super.key, required this.passwordControl});

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<String>(
      formControl: passwordControl,
      builder: (context, control, child) {
        final password = control.value ?? '';
        final hasUppercase = password.contains(RegExp(r'[A-Z]'));
        final hasDigits = password.contains(RegExp(r'\d'));
        final hasLowercase = password.contains(RegExp(r'[a-z]'));
        final isAtLeast8Chars = password.length >= 8;
        final hasSpecialChar =
            password.contains(RegExp(r'(?=.*?[#?!@$%^&*-])'));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCriteriaRow('At least 8 characters', isAtLeast8Chars),
            _buildCriteriaRow('Contains a number', hasDigits),
            _buildCriteriaRow('Contains a special character', hasSpecialChar),
            _buildCriteriaRow('Contains an uppercase letter', hasUppercase),
            _buildCriteriaRow('Contains a lowercase letter', hasLowercase),
          ],
        );
      },
    );
  }

  Widget _buildCriteriaRow(String label, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Ionicons.checkbox : Ionicons.square_outline,
          color: isValid ? Get.theme.colorScheme.primary : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
