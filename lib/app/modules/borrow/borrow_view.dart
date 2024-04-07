import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import 'package:cash_ctrl/app/routes/app_pages.dart';

import '../../core/extensions.dart';
import 'borrow_controller.dart';

class BorrowView extends GetView<BorrowController> {
  BorrowView({super.key});

  FormGroup formGroup = FormGroup({
    'amount': FormControl<double>(validators: [Validators.required]),
    'note': FormControl<String>(),
    'lender_name': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          child: ReactiveForm(
            formGroup: formGroup,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Borrowing',
                  style: context.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(40),
                ReactiveTextField(
                  formControlName: 'lender_name',
                  decoration: const InputDecoration(
                    labelText: 'Lender Name',
                    hintText: 'Enter the lender\'s name',
                  ),
                  keyboardType: TextInputType.name,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Lender\'s name is required',
                  },
                ),
                const Gap(20),
                ReactiveTextField(
                  formControlName: 'amount',
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter the amount',
                  ),
                  keyboardType: TextInputType.number,
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Amount is required',
                  },
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'note',
                  decoration: const InputDecoration(
                    labelText: 'Transaction Note',
                  ),
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: () {
                    if (formGroup.valid) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          controller.fetchAndSetupProfile().then((_) {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: buildQRCodeDialog(context),
                              ),
                            );
                          });

                          return const Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text('Setting up profile...'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      formGroup.markAllAsTouched();
                    }
                  },
                  child: const Text('Generate QR for transaction'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQRCodeDialog(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Get.theme.colorScheme.primary,
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage:
                      NetworkImage(controller.user?.photoURL ?? ''),
                ),
              ),
              const Gap(20),
              Text(
                controller.user?.displayName ?? 'N/A',
                style: Get.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(30),
          UPIPaymentQRCode(
            upiDetails: UPIDetails(
              upiID: controller.profile?.financialInformation?.upiId ?? '',
              payeeName: controller.user?.displayName ?? '',
              amount: double.parse(formGroup.value['amount'].toString()),
              currencyCode: 'INR',
              transactionNote: formGroup.control('note').value ?? '',
            ),
            embeddedImagePath: 'assets/ic_launcher.png',
            size: 250,
            dataModuleStyle: QrDataModuleStyle(
              color: Get.theme.colorScheme.primary,
              dataModuleShape: QrDataModuleShape.circle,
            ),
            eyeStyle: QrEyeStyle(
              color: Get.theme.colorScheme.primary,
              eyeShape: QrEyeShape.square,
            ),
            upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.medium,
            loader: const CircularProgressIndicator(),
            qrCodeLoader: const CircularProgressIndicator(),
          ),
          const Gap(20),
          Text(
            controller.profile?.financialInformation?.upiId ?? 'N/A',
            style: Get.theme.textTheme.titleSmall,
          ),
          const Gap(5),
          Text(
            'Scan this QR code to lend me money',
            style: Get.theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () => Get.back(),
                icon: Icon(
                  Ionicons.close_circle_outline,
                  color: Colors.red.shade700,
                ),
                label: const Text('Cancel'),
              ),
              TextButton.icon(
                onPressed: () {
                  controller.uploadToFirebase(context, formGroup.value);
                  Get.offAllNamed(Routes.BASE_PAGE);
                },
                icon: Icon(
                  Ionicons.checkmark_circle_outline,
                  color: Colors.green.shade700,
                ),
                label: const Text('Successful'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
