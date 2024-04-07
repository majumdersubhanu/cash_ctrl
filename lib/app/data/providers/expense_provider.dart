import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../core/extensions.dart';
import '../../modules/analytics/analytics_controller.dart';
import '../../modules/home/home_controller.dart';
import '../../modules/lending/lending_controller.dart';
import '../models/expense_model.dart';

class ExpenseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Expense>> getLatestTransactionsStream() {
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

  Future<void> postExpense(Expense expense, BuildContext context) async {
    try {
      await _firestore.collection('expense-data').add(expense.toJson());

      context.showSnackbar('Success!', 'Expense added successfully');

      //TODO: find a better method: maybe implement streams for all the data
      Get.find<AnalyticsController>().subscribeToExpenseStreams();
      Get.find<LendingController>().subscribeToExpenseStreams();
      Get.find<HomeController>().analyticsInfo();
    } catch (e) {
      context.showSnackbar(
          'Error!', 'Failed to add expense. Please try again.');
    }
  }

  Future<List<Expense>> getMonthlyExpenses() async {
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

    return expenses;
  }

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

    return monthlyExpenses;
  }

  Future<List<Expense>> getAllExpenses() async {
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

    return expenses;
  }

  Future<double> totalExpenditureCurrentMonth() async {
    List<Expense> expenses = await getMonthlyExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

    return total;
  }

  Future<double> totalExpenditureCurrentYear() async {
    List<Expense> expenses = await getYearlyExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

    return total;
  }

  Future<double> totalExpenditureAllTime() async {
    List<Expense> expenses = await getAllExpenses();

    double total = 0.0;

    for (Expense e in expenses) {
      total = total + e.transaction!.amount! ?? 0;
    }

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

      return {
        "category": currMaxCategory,
        "value": currMax.toStringAsPrecision(3)
      };
    }

    return {};
  }
}
