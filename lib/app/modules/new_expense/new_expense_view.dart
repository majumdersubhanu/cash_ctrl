import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../core/enums.dart';
import '../../core/extensions.dart';
import '../../data/models/expense_model.dart';
import 'new_expense_controller.dart';

class NewExpenseView extends GetView<NewExpenseController> {
  NewExpenseView({super.key});

  final FormGroup _formGroup = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'description': FormControl<String>(),
    'paymentType': FormControl<String>(validators: [Validators.required]),
    'paymentCategory': FormControl<String>(validators: [Validators.required]),
    'amount': FormControl<double>(validators: [Validators.required]),
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
              children: [
                Text(
                  'Add Expense',
                  style: Get.theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Fill in the details below to add a new expense.',
                  style: Get.theme.textTheme.bodyLarge,
                ),
                const Gap(50),
                ReactiveTextField<String>(
                  formControlName: 'title',
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter expense title',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Title is required',
                  },
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Optional',
                  ),
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'paymentType',
                  decoration: const InputDecoration(
                    labelText: 'Payment Type',
                  ),
                  readOnly: true,
                  onTap: (control) => Get.bottomSheet(
                    backgroundColor: Get.theme.colorScheme.background,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: PaymentMode.values
                          .map((mode) => ListTile(
                                leading: Icon(getPaymentModeIcon(mode)),
                                title: Text(getPaymentModeName(mode)),
                                onTap: () {
                                  _formGroup.control('paymentType').value =
                                      getPaymentModeName(mode);
                                  Get.back();
                                },
                              ))
                          .toList(),
                    ),
                    isScrollControlled: true,
                  ),
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'paymentCategory',
                  decoration: const InputDecoration(
                    labelText: 'Payment Category',
                  ),
                  readOnly: true,
                  onTap: (control) => Get.bottomSheet(
                    backgroundColor: Get.theme.colorScheme.background,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: ExpenseCategory.values
                          .map(
                            (category) => ListTile(
                              leading: Icon(getCategoryIcon(category)),
                              title: Text(getCategoryName(category)),
                              onTap: () {
                                _formGroup.control('paymentCategory').value =
                                    getCategoryName(category);
                                Get.back();
                              },
                            ),
                          )
                          .toList(),
                    ),
                    isScrollControlled: true,
                  ),
                ),
                const Gap(20),
                ReactiveTextField<double>(
                  formControlName: 'amount',
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter the expense amount',
                  ),
                  keyboardType: TextInputType.number,
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Amount is required',
                  },
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: () {
                    if (_formGroup.valid) {
                      controller.uploadToFirestore(
                        context,
                        Expense(
                            createdAt: Timestamp.now(),
                            transaction: Transaction.fromJson(_formGroup.value),
                            user: controller.user?.uid),
                      );
                    } else {
                      _formGroup.markAllAsTouched();
                    }
                  },
                  child: const Text('Add Expense'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
