import 'package:cash_ctrl/application/analytics/analytics_provider.dart';
import 'package:cash_ctrl/application/auth/auth_provider.dart';
import 'package:cash_ctrl/application/profile_completion/profile_completion_provider.dart';
import 'package:cash_ctrl/application/transaction/transaction_provider.dart';
import 'package:cash_ctrl/application/user/user_provider.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:provider/provider.dart';

final List providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => getIt<AuthProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<UserProvider>(
    create: (_) => getIt<UserProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AnalyticsProvider>(
    create: (_) => getIt<AnalyticsProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<TransactionProvider>(
    create: (_) => getIt<TransactionProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<ProfileCompletionProvider>(
    create: (_) => getIt<ProfileCompletionProvider>(),
    lazy: false,
  ),
];
