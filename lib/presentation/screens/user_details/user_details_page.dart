import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/widgets/button_widgets.dart';
import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:fit_sync_plus/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _profileForm = FormGroup({
    "name": FormControl<String>(validators: [
      Validators.required,
    ]),
    "monthlyIncome": FormControl<int>(validators: [
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
          formGroup: _profileForm,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LargeHeading(
                  label: "Profile",
                ),
                const MediumSemiBoldHeading(
                    label: "Please fill in these details to continue"),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: ,
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ReactiveTextField(
                  formControlName: "name",
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Full Name",
                  ),
                  validationMessages: {
                    "required": (error) => "Name can't be empty",
                  },
                ),
                const SizedBox(height: 20),
                ReactiveTextField(
                  formControlName: "monthlyIncome",
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money),
                    labelText: "Monthly Income",
                  ),
                  keyboardType: TextInputType.number,
                  validationMessages: {
                    "required": (error) => "Monthly income can't be empty",
                  },
                ),
                const SizedBox(height: 40),
                RegularButton(
                  label: "Continue",
                  onTap: () => _profileForm.valid
                      ? onProfileCompletionButtonPressed(_profileForm.value)
                      : _profileForm.markAllAsTouched(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onProfileCompletionButtonPressed(Map<String, Object?> value) {
    context.router.replace(const LandingRoute());
  }
}
