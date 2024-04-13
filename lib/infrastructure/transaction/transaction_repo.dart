import 'package:cash_ctrl/core/api_client.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/transaction/entity/transaction.dart';
import 'package:cash_ctrl/domain/transaction/imp_transaction_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImpTransactionRepository)
class TransactionRepo extends ImpTransactionRepository {
  final APIClient apiClient;

  TransactionRepo(this.apiClient);

  @override
  Future<Either<String, List<Transaction>>> getTransactions() async {
    try {
      final response = await apiClient.get('/transactions/');

      return Right(List.from(response.data)
          .map((e) => Transaction.fromJson(e))
          .toList());
    } catch (e) {
      logger.e("Error during fetching transactions: $e");

      String errorMessage = "Failed to fetch transactions";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, Transaction>> addTransactions(
      Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post('/transactions/', data: data);

      logger.f(data);

      return Right(Transaction.fromJson(response.data));
    } catch (e) {
      logger.e("Error during adding transactions: $e");

      String errorMessage = "Failed to add transactions";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }
}
