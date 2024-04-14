import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/presentation/analytics/analytics_page.dart';
import 'package:cash_ctrl/presentation/base_page.dart';
import 'package:cash_ctrl/presentation/borrow_money/borrow_money.dart';
import 'package:cash_ctrl/presentation/dashboard/dashboard_page.dart';
import 'package:cash_ctrl/presentation/forgot_password/forgot_password_page.dart';
import 'package:cash_ctrl/presentation/lend_money/lend_money_page.dart';
import 'package:cash_ctrl/presentation/login/login_page.dart';
import 'package:cash_ctrl/presentation/new_expense/new_expense_page.dart';
import 'package:cash_ctrl/presentation/profile/profile_page.dart';
import 'package:cash_ctrl/presentation/profile_completion/profile_completion_page.dart';
import 'package:cash_ctrl/presentation/register/register_page.dart';
import 'package:cash_ctrl/presentation/transaction_details/transaction_details.dart';
import 'package:cash_ctrl/presentation/transactions/transactions_page.dart';
import 'package:cash_ctrl/routing/guards/auth_guard.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: BaseRoute.page,
          initial: true,
          guards: [
            AuthGuard(),
          ],
          children: [
            AutoRoute(page: DashboardRoute.page, initial: true),
            AutoRoute(page: AnalyticsRoute.page),
            AutoRoute(page: TransactionsRoute.page),
          ],
        ),
        AutoRoute(page: LoginRoute.page, keepHistory: false),
        AutoRoute(page: RegisterRoute.page, keepHistory: false),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ProfileCompletionRoute.page),
        AutoRoute(page: NewExpenseRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: BorrowMoneyRoute.page),
        AutoRoute(page: LendMoneyRoute.page),
        AutoRoute(page: TransactionDetailsRoute.page),
      ];
}
