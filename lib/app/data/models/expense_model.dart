import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  Timestamp? createdAt;
  Transaction? transaction;
  String? user;

  Expense({this.createdAt, this.transaction, this.user});

  Expense.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    transaction = json['transaction'] != null
        ? Transaction?.fromJson(json['transaction'])
        : null;
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    if (transaction != null) {
      data['transaction'] = transaction?.toJson();
    }
    data['user'] = user;
    return data;
  }
}

class Transaction {
  double? amount;
  dynamic description;
  String? paymentCategory;
  String? paymentType;
  String? title;

  Transaction(
      {this.amount,
      this.description,
      this.paymentCategory,
      this.paymentType,
      this.title});

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
    paymentCategory = json['paymentCategory'];
    paymentType = json['paymentType'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['amount'] = amount;
    data['description'] = description;
    data['paymentCategory'] = paymentCategory;
    data['paymentType'] = paymentType;
    data['title'] = title;
    return data;
  }
}
