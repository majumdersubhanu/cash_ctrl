import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum ExpenseCategory {
  Food,
  Travel,
  Entertainment,
  Utilities,
  Shopping,
  Health,
  Education,
  Insurance,
  Investment,
  Miscellaneous,
}

enum PaymentMode {
  Cash,
  Card,
  UPI,
}

String getExpenseName(ExpenseCategory expenseCategory) {
  switch (expenseCategory) {
    case ExpenseCategory.Food:
      return 'Food';
    case ExpenseCategory.Travel:
      return 'Travel';
    case ExpenseCategory.Entertainment:
      return 'Entertainment';
    case ExpenseCategory.Utilities:
      return 'Utilities';
    case ExpenseCategory.Shopping:
      return 'Shopping';
    case ExpenseCategory.Health:
      return 'Health';
    case ExpenseCategory.Education:
      return 'Education';
    case ExpenseCategory.Insurance:
      return 'Insurance';
    case ExpenseCategory.Investment:
      return 'Investment';
    case ExpenseCategory.Miscellaneous:
      return 'Miscellaneous';
    default:
      return 'Unknown';
  }
}

String getPaymentModeName(PaymentMode paymentMode) {
  switch (paymentMode) {
    case PaymentMode.Cash:
      return 'Cash';
    case PaymentMode.Card:
      return 'Card';
    case PaymentMode.UPI:
      return 'UPI';
    default:
      return 'Unknown';
  }
}

IconData? getPaymentModeIcon(PaymentMode paymentMode) {
  switch (paymentMode) {
    case PaymentMode.Cash:
      return Ionicons.cash_outline;
    case PaymentMode.Card:
      return Ionicons.card_outline;
    case PaymentMode.UPI:
      return Ionicons.phone_portrait_outline;
    default:
      return Ionicons.help_circle_outline;
  }
}

IconData getExpenseCategoryIcon(ExpenseCategory expenseCategory) {
  switch (expenseCategory) {
    case ExpenseCategory.Food:
      return Ionicons.fast_food_outline;
    case ExpenseCategory.Travel:
      return Ionicons.train_outline;
    case ExpenseCategory.Entertainment:
      return Ionicons.extension_puzzle_outline;
    case ExpenseCategory.Utilities:
      return Ionicons.construct_outline;
    case ExpenseCategory.Shopping:
      return Ionicons.cart_outline;
    case ExpenseCategory.Health:
      return Ionicons.medkit_outline;
    case ExpenseCategory.Education:
      return Ionicons.school_outline;
    case ExpenseCategory.Insurance:
      return Ionicons.calendar_number_outline;
    case ExpenseCategory.Investment:
      return Ionicons.trending_up_outline;
    case ExpenseCategory.Miscellaneous:
      return Ionicons.layers_outline;
    default:
      return Ionicons.bug_outline;
  }
}

PaymentMode getPaymentModeValue(String paymentMode) {
  switch (paymentMode) {
    case 'Cash':
      return PaymentMode.Cash;
    case 'Card':
      return PaymentMode.Card;
    case 'UPI':
      return PaymentMode.UPI;
    default:
      return PaymentMode.Cash;
  }
}

ExpenseCategory getExpenseCategoryValue(String category) {
  switch (category) {
    case 'Food':
      return ExpenseCategory.Food;
    case 'Travel':
      return ExpenseCategory.Travel;
    case 'Entertainment':
      return ExpenseCategory.Entertainment;
    case 'Utilities':
      return ExpenseCategory.Utilities;
    case 'Shopping':
      return ExpenseCategory.Shopping;
    case 'Health':
      return ExpenseCategory.Health;
    case 'Education':
      return ExpenseCategory.Education;
    case 'Insurance':
      return ExpenseCategory.Insurance;
    case 'Investment':
      return ExpenseCategory.Investment;
    case 'Miscellaneous':
      return ExpenseCategory.Miscellaneous;
    default:
      return ExpenseCategory
          .Miscellaneous; // Assuming Miscellaneous as a default category
  }
}
