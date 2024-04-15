import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = getIt<AppPrefs>().authUser.getValue()?.user;

  final FormGroup formGroup = FormGroup({
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
  void initState() {
    super.initState();

    logger.w(currentUser);

    formGroup.value = {
      'full_name': currentUser?.fullName ?? 'N/A',
      'date_of_birth':
          Jiffy.parseFromDateTime(currentUser?.dateOfBirth ?? DateTime.now())
              .format(pattern: 'yyyy-MM-dd'),
      'gender': currentUser?.gender ?? 'N/A',
      'current_address': currentUser?.currentAddress ?? 'N/A',
      'nationality': currentUser?.nationality ?? 'N/A',
      'job_title': currentUser?.jobTitle ?? 'N/A',
      'company_name': currentUser?.companyName ?? 'N/A',
      'employment_status': currentUser?.employmentStatus ?? 'N/A',
      'monthly_income': currentUser?.monthlyIncome ?? 'N/A',
      'account_number': currentUser?.accountNumber ?? 'N/A',
      'ifsc_code': currentUser?.ifscCode ?? 'N/A',
      'bank_name': currentUser?.bankName ?? 'N/A',
      'upi_id': currentUser?.upiId ?? 'N/A',
      'pan_card': currentUser?.panCard ?? 'N/A',
      'aadhaar_card': currentUser?.aadhaarCard ?? 'N/A',
    };
  }

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
            child: getIt<AppPrefs>().authUser.getValue()?.user != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.down,
                    textDirection: TextDirection.ltr,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      RandomAvatar('saytoonz', height: 100, width: 100),
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
                      const Gap(20),
                      ListTile(
                        leading: const Icon(Ionicons.log_out_outline),
                        title: const Text('Logout'),
                        onTap: () {
                          getIt<AppPrefs>().clear();
                          context.replaceRoute(LoginRoute());
                        },
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }

  Widget _buildPersonalInfoSection(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'full_name',
            decoration: const InputDecoration(labelText: 'Full Name'),
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
                String formattedDate =
                    Jiffy.parseFromDateTime(pickedDate).yMMMd;
                formGroup.control('date_of_birth').value = formattedDate;
              }
            },
          ),
          const Gap(20),
          ReactiveDropdownField<String>(
            formControlName: 'gender',
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
            formControlName: 'current_address',
            decoration: const InputDecoration(labelText: 'Current Address'),
          ),
          const Gap(20),
          ReactiveTextField<String>(
            formControlName: 'nationality',
            decoration: const InputDecoration(labelText: 'Nationality'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentDetailsSection(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'job_title',
            decoration: const InputDecoration(labelText: 'Job Title'),
          ),
          const Gap(20),
          ReactiveTextField<String>(
            formControlName: 'company_name',
            decoration: const InputDecoration(labelText: 'Company Name'),
          ),
          const Gap(20),
          ReactiveDropdownField<String>(
            formControlName: 'employment_status',
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
      formGroup: formGroup,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'account_number',
            decoration: const InputDecoration(labelText: 'Account Number'),
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
          ),
          const Gap(20),
          ReactiveTextField<String>(
            formControlName: 'upi_id',
            decoration: const InputDecoration(labelText: 'UPI ID'),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentificationDocumentsSection(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'pan_card',
            decoration: const InputDecoration(labelText: 'PAN Card Number'),
          ),
          const Gap(20),
          ReactiveTextField<String>(
            formControlName: 'aadhaar_card',
            decoration: const InputDecoration(labelText: 'Aadhaar Card Number'),
          ),
        ],
      ),
    );
  }
}
