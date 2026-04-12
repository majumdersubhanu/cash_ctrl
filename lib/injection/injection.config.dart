// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../application/analytics/analytics_provider.dart' as _i759;
import '../application/auth/auth_provider.dart' as _i366;
import '../application/profile_completion/profile_completion_provider.dart'
    as _i1057;
import '../application/transaction/transaction_provider.dart' as _i416;
import '../application/user/user_provider.dart' as _i1047;
import '../core/api_client.dart' as _i862;
import '../domain/analytics/imp_analytics_repo.dart' as _i462;
import '../domain/auth/imp_auth_repo.dart' as _i102;
import '../domain/transaction/imp_transaction_repo.dart' as _i279;
import '../domain/user/imp_user_repo.dart' as _i439;
import '../infrastructure/analytics/analytics_repo.dart' as _i158;
import '../infrastructure/auth/auth_repo.dart' as _i1003;
import '../infrastructure/transaction/transaction_repo.dart' as _i1071;
import '../infrastructure/user/user_repo.dart' as _i277;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1057.ProfileCompletionProvider>(
        () => _i1057.ProfileCompletionProvider());
    gh.factory<_i862.APIClient>(() => _i862.APIClient());
    gh.lazySingleton<_i102.ImpAuthRepository>(
        () => _i1003.AuthRepository(gh<_i862.APIClient>()));
    gh.lazySingleton<_i462.ImpAnalyticsRepository>(
        () => _i158.AnalyticsRepository(gh<_i862.APIClient>()));
    gh.lazySingleton<_i279.ImpTransactionRepository>(
        () => _i1071.TransactionRepo(gh<_i862.APIClient>()));
    gh.factory<_i759.AnalyticsProvider>(
        () => _i759.AnalyticsProvider(gh<_i462.ImpAnalyticsRepository>()));
    gh.factory<_i416.TransactionProvider>(
        () => _i416.TransactionProvider(gh<_i279.ImpTransactionRepository>()));
    gh.lazySingleton<_i439.ImpUserRepository>(
        () => _i277.UserRepository(gh<_i862.APIClient>()));
    gh.factory<_i1047.UserProvider>(
        () => _i1047.UserProvider(gh<_i439.ImpUserRepository>()));
    gh.factory<_i366.AuthProvider>(
        () => _i366.AuthProvider(gh<_i102.ImpAuthRepository>()));
    return this;
  }
}
