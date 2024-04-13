import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/analytics/imp_analytics_repo.dart';
import 'package:cash_ctrl/shared/widgets/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

enum LoadingStatus { loading, loaded, error }

@injectable
class AnalyticsProvider extends ChangeNotifier {
  final ImpAnalyticsRepository analyticsRepository;

  AnalyticsProvider(this.analyticsRepository);

  LoadingStatus loadingStatus = LoadingStatus.loading;

  // Local class variables to store analytics data
  double? totalExpenseCurrentMonth;
  double? totalIncomeCurrentMonth;
  double? totalExpenseCurrentYear;
  double? totalExpenseAllTime;

  Map<String, dynamic>? categoryWiseExpenseCurrentMonth;
  List<double?>? monthWiseExpenseCurrentYear;

  Future<void> getAnalytics(BuildContext context) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();

    // Process each response using a common function
    totalExpenseCurrentMonth = await _processResponse(
      context,
      analyticsRepository.getTotalExpenseCurrentMonth(),
      'Total Expense Current Month',
    );

    totalIncomeCurrentMonth = await _processResponse(
      context,
      analyticsRepository.getTotalIncomeCurrentMonth(),
      'Total Income Current Month',
    );

    totalExpenseCurrentYear = await _processResponse(
      context,
      analyticsRepository.getTotalExpenseCurrentYear(),
      'Total Expense Current Year',
    );

    totalExpenseAllTime = await _processResponse(
      context,
      analyticsRepository.getTotalExpenseAllTime(),
      'Total Expense All Time',
    );

    categoryWiseExpenseCurrentMonth = await _processResponse(
      context,
      analyticsRepository.getCategoryWiseTotalExpenseCurrentMonth(),
      'Total Category Wise Expense Current Month',
    );
    monthWiseExpenseCurrentYear = await _processResponse(
      context,
      analyticsRepository.getMonthWiseTotalExpenseCurrentYear(),
      'Total Expense Current Year',
    );

    loadingStatus = LoadingStatus.loaded;
    notifyListeners();
  }

  Future _processResponse(
    BuildContext context,
    Future responseFuture,
    String logTag,
  ) async {
    final response = await responseFuture;

    return response.fold(
      (left) {
        logger.e("Error : $left");
        loadingStatus = LoadingStatus.error;
        notifyListeners();

        NotificationMessage.showError(context, message: left);
        return null; // Return null in case of error
      },
      (result) {
        logger.i("$logTag Analytics Response : $result");

        // If it's the last response to be processed, set the status to loaded
        if (logTag == 'Total Expense All Time') {
          loadingStatus = LoadingStatus.loaded;
          notifyListeners();
        }
        return result; // Store the result
      },
    );
  }
}
