import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _passwordResetForm = FormGroup({
    "email": FormControl<String>(validators: [
      Validators.email,
      Validators.required,
    ]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CashCtrl"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: _passwordResetForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LargeHeading(
                  label: "Forgot Password",
                ),
                const MediumSemiBoldHeading(
                    label: "Please enter your registered email address"),
                const SizedBox(height: 50),
                ReactiveTextField(
                  formControlName: "email",
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email Address",
                  ),
                  validationMessages: {
                    "required": (error) => "Email address can't be empty",
                    "email": (error) => "Please enter a valid email address",
                  },
                ),
                const SizedBox(height: 40),
                RegularButton(
                  label: "Send Password reset link",
                  onTap: () => _passwordResetForm.valid
                      ? onPasswordResetButtonPressed(_passwordResetForm.value)
                      : _passwordResetForm.markAllAsTouched(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPasswordResetButtonPressed(Map<String, Object?> value) {}
}
