import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

@RoutePage()
class BorrowMoneyPage extends StatefulWidget {
  const BorrowMoneyPage({super.key});

  @override
  State<BorrowMoneyPage> createState() => _BorrowMoneyPageState();
}

class _BorrowMoneyPageState extends State<BorrowMoneyPage> {
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
                  style: context.textTheme.displaySmall?.copyWith(
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
                          logger.f(getIt<AppPrefs>()
                                  .authUser
                                  .getValue()
                                  ?.user
                                  .upiId ??
                              '');

                          return Dialog(
                            child: buildQRCodeDialog(context),
                          );

                          return const Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  Gap(20),
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
    logger.f(getIt<AppPrefs>().authUser.getValue()!.user.upiId);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(getIt<AppPrefs>()
                            .authUser
                            .getValue()
                            ?.user
                            .profilePic ??
                        ''),
                  ),
                ),
                const Gap(20),
                Text(
                  getIt<AppPrefs>().authUser.getValue()?.user.username ?? 'N/A',
                  style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            const Gap(30),
            UPIPaymentQRCode(
              upiDetails: UPIDetails(
                upiID:
                    getIt<AppPrefs>().authUser.getValue()!.user.upiId ?? 'N/A',
                payeeName:
                    getIt<AppPrefs>().authUser.getValue()?.user.fullName ?? '',
                amount: double.parse(formGroup.value['amount'].toString()),
                currencyCode: 'INR',
                transactionNote: formGroup.control('note').value ?? '',
              ),
              embeddedImagePath: 'assets/icon/icon.png',
              size: 250,
              dataModuleStyle: QrDataModuleStyle(
                color: Theme.of(context).colorScheme.primary,
                dataModuleShape: QrDataModuleShape.circle,
              ),
              eyeStyle: QrEyeStyle(
                color: Theme.of(context).colorScheme.primary,
                eyeShape: QrEyeShape.square,
              ),
              upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.medium,
              loader: const CircularProgressIndicator(),
              qrCodeLoader: const CircularProgressIndicator(),
            ),
            const Gap(20),
            Text(
              getIt<AppPrefs>().authUser.getValue()?.user.upiId ?? 'N/A',
              style: context.textTheme.titleSmall,
            ),
            const Gap(5),
            Text(
              'Scan this QR code to lend me money',
              style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
            ),
            const Gap(20),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => context.maybePop(),
                  icon: Icon(
                    Ionicons.close_circle_outline,
                    color: Colors.red.shade700,
                  ),
                  label: const Text('Cancel'),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.replaceRoute(BaseRoute());
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
      ),
    );
  }
}
