import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/extensions.dart';
import '../../modules/analytics/analytics_controller.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/lending/lending_controller.dart';
import '../models/expense_model.dart'; // Assuming this is the correct path

class ExpenseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  // Stream the last 5 transactions in real-time.
  Stream<List<Expense>> streamLastFiveTransactions() {
    String? userUid = _auth.currentUser?.uid;
    return _firestore
        .collection("expense-data")
        .where("user", isEqualTo: userUid)
        .orderBy("createdAt", descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }

  // Upload an expense
  Future<void> postExpense(Expense expense, BuildContext context) async {
    try {
      // Assuming 'expenses' is your Firestore collection name
      await _firestore.collection('expense-data').add(expense.toJson());

      // Show success snackbar
      context.showAwesomeSnackBar(
          'Success!', 'Expense added successfully', ContentType.success);

      Get.find<AnalyticsController>().subscribeToExpenseStreams();
      Get.find<LendingController>().subscribeToExpenseStreams();

      Get.find<HomeController>().analyticsInfo();

      Navigator.of(context).pop();

      // Optionally, trigger any other updates or refreshes needed
    } catch (e) {
      // Show error snackbar
      context.showAwesomeSnackBar(
        'Error!',
        'Failed to add expense. Please try again.',
        ContentType.failure,
      );
    }
  }

  // Helper method to fetch category-wise expenditure within a specific timeframe.
  // Future<Map<String, double>> _getCategoryWiseExpenditure(
  //     DateTime start, DateTime end) async {
  //   Map<String, double> expensesByCategory = {};
  //   String? userUid = _auth.currentUser?.uid;
  //
  //   _logger.i('Start: $start End: $end');
  //
  //   var snapshot = await _queryExpensesByTimeframe(userUid, start, end);
  //
  //   _logger.f("Snapshot ${snapshot.docs.length}");
  //
  //   for (var doc in snapshot.docs) {
  //     var data = Expense.fromJson(doc.data());
  //
  //     _logger.f(doc.data().toString());
  //
  //     String category = data.transaction?.paymentCategory ?? 'Miscellaneous';
  //     expensesByCategory[category] =
  //         (expensesByCategory[category] ?? 0) + (data.transaction?.amount ?? 0);
  //   }
  //
  //   _logger.e(expensesByCategory);
  //
  //   return expensesByCategory;
  // }
  //
  // // Helper method to fetch category-wise expense list within a specific timeframe.
  // Future<Map<String, List<Expense>>> _getCategoryWiseExpensesList(
  //     DateTime start, DateTime end) async {
  //   Map<String, List<Expense>> expensesByCategory = {};
  //   String? userUid = _auth.currentUser?.uid;
  //
  //   var snapshot = await _queryExpensesByTimeframe(userUid, start, end);
  //
  //   for (var doc in snapshot.docs) {
  //     var data = Expense.fromJson(doc.data());
  //     String category = data.transaction?.paymentCategory ?? 'Miscellaneous';
  //     expensesByCategory.putIfAbsent(category, () => []).add(data);
  //   }
  //
  //   return expensesByCategory;
  // }

  // Helper method to query expenses by timeframe.
  // Future<QuerySnapshot<Map<String, dynamic>>> _queryExpensesByTimeframe(
  //     String? userUid, DateTime start, DateTime end) {
  //   _logger.i('_queryExpensesByTimeframe running');
  //
  //   var snapshot = _firestore
  //       .collection("expense-data")
  //       .where("user", isEqualTo: userUid)
  //       .where("createdAt", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
  //       .where("createdAt", isLessThanOrEqualTo: Timestamp.fromDate(end))
  //       .get();
  //
  //   return snapshot;
  // }
  //
  // // Helper method to get the start and end date of the current month.
  // Map<String, DateTime> _getCurrentMonthStartEndDate() {
  //   var now = DateTime.now();
  //   var startOfMonth = DateTime(now.year, now.month, 1);
  //   var endOfMonth = DateTime(now.year, now.month + 1, 1)
  //       .subtract(const Duration(milliseconds: 1));
  //   return {'start': startOfMonth, 'end': endOfMonth};
  // }

  Future<List<Expense>> getMonthlyExpenses() async {
    _logger.e('Subscribed to monthly stream');

    var now = DateTime.now();
    var startOfMonth = DateTime(now.year, now.month);
    var endOfMonth = DateTime(now.year, now.month + 1)
        .subtract(const Duration(milliseconds: 1));
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    List<Expense> expenses = [];

    var snapshot = await _firestore
        .collection("expense-data")
        .where("user", isEqualTo: userUid)
        .where("createdAt",
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
        .where("createdAt", isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
        .get();

    for (var doc in snapshot.docs) {
      var data = Expense.fromJson(doc.data());
      if (data.createdAt != null) {
        expenses.add(data);
      }
    }

    _logger.i(expenses.map((e) => e.transaction?.title ?? 'N/A').toList());

    return expenses;
  }

  // Stream yearly expenses
  Future<List<Expense>> getYearlyExpenses() async {
    var now = DateTime.now();
    var startOfYear = DateTime(now.year);
    var endOfYear =
        DateTime(now.year + 1).subtract(const Duration(milliseconds: 1));
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    List<Expense> monthlyExpenses = [];

    var snapshot = await _firestore
        .collection("expense-data")
        .where("user", isEqualTo: userUid)
        .where("createdAt",
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfYear))
        .where("createdAt", isLessThanOrEqualTo: Timestamp.fromDate(endOfYear))
        .get();

    for (var doc in snapshot.docs) {
      var data = Expense.fromJson(doc.data());
      if (data.createdAt != null) {
        monthlyExpenses.add(data);
      }
    }

    _logger
        .i(monthlyExpenses.map((e) => e.transaction?.title ?? 'N/A').toList());

    return monthlyExpenses;
  }

  Future<List<Expense>> getAllExpenses() async {
    _logger.e('Subscribed to all expense stream');

    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    List<Expense> expenses = [];

    var snapshot = await _firestore
        .collection("expense-data")
        .where("user", isEqualTo: userUid)
        .get();

    for (var doc in snapshot.docs) {
      var data = Expense.fromJson(doc.data());
      if (data.createdAt != null) {
        expenses.add(data);
      }
    }

    _logger.i(expenses.map((e) => e.transaction?.title).toList());

    return expenses;
  }

  Future<double> totalExpenditureCurrentMonth() async {
    List<Expense> expenses = await getMonthlyExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

    _logger.w("Total: $total");

    return total;
  }

  Future<double> totalExpenditureCurrentYear() async {
    List<Expense> expenses = await getYearlyExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

    _logger.w("Total: $total");

    return total;
  }

  Future<double> totalExpenditureAllTime() async {
    List<Expense> expenses = await getAllExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

    _logger.w("Total: $total");

    return total;
  }

  Future<Map<String, String>> totalMaxCategoryExpenditureCurrentMonth() async {
    var expenses = Get.find<AnalyticsController>().monthlyAnalyticsData.value;

    if (expenses.isNotEmpty) {
      double currMax = expenses[0].value;
      String currMaxCategory = expenses[0].label;

      for (int i = 0; i < expenses.length; i++) {
        if (expenses[i].value > currMax) {
          currMax = expenses[i].value;
          currMaxCategory = expenses[i].label;
        }
      }

      _logger.f({"category": currMaxCategory, "value": currMax});

      return {
        "category": currMaxCategory,
        "value": currMax.toStringAsPrecision(3)
      };
    }

    return {};
  }
}
