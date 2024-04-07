import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/extensions.dart';
import '../../../routes/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final FormGroup _formGroup = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'password': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        const Text("First time at Cash Ctrl?"),
        TextButton(
          onPressed: () => Get.toNamed(Routes.REGISTER),
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
                  style: Get.theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Hey there 👋, welcome back',
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
                const Gap(20),
                Obx(() => ReactiveTextField(
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
                      ),
                      enableSuggestions: true,
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Password can not be empty',
                      },
                    )),
                const Gap(20),
                ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  buttonAlignedDropdown: true,
                  layoutBehavior: ButtonBarLayoutBehavior.padded,
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        child: const Text('Forgot Password?')),
                  ],
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
                  label: const Text('Login with Email'),
                  icon: const Icon(Ionicons.mail),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleSubmit(BuildContext context, Map<String, Object?> formValue) {
    controller.login(context, formValue);
  }
}
