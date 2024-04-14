import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/profile_completion/profile_completion_provider.dart';
import 'package:cash_ctrl/application/user/user_provider.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/shared/widgets/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class ProfileCompletionPage extends StatelessWidget {
  ProfileCompletionPage({super.key});

  final FormGroup _formGroup = FormGroup({
    'full_name': FormControl<String>(validators: [Validators.required]),
    'date_of_birth': FormControl<String>(validators: [Validators.required]),
    'gender': FormControl<String>(),
    'current_address': FormControl<String>(),
    'nationality': FormControl<String>(),
    'job_title': FormControl<String>(),
    'company_name': FormControl<String>(),
    'employment_status': FormControl<String>(),
    'monthly_income': FormControl<String>(validators: [Validators.required]),
    'account_number': FormControl<String>(validators: [Validators.required]),
    'ifsc_code': FormControl<String>(validators: [Validators.required]),
    'bank_name': FormControl<String>(validators: [Validators.required]),
    'upi_id': FormControl<String>(validators: [Validators.required]),
    'pan_card': FormControl<String>(validators: [Validators.required]),
    'aadhaar_card': FormControl<String>(validators: [Validators.required]),
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
                  'Profile',
                  style: context.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  "We're almost there, just a bit more!",
                  style: context.textTheme.bodyLarge,
                ),
                const Gap(50),
                Consumer<ProfileCompletionProvider>(
                  builder: (BuildContext context,
                          ProfileCompletionProvider profileCompletionStatus,
                          Widget? child) =>
                      GestureDetector(
                    onTap: () => showImagePicker(context),
                    child: profileCompletionStatus.file != null
                        ? CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                profileCompletionStatus.file != null
                                    ? FileImage(profileCompletionStatus.file!)
                                    : null,
                          )
                        : RandomAvatar('saytoonz', height: 100, width: 100),
                  ),
                ),
                const Gap(40),
                Text(
                  "Personal Information",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildPersonalInfoSection(context),
                const Gap(40),
                Text(
                  "Employment Details",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildEmploymentDetailsSection(context),
                const Gap(40),
                Text(
                  "Financial Information",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildFinancialInformationSection(context),
                const Gap(40),
                Text(
                  "Identification",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildIdentificationDocumentsSection(context),
                const Gap(60),
                ElevatedButton(
                  onPressed: () {
                    if (_formGroup.valid) {
                      _handleSubmit(context, _formGroup.value);
                    } else {
                      NotificationMessage.showError(context,
                          message: 'Please fill in all the details correctly');
                    }
                  },
                  child: const Text('Submit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Ionicons.image_outline),
                title: const Text('Upload Image from gallery'),
                onTap: () {
                  Navigator.of(context).pop(); // Dismiss the bottom sheet first
                  context.read<ProfileCompletionProvider>().pickImage(context);
                },
              ),
              ListTile(
                leading: const Icon(Ionicons.camera_outline),
                title: const Text('Upload from camera'),
                onTap: () {
                  Navigator.of(context).pop(); // Dismiss the bottom sheet first
                  context
                      .read<ProfileCompletionProvider>()
                      .pickImage(context, imageSource: ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return Column(
      children: [
        ReactiveTextField<String>(
          formControlName: 'full_name',
          decoration: const InputDecoration(labelText: 'Full Name'),
          autofillHints: const [
            AutofillHints.name,
          ],
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'date_of_birth',
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Date of Birth',
            suffixIcon: Icon(Ionicons.calendar_number_outline),
          ),
          onTap: (control) async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              String formattedDate = Jiffy.parseFromDateTime(pickedDate)
                  .format(pattern: 'yyyy-MM-dd');
              _formGroup.control('date_of_birth').value = formattedDate;
            }
          },
        ),
        const Gap(20),
        ReactiveDropdownField<String>(
          formControlName: 'gender',
          decoration: const InputDecoration(
            labelText: 'Gender',
          ),
          icon: const Icon(Ionicons.chevron_down_outline),
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
            DropdownMenuItem(
              value: 'Other',
              child: Text('Other'),
            ),
          ],
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'current_address',
          decoration: const InputDecoration(labelText: 'Current Address'),
          autofillHints: const [
            AutofillHints.location,
          ],
          keyboardType: TextInputType.streetAddress,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'nationality',
          decoration: const InputDecoration(labelText: 'Nationality'),
          autofillHints: const [
            AutofillHints.countryName,
          ],
        ),
      ],
    );
  }

  Widget _buildEmploymentDetailsSection(BuildContext context) {
    return Column(
      children: [
        ReactiveTextField<String>(
          formControlName: 'job_title',
          decoration: const InputDecoration(labelText: 'Job Title'),
          autofillHints: const [
            AutofillHints.jobTitle,
          ],
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'company_name',
          decoration: const InputDecoration(labelText: 'Company Name'),
          autofillHints: const [
            AutofillHints.organizationName,
          ],
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveDropdownField<String>(
          formControlName: 'employment_status',
          decoration: const InputDecoration(
            labelText: 'Employment Status',
          ),
          icon: const Icon(Ionicons.chevron_down_outline),
          items: const [
            DropdownMenuItem(
              value: 'Employed',
              child: Text('Employed'),
            ),
            DropdownMenuItem(
              value: 'Self-Employed',
              child: Text('Self-Employed'),
            ),
            DropdownMenuItem(
              value: 'Unemployed',
              child: Text('Unemployed'),
            ),
            DropdownMenuItem(
              value: 'Student',
              child: Text('Student'),
            ),
          ],
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'monthly_income',
          decoration: const InputDecoration(labelText: 'Monthly Income'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildFinancialInformationSection(BuildContext context) {
    return Column(
      children: [
        ReactiveTextField<String>(
          formControlName: 'account_number',
          decoration: const InputDecoration(labelText: 'Account Number'),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'ifsc_code',
          decoration: const InputDecoration(labelText: 'IFSC Code'),
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'bank_name',
          decoration: const InputDecoration(labelText: 'Bank Name'),
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'upi_id',
          decoration: const InputDecoration(labelText: 'UPI ID'),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildIdentificationDocumentsSection(BuildContext context) {
    return Column(
      children: [
        ReactiveTextField<String>(
          formControlName: 'pan_card',
          decoration: const InputDecoration(labelText: 'PAN Card Number'),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.characters,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'aadhaar_card',
          decoration: const InputDecoration(labelText: 'Aadhaar Card Number'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Future<void> _handleSubmit(
      BuildContext context, Map<String, Object?> value) async {
    await context.read<UserProvider>().update(context, value);
  }
}
