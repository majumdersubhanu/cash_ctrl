import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../core/extensions.dart';
import 'profile_completion_controller.dart';

class ProfileCompletionView extends GetView<ProfileCompletionController> {
  ProfileCompletionView({super.key});

  final FormGroup _formGroup = FormGroup({
    'personal_information': FormGroup({
      'full_name': FormControl<String>(validators: [Validators.required]),
      'date_of_birth': FormControl<String>(validators: [Validators.required]),
      'gender': FormControl<String>(),
      'contact_information': FormGroup({
        'email': FormControl<String>(),
        'phone_number': FormControl<String>(),
      }),
      'address': FormGroup({
        'current': FormControl<String>(),
      }),
      'nationality': FormControl<String>(),
    }),
    'employment_details': FormGroup({
      'job_title': FormControl<String>(),
      'company_name': FormControl<String>(),
      'industry': FormControl<String>(),
      'employment_status': FormControl<String>(),
      'monthly_income': FormControl<String>(validators: [Validators.required]),
    }),
    'financial_information': FormGroup({
      'bank_account_details': FormGroup({
        'account_number': FormControl<String>(validators: [Validators.required]),
        'ifsc_code': FormControl<String>(validators: [Validators.required]),
        'bank_name': FormControl<String>(validators: [Validators.required]),
      }),
      'upi_id': FormControl<String>(validators: [Validators.required]),
    }),
    'identification_documents': FormGroup({
      'pan_card': FormControl<String>(validators: [Validators.required]),
      'aadhaar_card': FormControl<String>(validators: [Validators.required]),
      'passport': FormControl<String>(),
      'driver_license': FormControl<String>(),
    }),
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
                  style: Get.theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  "We're almost there, just a bit more!",
                  style: Get.theme.textTheme.bodyLarge,
                ),
                const Gap(50),
                GetBuilder<ProfileCompletionController>(
                  init: ProfileCompletionController(),
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () => Get.bottomSheet(
                        backgroundColor: Get.theme.colorScheme.background,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Upload Image from gallery'),
                              onTap: () {
                                Get.back();

                                controller.pickImage(context);
                              },
                              leading: const Icon(Ionicons.image_outline),
                            ),
                            ListTile(
                              title: const Text('Upload from camera'),
                              onTap: () {
                                Get.back();
                                controller.pickImage(
                                  context,
                                  imageSource: ImageSource.camera,
                                );
                              },
                              leading: const Icon(Ionicons.camera_outline),
                            ),
                          ],
                        ),
                        isScrollControlled: true,
                      ),
                      child: controller.file != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: controller.file != null
                                  ? FileImage(controller.file!)
                                  : null,
                            )
                          : RandomAvatar('saytoonz', height: 100, width: 100),
                    );
                  },
                ),
                const Gap(40),
                Text(
                  "Personal Information",
                  style: Get.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildPersonalInfoSection(context),
                const Gap(40),
                Text(
                  "Employment Details",
                  style: Get.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildEmploymentDetailsSection(context),
                const Gap(40),
                Text(
                  "Financial Information",
                  style: Get.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildFinancialInformationSection(context),
                const Gap(40),
                Text(
                  "Identification",
                  style: Get.theme.textTheme.titleLarge
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
                      context.showSnackbar('Aww Snap!',
                          'Please fill in all the details correctly');
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

  Widget _buildPersonalInfoSection(BuildContext context) {
    return Column(
      children: [
        ReactiveTextField<String>(
          formControlName: 'personal_information.full_name',
          decoration: const InputDecoration(labelText: 'Full Name'),
          autofillHints: const [
            AutofillHints.name,
          ],
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'personal_information.date_of_birth',
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
              String formattedDate = Jiffy.parseFromDateTime(pickedDate).yMMMd;
              _formGroup.control('personal_information.date_of_birth').value =
                  formattedDate;
            }
          },
        ),
        const Gap(20),
        ReactiveDropdownField<String>(
          formControlName: 'personal_information.gender',
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
          formControlName: 'personal_information.address.current',
          decoration: const InputDecoration(labelText: 'Current Address'),
          autofillHints: const [
            AutofillHints.location,
          ],
          keyboardType: TextInputType.streetAddress,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'personal_information.nationality',
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
          formControlName: 'employment_details.job_title',
          decoration: const InputDecoration(labelText: 'Job Title'),
          autofillHints: const [
            AutofillHints.jobTitle,
          ],
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'employment_details.company_name',
          decoration: const InputDecoration(labelText: 'Company Name'),
          autofillHints: const [
            AutofillHints.organizationName,
          ],
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveDropdownField<String>(
          formControlName: 'employment_details.employment_status',
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
          formControlName: 'employment_details.monthly_income',
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
          formControlName:
              'financial_information.bank_account_details.account_number',
          decoration: const InputDecoration(labelText: 'Account Number'),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: false, signed: false),
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName:
              'financial_information.bank_account_details.ifsc_code',
          decoration: const InputDecoration(labelText: 'IFSC Code'),
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName:
              'financial_information.bank_account_details.bank_name',
          decoration: const InputDecoration(labelText: 'Bank Name'),
          keyboardType: TextInputType.name,
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'financial_information.upi_id',
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
          formControlName: 'identification_documents.pan_card',
          decoration: const InputDecoration(labelText: 'PAN Card Number'),
          keyboardType: TextInputType.name,
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'identification_documents.aadhaar_card',
          decoration: const InputDecoration(labelText: 'Aadhaar Card Number'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context, Map<String, Object?> value) {
    controller.uploadToFirestore(context, value);
  }
}
