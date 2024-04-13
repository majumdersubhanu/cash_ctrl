// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../application/analytics/analytics_provider.dart' as _i10;
import '../application/auth/auth_provider.dart' as _i15;
import '../application/transaction/transaction_provider.dart' as _i11;
import '../application/user/user_provider.dart' as _i14;
import '../core/api_client.dart' as _i3;
import '../domain/analytics/imp_analytics_repo.dart' as _i6;
import '../domain/auth/imp_auth_repo.dart' as _i4;
import '../domain/transaction/imp_transaction_repo.dart' as _i8;
import '../domain/user/imp_user_repo.dart' as _i12;
import '../infrastructure/analytics/analytics_repo.dart' as _i7;
import '../infrastructure/auth/auth_repo.dart' as _i5;
import '../infrastructure/transaction/transaction_repo.dart' as _i9;
import '../infrastructure/user/user_repo.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.APIClient>(() => _i3.APIClient());
    gh.lazySingleton<_i4.ImpAuthRepository>(
        () => _i5.AuthRepository(gh<_i3.APIClient>()));
    gh.lazySingleton<_i6.ImpAnalyticsRepository>(
        () => _i7.AnalyticsRepository(gh<_i3.APIClient>()));
    gh.lazySingleton<_i8.ImpTransactionRepository>(
        () => _i9.TransactionRepo(gh<_i3.APIClient>()));
    gh.factory<_i10.AnalyticsProvider>(
        () => _i10.AnalyticsProvider(gh<_i6.ImpAnalyticsRepository>()));
    gh.factory<_i11.TransactionProvider>(
        () => _i11.TransactionProvider(gh<_i8.ImpTransactionRepository>()));
    gh.lazySingleton<_i12.ImpUserRepository>(
        () => _i13.UserRepository(gh<_i3.APIClient>()));
    gh.factory<_i14.UserProvider>(
        () => _i14.UserProvider(gh<_i12.ImpUserRepository>()));
    gh.factory<_i15.AuthProvider>(
        () => _i15.AuthProvider(gh<_i4.ImpAuthRepository>()));
    return this;
  }
}
