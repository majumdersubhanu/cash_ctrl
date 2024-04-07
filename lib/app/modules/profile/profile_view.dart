import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../core/extensions.dart';
import '../../routes/app_pages.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          primary: true,
          child: Obx(() {
            if (controller.profile.value != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                textDirection: TextDirection.ltr,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    'Profile',
                    style: context.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Gap(50),
                  GestureDetector(
                    onTap: () => context.showBottomSheet(
                      Column(
                        children: [
                          ListTile(
                            title: const Text('Upload image from gallery'),
                            onTap: () {
                              Get.back();
                              controller.pickImage(context);
                            },
                            leading: const Icon(Ionicons.image_outline),
                          ),
                          ListTile(
                            title: const Text('Upload image from camera'),
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
                    child: Obx(
                      () => CircleAvatar(
                        radius: 102,
                        backgroundColor: Get.theme.colorScheme.primary,
                        child: controller.user.value?.photoURL != null
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage: controller.file.value != null
                                    ? FileImage(controller.file.value!)
                                        as ImageProvider<Object>
                                    : controller.user.value?.photoURL != null
                                        ? NetworkImage(controller
                                                .user.value!.photoURL
                                                .toString())
                                            as ImageProvider<Object>
                                        : const AssetImage(
                                                'assets/ic_launcher.png')
                                            as ImageProvider<Object>,
                                backgroundColor: Get.theme.colorScheme.surface,
                              )
                            : RandomAvatar('saytoonz', height: 100, width: 100),
                      ),
                    ),
                  ),
                  const Gap(40),
                  Text(
                    "Personal Information",
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  _buildPersonalInfoSection(context),
                  const Gap(40),
                  Text(
                    "Employment Details",
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  _buildEmploymentDetailsSection(context),
                  const Gap(40),
                  Text(
                    "Financial Information",
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  _buildFinancialInformationSection(context),
                  const Gap(40),
                  Text(
                    "Identification",
                    style: context.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  _buildIdentificationDocumentsSection(context),
                  const Gap(20),
                  ListTile(
                    leading: const Icon(Ionicons.log_out_outline),
                    title: const Text('Logout'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Get.offAllNamed(Routes.LOGIN);
                    },
                  ),
                  ListTile(
                    onTap: () => Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
                    leading: const Icon(Ionicons.moon_outline),
                    title: const Text('Switch theme'),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.formGroup.value,
      child: Column(
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
                String formattedDate =
                    Jiffy.parseFromDateTime(pickedDate).yMMMd;
                controller.formGroup.value
                    .control('personal_information.date_of_birth')
                    .value = formattedDate;
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
      ),
    );
  }

  Widget _buildEmploymentDetailsSection(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.formGroup.value,
      child: Column(
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
      ),
    );
  }

  Widget _buildFinancialInformationSection(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.formGroup.value,
      child: Column(
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
      ),
    );
  }

  Widget _buildIdentificationDocumentsSection(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.formGroup.value,
      child: Column(
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
      ),
    );
  }
}
