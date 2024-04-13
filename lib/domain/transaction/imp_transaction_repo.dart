import 'package:cash_ctrl/domain/transaction/entity/transaction.dart';
import 'package:dartz/dartz.dart';

abstract class ImpTransactionRepository {
  Future<Either<String, List<Transaction>>> getTransactions();
  Future<Either<String, Transaction>> addTransactions(
      Map<String, dynamic> data);
}
