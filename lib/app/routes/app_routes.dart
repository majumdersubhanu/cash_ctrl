part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const PROFILE_COMPLETION = _Paths.PROFILE_COMPLETION;
  static const BASE_PAGE = _Paths.BASE_PAGE;
  static const ANALYTICS = _Paths.ANALYTICS;
  static const PROFILE = _Paths.PROFILE;
  static const LENDING = _Paths.LENDING;
  static const NEW_EXPENSE = _Paths.NEW_EXPENSE;
  static const OTP_VERIFICATION = _Paths.OTP_VERIFICATION;
  static const BORROW = _Paths.BORROW;
  static const LEND = _Paths.LEND;
  static const GROUPS = _Paths.GROUPS;
  static const SPLITS = _Paths.SPLITS;
  static const SPLIT_PAYMENTS = _Paths.SPLIT_PAYMENTS;
  static const TRANSACTION_DETAILS = _Paths.TRANSACTION_DETAILS;
  static const NEW_GROUP = _Paths.NEW_GROUP;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const LOGIN = '/auth/login';
  static const REGISTER = '/auth/register';
  static const FORGOT_PASSWORD = '/auth/forgot-password';
  static const PROFILE_COMPLETION = '/profile-completion';
  static const BASE_PAGE = '/base-page';
  static const ANALYTICS = '/analytics';
  static const PROFILE = '/profile';
  static const LENDING = '/lending';
  static const NEW_EXPENSE = '/new-expense';
  static const OTP_VERIFICATION = '/auth/otp-verification';
  static const BORROW = '/borrow';
  static const LEND = '/lend';
  static const GROUPS = '/groups';
  static const SPLITS = '/splits';
  static const SPLIT_PAYMENTS = '/split-payments';
  static const TRANSACTION_DETAILS = '/transaction-details';
  static const NEW_GROUP = '/new-group';
}
