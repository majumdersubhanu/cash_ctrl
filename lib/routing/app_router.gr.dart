// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter();

  @override
  final Map<String, PageFactory> pagesMap = {
    AnalyticsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnalyticsPage(),
      );
    },
    BaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasePage(),
      );
    },
    BorrowMoneyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BorrowMoneyPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    LendMoneyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LendMoneyPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(key: args.key),
      );
    },
    NewExpenseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewExpensePage(),
      );
    },
    ProfileCompletionRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileCompletionRouteArgs>(
          orElse: () => const ProfileCompletionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileCompletionPage(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(key: args.key),
      );
    },
    TransactionDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionDetailsPage(
          key: args.key,
          arguments: args.arguments,
        ),
      );
    },
    TransactionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransactionsPage(),
      );
    },
  };
}

/// generated route for
/// [AnalyticsPage]
class AnalyticsRoute extends PageRouteInfo<void> {
  const AnalyticsRoute({List<PageRouteInfo>? children})
      : super(
          AnalyticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyticsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnalyticsPage();
    },
  );
}

/// generated route for
/// [BasePage]
class BaseRoute extends PageRouteInfo<void> {
  const BaseRoute({List<PageRouteInfo>? children})
      : super(
          BaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BasePage();
    },
  );
}

/// generated route for
/// [BorrowMoneyPage]
class BorrowMoneyRoute extends PageRouteInfo<void> {
  const BorrowMoneyRoute({List<PageRouteInfo>? children})
      : super(
          BorrowMoneyRoute.name,
          initialChildren: children,
        );

  static const String name = 'BorrowMoneyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BorrowMoneyPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [LendMoneyPage]
class LendMoneyRoute extends PageRouteInfo<void> {
  const LendMoneyRoute({List<PageRouteInfo>? children})
      : super(
          LendMoneyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LendMoneyRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LendMoneyPage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [NewExpensePage]
class NewExpenseRoute extends PageRouteInfo<void> {
  const NewExpenseRoute({List<PageRouteInfo>? children})
      : super(
          NewExpenseRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewExpenseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewExpensePage();
    },
  );
}

/// generated route for
/// [ProfileCompletionPage]
class ProfileCompletionRoute extends PageRouteInfo<ProfileCompletionRouteArgs> {
  ProfileCompletionRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileCompletionRoute.name,
          args: ProfileCompletionRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileCompletionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileCompletionRouteArgs>(
          orElse: () => const ProfileCompletionRouteArgs());
      return ProfileCompletionPage(key: args.key);
    },
  );
}

class ProfileCompletionRouteArgs {
  const ProfileCompletionRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ProfileCompletionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [TransactionDetailsPage]
class TransactionDetailsRoute
    extends PageRouteInfo<TransactionDetailsRouteArgs> {
  TransactionDetailsRoute({
    Key? key,
    required Map<String, dynamic> arguments,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailsRoute.name,
          args: TransactionDetailsRouteArgs(
            key: key,
            arguments: arguments,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransactionDetailsRouteArgs>();
      return TransactionDetailsPage(
        key: args.key,
        arguments: args.arguments,
      );
    },
  );
}

class TransactionDetailsRouteArgs {
  const TransactionDetailsRouteArgs({
    this.key,
    required this.arguments,
  });

  final Key? key;

  final Map<String, dynamic> arguments;

  @override
  String toString() {
    return 'TransactionDetailsRouteArgs{key: $key, arguments: $arguments}';
  }
}

/// generated route for
/// [TransactionsPage]
class TransactionsRoute extends PageRouteInfo<void> {
  const TransactionsRoute({List<PageRouteInfo>? children})
      : super(
          TransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransactionsPage();
    },
  );
}
