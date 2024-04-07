import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/web.dart';

import '../../core/enums.dart';
import '../../data/models/expense_model.dart';
import '../../data/providers/expense_provider.dart';
import 'analytics_view.dart';

class AnalyticsController extends GetxController {
  final ExpenseProvider provider =
      ExpenseProvider(); // Assuming dependency injection or direct instantiation

  // Reactive Lists for holding expenses and analytics data
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

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }

  Future<void> subscribeToExpenseStreams() async {
    Logger().d('Subscribed to Expense streams');

    yearlyExpenses.value = await provider.getYearlyExpenses();
    _updateYearlyAnalytics();

    monthlyExpenses.value = await provider.getMonthlyExpenses();
    _updateMonthlyAnalytics();
  }

  void _updateMonthlyAnalytics() {
    Logger().d('Subscribed to monthly Expense streams');

    final Map<String, double> categoryTotals = {};

    Logger().d('Update month triggered');

    int month = DateTime.now().month;

    for (Expense expense in monthlyExpenses) {
      final category = expense.transaction?.paymentCategory ??
          getExpenseName(
              ExpenseCategory.Miscellaneous); // Handle null categories
      final amount = expense.transaction?.amount ?? 0; // Handle null amounts
      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }
    }
    // Convert map to list of ExpenditureAnalyticsData for the chart
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
    Logger().d('Subscribed yearly to Expense streams');

    final Map<String, double> monthlyTotals = {};

    Logger().d('Update year triggered');

    // Initialize all months up to the current one with a 0 value
    for (var i = 1; i <= DateTime.now().month; i++) {
      // Generate month names using Jiffy for consistency with the rest of your code
      final monthName =
          Jiffy.parseFromDateTime(DateTime(DateTime.now().year, i, 1))
              .format(pattern: "MMMM");
      monthlyTotals[monthName] = 0;
    }

    for (final expense in yearlyExpenses) {
      // Ensure createdAt is not null before attempting to format it
      if (expense.createdAt != null) {
        // Extract the month as a string
        final month = Jiffy.parseFromDateTime(expense.createdAt!.toDate())
            .format(pattern: "MMMM");
        final amount = expense.transaction?.amount ?? 0; // Handle null amounts

        if (monthlyTotals.containsKey(month)) {
          monthlyTotals[month] = monthlyTotals[month]! + amount;
        } else {
          // This else block might not be needed anymore since all months are pre-initialized
          monthlyTotals[month] = amount;
        }
      }
    }

    // Now, convert monthlyTotals to yearlyAnalyticsData
    yearlyAnalyticsData.value = monthlyTotals.entries.map((entry) {
      return ExpenditureAnalyticsData(entry.key, entry.value / 1000);
    }).toList();
  }

  Future<void> refreshAnalytics() async {
    subscribeToExpenseStreams();
  }
}
