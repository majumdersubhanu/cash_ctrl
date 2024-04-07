import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import '../../core/extensions.dart';
import 'borrow_controller.dart'; // Make sure this import points to your BorrowController

class BorrowView extends GetView<BorrowController> {
  BorrowView({super.key});

  FormGroup formGroup = FormGroup({
    'amount': FormControl<double>(validators: [Validators.required]),
    'note': FormControl<String>(),
    // 'upi_id': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    // Define QR code data

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
                      // Show dialog immediately with loader
                      showDialog(
                        context: context,
                        barrierDismissible: false, // Make the dialog modal
                        builder: (context) {
                          // Call the profile setup method from the controller
                          controller.fetchAndSetupProfile().then((_) {
                            // Close the initial dialog if needed and show the new one
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: buildQRCodeDialog(
                                    context), // Function to build the actual QR Code dialog
                              ),
                            );
                          });
                          // Initial dialog with CircularProgressIndicator
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
    // Assuming controller.profile is now populated
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
          Gap(20),
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
                onPressed: () => true,
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
