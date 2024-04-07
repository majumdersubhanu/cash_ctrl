import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../core/enums.dart';
import '../../data/models/expense_model.dart';
import '../../data/providers/expense_provider.dart';
import 'analytics_view.dart';

class AnalyticsController extends GetxController {
  final ExpenseProvider provider = ExpenseProvider();

  RxList<Expense> monthlyExpenses = <Expense>[].obs;
  RxList<Expense> yearlyExpenses = <Expense>[].obs;

  RxMap<String, double> monthlyTotalExpenses = <String, double>{}.obs;

  RxList<ExpenditureAnalyticsData> monthlyAnalyticsData =
      <ExpenditureAnalyticsData>[].obs;
  RxList<ExpenditureAnalyticsData> yearlyAnalyticsData =
      <ExpenditureAnalyticsData>[].obs;

  @override
  void onInit() {
    super.onInit();
    subscribeToExpenseStreams();
  }

  Future<void> subscribeToExpenseStreams() async {
    yearlyExpenses.value = await provider.getYearlyExpenses();
    _updateYearlyAnalytics();

    monthlyExpenses.value = await provider.getMonthlyExpenses();
    _updateMonthlyAnalytics();
  }

  void _updateMonthlyAnalytics() {
    final Map<String, double> categoryTotals = {};

    int month = DateTime.now().month;

    for (Expense expense in monthlyExpenses) {
      final category = expense.transaction?.paymentCategory ??
          getCategoryName(ExpenseCategory.miscellaneous);
      final amount = expense.transaction?.amount ?? 0;
      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }
    }

    monthlyAnalyticsData.value = categoryTotals.entries
        .map(
          (entry) => ExpenditureAnalyticsData(
            entry.key,
            ((entry.value /
                        ((yearlyAnalyticsData[month - 1].value * 1000) ?? 1)) *
                    100)
                .toPrecision(1),
          ),
        )
        .toList();
  }

  void _updateYearlyAnalytics() {
    final Map<String, double> monthlyTotals = {};

    for (var i = 1; i <= DateTime.now().month; i++) {
      final monthName =
          Jiffy.parseFromDateTime(DateTime(DateTime.now().year, i, 1))
              .format(pattern: "MMMM");
      monthlyTotals[monthName] = 0;
    }

    for (final expense in yearlyExpenses) {
      if (expense.createdAt != null) {
        final month = Jiffy.parseFromDateTime(expense.createdAt!.toDate())
            .format(pattern: "MMMM");
        final amount = expense.transaction?.amount ?? 0;

        if (monthlyTotals.containsKey(month)) {
          monthlyTotals[month] = monthlyTotals[month]! + amount;
        } else {
          monthlyTotals[month] = amount;
        }
      }
    }

    yearlyAnalyticsData.value = monthlyTotals.entries.map((entry) {
      return ExpenditureAnalyticsData(entry.key, entry.value / 1000);
    }).toList();
  }

  Future<void> refreshAnalytics() async {
    subscribeToExpenseStreams();
  }
}
