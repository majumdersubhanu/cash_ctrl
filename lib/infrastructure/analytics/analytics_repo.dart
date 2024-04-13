import 'package:cash_ctrl/core/api_client.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/analytics/imp_analytics_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImpAnalyticsRepository)
class AnalyticsRepository extends ImpAnalyticsRepository {
  final APIClient apiClient;

  AnalyticsRepository(this.apiClient);

  @override
  Future<Either<String, double?>> getTotalExpenseAllTime() async {
    //TODO: Implement the all time expense
    try {
      final response =
          await apiClient.get('/transactions/total_expenditure_current_month');

      return Right(response.data['total_expenditure_current_month']);
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, double?>> getTotalExpenseCurrentMonth() async {
    try {
      final response =
          await apiClient.get('/transactions/total_expenditure_current_month');

      return Right(response.data['total_expenditure_current_month']);
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, double?>> getTotalExpenseCurrentYear() async {
    try {
      final response =
          await apiClient.get('/transactions/total_expenditure_current_year');

      return Right(response.data['total_expenditure_current_year']);
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, double?>> getTotalIncomeCurrentMonth() async {
    try {
      final response =
          await apiClient.get('/transactions/total_income_current_month');

      return Right(response.data['total_income_current_month']);
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>>
      getCategoryWiseTotalExpenseCurrentMonth() async {
    try {
      final response =
          await apiClient.get('/transactions/category_wise_expenses');

      // logger.f(response.data);

      return Right(response.data);
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, List<double?>>>
      getMonthWiseTotalExpenseCurrentYear() async {
    try {
      final response = await apiClient.get('/transactions/month_wise_expenses');

      return Right(List.from(response.data));
    } catch (e) {
      logger.e("Error while fetching analytics: $e");

      String errorMessage = "Failed to fetch analytics";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }
}
