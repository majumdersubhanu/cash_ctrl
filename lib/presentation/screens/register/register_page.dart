import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:fit_sync_plus/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerForm = FormGroup({
    "email": FormControl<String>(validators: [
      Validators.email,
      Validators.required,
    ]),
    "password": FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(8),
    ]),
    "confirmPassword": FormControl<String>(validators: [
      Validators.required,
    ]),
  }, validators: [
    const MustMatchValidator("password", "confirmPassword", true),
  ]);

  bool isObscure = true;
  final iconVisibilityMap = {
    false: Icons.visibility,
    true: Icons.visibility_off,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CashCtrl"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: _registerForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LargeHeading(
                  label: "Register",
                ),
                const MediumSemiBoldHeading(label: "Welcome to CashCtrl"),
                const SizedBox(height: 50),
                ReactiveTextField(
                  formControlName: "email",
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email Address",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validationMessages: {
                    "required": (error) => "Email address can't be empty",
                    "email": (error) => "Please enter a valid email address",
                  },
                ),
                const SizedBox(height: 20),
                ReactiveTextField(
                  formControlName: "password",
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(iconVisibilityMap[isObscure]),
                      onPressed: () => toggleVisibility(),
                    ),
                  ),
                  validationMessages: {
                    "required": (error) => "Password can't be empty",
                    "minLength": (error) =>
                        "Password can't be less than 8 characters",
                  },
                ),
                const SizedBox(height: 20),
                ReactiveTextField(
                  formControlName: "confirmPassword",
                  obscureText: isObscure,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    labelText: "Confirm Password",
                  ),
                  validationMessages: {
                    "required": (error) => "Password can't be empty",
                    "mustMatch": (error) => "Passwords do not match",
                  },
                ),
                const SizedBox(height: 20),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    RegularTextButton(
                      label: "Existing user? Login here",
                      onTap: () => context.router.popUntilRoot(),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                RegularButton(
                  label: "Register with Email & Password",
                  onTap: () => _registerForm.valid
                      ? onRegisterButtonPressed(_registerForm.value)
                      : _registerForm.markAllAsTouched(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  onRegisterButtonPressed(Map<String, Object?> value) {
    context.router.replace(const UserDetailsRoute());
  }
}
