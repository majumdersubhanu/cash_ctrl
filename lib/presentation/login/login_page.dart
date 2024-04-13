import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/auth/auth_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FormGroup _formGroup = FormGroup({
    'login': FormControl<String>(
      validators: [
        Validators.required,
        // Validators.composeOR([
        //   Validators.pattern(r"^[+]{1}(?:[0-9\-\(\)\/\.]\s?){6, 15}[0-9]{1}$"),
        //   Validators.email,
        // ]),
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  bool isObscure = true;

  final visibilityIconMap = const {
    true: Ionicons.eye_off_outline,
    false: Ionicons.eye_outline,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        const Text("First time at Cash Ctrl?"),
        TextButton(
          onPressed: () => context.pushRoute(RegisterRoute()),
          child: const Text('Register now!'),
        )
      ],
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
                  'Login',
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Hey there 👋, welcome back',
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'login',
                  autofillHints: const [
                    AutofillHints.email,
                    AutofillHints.telephoneNumber,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Email or Phone Number',
                    hintText: 'Enter your email address or phone number',
                    prefixIcon: Icon(Ionicons.person_circle_outline),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Credential can not be empty',
                  },
                ),
                const Gap(20),
                ReactiveTextField(
                  formControlName: 'password',
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Ionicons.lock_open_outline),
                    suffixIcon: IconButton(
                      onPressed: () => toggleVisibility(),
                      icon: Icon(visibilityIconMap[isObscure]),
                    ),
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Password can not be empty',
                  },
                ),
                const Gap(20),
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  buttonAlignedDropdown: true,
                  layoutBehavior: ButtonBarLayoutBehavior.padded,
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () =>
                            context.pushRoute(ForgotPasswordRoute()),
                        child: const Text('Forgot Password?')),
                  ],
                ),
                const Gap(40),
                ElevatedButton.icon(
                  onPressed: () {
                    if (!_formGroup.valid) {
                      _formGroup.markAllAsTouched();
                    } else {
                      _handleSubmit(_formGroup.value);
                    }
                  },
                  label: context.watch<AuthProvider>().loginStatus ==
                          LoginStatus.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Login with Email",
                        ),
                  icon: const Icon(Ionicons.mail),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(Map<String, dynamic> formValue) async {
    await context.read<AuthProvider>().login(context, {
      "login": formValue['login'],
      "password": formValue['password'],
    });
  }

  toggleVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}
