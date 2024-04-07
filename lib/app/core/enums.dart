import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

enum ExpenseCategory {
  food,
  travel,
  entertainment,
  utilities,
  shopping,
  health,
  education,
  insurance,
  investment,
  miscellaneous,
}

enum PaymentMode {
  cash,
  card,
  upi,
}

String getCategoryName(ExpenseCategory expenseCategory) {
  switch (expenseCategory) {
    case ExpenseCategory.food:
      return 'Food';
    case ExpenseCategory.travel:
      return 'Travel';
    case ExpenseCategory.entertainment:
      return 'Entertainment';
    case ExpenseCategory.utilities:
      return 'Utilities';
    case ExpenseCategory.shopping:
      return 'Shopping';
    case ExpenseCategory.health:
      return 'Health';
    case ExpenseCategory.education:
      return 'Education';
    case ExpenseCategory.insurance:
      return 'Insurance';
    case ExpenseCategory.investment:
      return 'Investment';
    case ExpenseCategory.miscellaneous:
      return 'Miscellaneous';
    default:
      return 'Unknown';
  }
}

String getPaymentModeName(PaymentMode paymentMode) {
  switch (paymentMode) {
    case PaymentMode.cash:
      return 'Cash';
    case PaymentMode.card:
      return 'Card';
    case PaymentMode.upi:
      return 'UPI';
    default:
      return 'Unknown';
  }
}

IconData? getPaymentModeIcon(PaymentMode paymentMode) {
  switch (paymentMode) {
    case PaymentMode.cash:
      return Ionicons.cash_outline;
    case PaymentMode.card:
      return Ionicons.card_outline;
    case PaymentMode.upi:
      return Ionicons.phone_portrait_outline;
    default:
      return Ionicons.help_circle_outline;
  }
}

IconData getCategoryIcon(ExpenseCategory expenseCategory) {
  switch (expenseCategory) {
    case ExpenseCategory.food:
      return Ionicons.fast_food_outline;
    case ExpenseCategory.travel:
      return Ionicons.airplane_outline;
    case ExpenseCategory.entertainment:
      return Ionicons.extension_puzzle_outline;
    case ExpenseCategory.utilities:
      return Ionicons.construct_outline;
    case ExpenseCategory.shopping:
      return Ionicons.cart_outline;
    case ExpenseCategory.health:
      return Ionicons.medkit_outline;
    case ExpenseCategory.education:
      return Ionicons.school_outline;
    case ExpenseCategory.insurance:
      return Ionicons.calendar_number_outline;
    case ExpenseCategory.investment:
      return Ionicons.trending_up_outline;
    case ExpenseCategory.miscellaneous:
      return Ionicons.layers_outline;
    default:
      return Ionicons.bug_outline;
  }
}

PaymentMode getPaymentModeEnumValue(String paymentMode) {
  switch (paymentMode) {
    case 'Cash':
      return PaymentMode.cash;
    case 'Card':
      return PaymentMode.card;
    case 'UPI':
      return PaymentMode.upi;
    default:
      return PaymentMode.cash;
  }
}

ExpenseCategory getExpenseCategoryEnumValue(String category) {
  switch (category) {
    case 'Food':
      return ExpenseCategory.food;
    case 'Travel':
      return ExpenseCategory.travel;
    case 'Entertainment':
      return ExpenseCategory.entertainment;
    case 'Utilities':
      return ExpenseCategory.utilities;
    case 'Shopping':
      return ExpenseCategory.shopping;
    case 'Health':
      return ExpenseCategory.health;
    case 'Education':
      return ExpenseCategory.education;
    case 'Insurance':
      return ExpenseCategory.insurance;
    case 'Investment':
      return ExpenseCategory.investment;
    case 'Miscellaneous':
      return ExpenseCategory.miscellaneous;
    default:
      return ExpenseCategory.miscellaneous;
  }
}
