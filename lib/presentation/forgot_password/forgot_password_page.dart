import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/auth/auth_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formGroup = FormGroup({
    'username': FormControl<String>(
      validators: [Validators.required],
    ),
    'new_password': FormControl<String>(
      validators: [Validators.required],
    ),
    'confirm_new_password': FormControl<String>(
      validators: [
        Validators.required,
        const MustMatchValidator(
          'new_password',
          'confirm_new_password',
          false,
        ),
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
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'username',
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    prefixIcon: Icon(Ionicons.person_circle_outline),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Username can not be empty',
                  },
                ),
                Gap(20),
                ReactiveTextField(
                  obscureText: true,
                  formControlName: 'new_password',
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter a new password',
                    prefixIcon: Icon(Ionicons.lock_open_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Password can not be empty',
                  },
                ),
                Gap(20),
                ReactiveTextField(
                  obscureText: true,
                  formControlName: 'confirm_new_password',
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter the password again',
                    prefixIcon: Icon(Ionicons.lock_open_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Password can not be empty',
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

  _handleSubmit(BuildContext context, Map<String, Object?> formValue) async {
    await context.read<AuthProvider>().resetPassword(context, formValue);
  }
}
