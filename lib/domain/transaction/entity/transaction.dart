import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required String? name,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'transaction_type') String? transactionType,
    String? amount,
    String? date,
    String? category,
    String? description,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
