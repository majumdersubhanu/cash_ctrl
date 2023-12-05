import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:fit_sync_plus/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginForm = FormGroup({
    "email": FormControl<String>(validators: [
      Validators.email,
      Validators.required,
    ]),
    "password": FormControl<String>(validators: [
      Validators.required,
    ]),
  });

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
          formGroup: _loginForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LargeHeading(
                  label: "Login",
                ),
                const MediumSemiBoldHeading(label: "Welcome back to CashCtrl"),
                const SizedBox(height: 50),
                ReactiveTextField(
                  formControlName: "email",
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    icon: Icon(Icons.email),
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
                    labelText: "Password",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(iconVisibilityMap[isObscure]),
                      onPressed: () => toggleVisibility(),
                    ),
                  ),
                  validationMessages: {
                    "required": (error) => "Password can't be empty",
                  },
                ),
                const SizedBox(height: 20),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularTextButton(
                      label: "Forgot Password?",
                      onTap: () =>
                          context.router.push(const ForgotPasswordRoute()),
                    ),
                    RegularTextButton(
                      label: "New user? Register here",
                      onTap: () => context.router.push(const RegisterRoute()),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                RegularButton(
                  label: "Login with Email & Password",
                  onTap: () => _loginForm.valid
                      ? onLoginButtonPressed(_loginForm.value)
                      : _loginForm.markAllAsTouched(),
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

  void showSuccessMessage() {
    // Implement how the success message should be shown to the user
    // For example, show a snack bar, navigate to the home screen, etc.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showError(String message) {
    // Implement how the error message should be shown to the user
    // For example, show an alert dialog, display a message on the screen, etc.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  onLoginButtonPressed(Map<String, Object?> value) {
    context.router.replace(LandingRoute());
  }
}
