import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/application/analytics/analytics_provider.dart';
import 'package:cash_ctrl/application/transaction/transaction_provider.dart';
import 'package:cash_ctrl/core/enums.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final FormGroup _formGroup = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'description': FormControl<String>(),
    'payment_type': FormControl<String>(validators: [Validators.required]),
    'category': FormControl<String>(validators: [Validators.required]),
    'amount': FormControl<double>(validators: [Validators.required]),
    'transaction_type': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
        titleTextStyle: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
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
                ReactiveTextField<String>(
                  formControlName: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Transaction Title',
                    hintText: 'Enter transaction title',
                  ),
                  validationMessages: {
                    ValidationMessage.required: (error) => 'Title is required',
                  },
                  textCapitalization: TextCapitalization.sentences,
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Transaction Description',
                    hintText: 'Enter some description',
                  ),
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'transaction_type',
                  decoration: const InputDecoration(
                    labelText: 'Transaction Type',
                  ),
                  readOnly: true,
                  onTap: (control) => _showTransactionTypeOptions(context),
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'payment_type',
                  decoration: const InputDecoration(
                    labelText: 'Payment Mode',
                  ),
                  readOnly: true,
                  onTap: (control) => _showPaymentOptions(context),
                ),
                const Gap(20),
                ReactiveTextField<String>(
                  formControlName: 'category',
                  decoration: const InputDecoration(
                    labelText: 'Payment Category',
                  ),
                  readOnly: true,
                  onTap: (control) => _showExpenseCategoryPicker(context),
                ),
                const Gap(20),
                ReactiveTextField<double>(
                  formControlName: 'amount',
                  decoration: const InputDecoration(
                    labelText: 'Transaction Amount',
                    hintText: 'Enter the transaction amount',
                  ),
                  keyboardType: TextInputType.number,
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Transaction amount is required',
                  },
                ),
                const Gap(40),
                ElevatedButton(
                  onPressed: () {
                    if (_formGroup.valid) {
                      context
                          .read<TransactionProvider>()
                          .addTransaction(context, _formGroup.value);

                      context.read<AnalyticsProvider>().getAnalytics(context);

                      context.maybePop();
                    } else {
                      _formGroup.markAllAsTouched();
                    }
                  },
                  child: const Text('Add Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: PaymentMode.values
              .map((mode) => ListTile(
                    leading: Icon(getPaymentModeIcon(mode)),
                    title: Text(getPaymentModeName(mode)),
                    onTap: () {
                      _formGroup.control('payment_type').value =
                          getPaymentModeName(mode).toLowerCase();
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  void _showTransactionTypeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: TransactionMode.values
              .map((mode) => ListTile(
                    leading: Icon(getTransactionModeIcon(mode)),
                    title: Text(getTransactionModeName(mode)),
                    onTap: () {
                      _formGroup.control('transaction_type').value =
                          getTransactionModeName(mode).toLowerCase();
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  void _showExpenseCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ExpenseCategory.values
              .map((category) => ListTile(
                    leading: Icon(getCategoryIcon(category)),
                    title: Text(getCategoryName(category)),
                    onTap: () {
                      _formGroup.control('category').value =
                          getCategoryName(category).toLowerCase();
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
