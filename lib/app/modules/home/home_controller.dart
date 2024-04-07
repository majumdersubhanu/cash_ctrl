import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/models/expense_model.dart';
import '../../data/providers/expense_provider.dart';

class HomeController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  RxList<Expense> expenses = <Expense>[].obs;

  final ExpenseProvider provider = ExpenseProvider();

  @override
  void onInit() {
    super.onInit();

    provider.getLatestTransactionsStream().listen((updatedExpenses) {
      expenses.value = updatedExpenses;
    });

    analyticsInfo();
  }

  RxDouble currentMonthTotal = 0.0.obs;
  RxDouble currentYearTotal = 0.0.obs;
  RxDouble allTimeTotal = 0.0.obs;
  RxString currMaxCategory = "N/A".obs;

  analyticsInfo() async {
    currentMonthTotal.value = await provider.totalExpenditureCurrentMonth();
    currentYearTotal.value = await provider.totalExpenditureCurrentYear();
    allTimeTotal.value = await provider.totalExpenditureAllTime();
    Map<String, String> map =
        await provider.totalMaxCategoryExpenditureCurrentMonth();
    currMaxCategory.value = map['category'] ?? 'N/A';
  }
}
