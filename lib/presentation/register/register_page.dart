import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/auth/auth_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FormGroup _formGroup = FormGroup({
    'username': FormControl<String>(
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
      validators: [],
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

  bool isObscure = true;

  final visibilityIconMap = const {
    true: Ionicons.eye_off_outline,
    false: Ionicons.eye_outline,
  };

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
                  'Register',
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Hey there 👋, welcome to CashCtrl',
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField(
                  formControlName: 'username',
                  autofillHints: const [
                    AutofillHints.name,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'johnDoe123',
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
                    hintText: 'Enter a password',
                  ),
                  enableSuggestions: true,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Password can not be empty',
                    ValidationMessage.minLength: (error) =>
                        'Password must be at least 8 characters long',
                    ValidationMessage.pattern: (error) => 'Password is too weak'
                  },
                ),
                const Gap(10),
                PasswordCriteriaWidget(
                    passwordControl:
                        _formGroup.control('password') as FormControl<String>),
                const Gap(20),
                ReactiveTextField(
                  formControlName: 'confirm_password',
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  obscureText: isObscure,
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

  _handleSubmit(BuildContext context, Map<String, Object?> formValue) async {
    await context.read<AuthProvider>().register(context, {
      "username": formValue['username'],
      "phone_number": formValue['phone_number'],
      "email": formValue['email'],
      "password": formValue['password'],
    });
  }

  toggleVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}

class PasswordCriteriaWidget extends StatefulWidget {
  final FormControl<String> passwordControl;

  const PasswordCriteriaWidget({super.key, required this.passwordControl});

  @override
  State<PasswordCriteriaWidget> createState() => _PasswordCriteriaWidgetState();
}

class _PasswordCriteriaWidgetState extends State<PasswordCriteriaWidget> {
  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<String>(
      formControl: widget.passwordControl,
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
          color: isValid ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
