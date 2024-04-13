import 'package:dartz/dartz.dart';

abstract class ImpAnalyticsRepository {
  Future<Either<String, double?>> getTotalExpenseCurrentMonth();

  Future<Either<String, double?>> getTotalIncomeCurrentMonth();

  Future<Either<String, double?>> getTotalExpenseCurrentYear();

  Future<Either<String, double?>> getTotalExpenseAllTime();

  Future<Either<String, Map<String, dynamic>>>
      getCategoryWiseTotalExpenseCurrentMonth();

  Future<Either<String, List<double?>>> getMonthWiseTotalExpenseCurrentYear();
}
