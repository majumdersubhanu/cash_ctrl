import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/expense_model.dart';
import '../../data/providers/expense_provider.dart';

class NewExpenseController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  ExpenseProvider provider = ExpenseProvider();

  uploadToFirestore(BuildContext context, Expense expense) =>
      provider.postExpense(expense, context);
}
