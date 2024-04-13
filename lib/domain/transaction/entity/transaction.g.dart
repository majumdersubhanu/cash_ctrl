// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as int,
      name: json['name'] as String?,
      paymentType: json['payment_type'] as String?,
      transactionType: json['transaction_type'] as String?,
      amount: json['amount'] as String?,
      date: json['date'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'payment_type': instance.paymentType,
      'transaction_type': instance.transactionType,
      'amount': instance.amount,
      'date': instance.date,
      'category': instance.category,
      'description': instance.description,
    };
