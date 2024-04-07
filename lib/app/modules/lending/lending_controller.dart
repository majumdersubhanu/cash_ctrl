import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/enums.dart';
import '../../data/models/expense_model.dart';
import '../../data/providers/expense_provider.dart';
import 'lending_view.dart';

class LendingController extends GetxController {
  ScrollController scrollController = ScrollController();
  ExpenseProvider provider = ExpenseProvider();
  RxList<Expense> yearlyExpenses = <Expense>[].obs;

  Rx<DataGridSource> expenseDataSource = ExpenseDataSource(expenses: []).obs;

  @override
  void onInit() {
    super.onInit();
    subscribeToExpenseStreams();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  scrollToBottom() => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Durations.short4,
        curve: Easing.emphasizedAccelerate,
      );

  Set<PaymentMode> modeFilter = <PaymentMode>{}.obs;
  Set<ExpenseCategory> categoryFilter = <ExpenseCategory>{}.obs;

  Future<void> subscribeToExpenseStreams() async {
    yearlyExpenses.value = await provider.getAllExpenses();

    applyColumnGroupingDynamic();
  }

  Future<void> applyColumnGroupingDynamic() async {
    if (modeFilter.isEmpty && categoryFilter.isNotEmpty) {
      expenseDataSource.value = ExpenseDataSource(expenses: yearlyExpenses)
        ..addColumnGroup(ColumnGroup(name: 'Type', sortGroupRows: false));
    } else if (modeFilter.isNotEmpty && categoryFilter.isEmpty)
      expenseDataSource.value = ExpenseDataSource(expenses: yearlyExpenses)
        ..addColumnGroup(ColumnGroup(name: 'Category', sortGroupRows: false));
    else
      expenseDataSource.value = ExpenseDataSource(expenses: yearlyExpenses);
  }

  RxMap<String, double> columnWidths = {
    'Title': double.nan,
    'Amount': double.nan,
    'Description': double.nan,
    'Category': double.nan,
    'Type': double.nan,
    'Time': double.nan,
  }.obs;
}
