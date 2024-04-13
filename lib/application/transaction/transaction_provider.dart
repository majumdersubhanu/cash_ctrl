import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/transaction/entity/transaction.dart';
import 'package:cash_ctrl/domain/transaction/imp_transaction_repo.dart';
import 'package:cash_ctrl/shared/widgets/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class TransactionProvider extends ChangeNotifier {
  final ImpTransactionRepository transactionRepository;

  TransactionProvider(this.transactionRepository);

  List<Transaction>? transactions;

  Future<void> fetchTransactions(BuildContext context) async {
    final result = await transactionRepository.getTransactions();

    notifyListeners();

    await result.fold(
      (left) {
        logger.e("Error : $left");
        notifyListeners();

        NotificationMessage.showError(context, message: left);
      },
      (transactionList) async {
        logger.i("Transaction fetch Response : $transactionList");
        notifyListeners();

        transactions = transactionList.reversed.toList();

        NotificationMessage.showSuccess(context,
            message: "Transaction fetched Successfully");
      },
    );
  }

  Future<void> addTransaction(
      BuildContext context, Map<String, Object?> data) async {
    final result = await transactionRepository.addTransactions(data);

    notifyListeners();

    await result.fold(
      (left) {
        logger.e("Error : $left");
        notifyListeners();

        NotificationMessage.showError(context, message: left);
      },
      (transactionList) async {
        logger.i("Transaction add Response : $transactionList");

        fetchTransactions(context);

        notifyListeners();

        NotificationMessage.showSuccess(context,
            message: "Transaction added Successfully");
      },
    );
  }
}
