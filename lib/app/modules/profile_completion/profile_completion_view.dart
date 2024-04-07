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
      'full_name': FormControl<String>(),
      'date_of_birth': FormControl<String>(),
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
      'monthly_income': FormControl<String>(),
    }),
    'financial_information': FormGroup({
      'bank_account_details': FormGroup({
        'account_number': FormControl<String>(),
        'ifsc_code': FormControl<String>(),
        'bank_name': FormControl<String>(),
      }),
      'upi_id': FormControl<String>(),
    }),
    'identification_documents': FormGroup({
      'pan_card': FormControl<String>(),
      'aadhaar_card': FormControl<String>(),
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
                  style: context.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  "We're almost there, just a bit more!",
                  style: context.bodyLarge,
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
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildPersonalInfoSection(context),
                const Gap(40),
                Text(
                  "Employment Details",
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildEmploymentDetailsSection(context),
                const Gap(40),
                Text(
                  "Financial Information",
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildFinancialInformationSection(context),
                const Gap(40),
                Text(
                  "Identification",
                  style:
                      context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                _buildIdentificationDocumentsSection(context),
                const Gap(60),
                ElevatedButton(
                  onPressed: () {
                    if (_formGroup.valid) {
                      _handleSubmit(context, _formGroup.value);
                    } else {
                      context.showThemedSnackbar('Aww Snap!',
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
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'personal_information.nationality',
          decoration: const InputDecoration(labelText: 'Nationality'),
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
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'employment_details.company_name',
          decoration: const InputDecoration(labelText: 'Company Name'),
        ),
        const Gap(20),
        ReactiveDropdownField<String>(
          formControlName: 'employment_details.employment_status',
          decoration: const InputDecoration(
            labelText: 'Employment Status',
          ),
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
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'financial_information.upi_id',
          decoration: const InputDecoration(labelText: 'UPI ID'),
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
        ),
        const Gap(20),
        ReactiveTextField<String>(
          formControlName: 'identification_documents.aadhaar_card',
          decoration: const InputDecoration(labelText: 'Aadhaar Card Number'),
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context, Map<String, Object?> value) {
    controller.uploadToFirestore(context, value);
  }
}
