// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../application/analytics/analytics_provider.dart' as _i11;
import '../application/auth/auth_provider.dart' as _i16;
import '../application/profile_completion/profile_completion_provider.dart'
    as _i3;
import '../application/transaction/transaction_provider.dart' as _i12;
import '../application/user/user_provider.dart' as _i15;
import '../core/api_client.dart' as _i4;
import '../domain/analytics/imp_analytics_repo.dart' as _i7;
import '../domain/auth/imp_auth_repo.dart' as _i5;
import '../domain/transaction/imp_transaction_repo.dart' as _i9;
import '../domain/user/imp_user_repo.dart' as _i13;
import '../infrastructure/analytics/analytics_repo.dart' as _i8;
import '../infrastructure/auth/auth_repo.dart' as _i6;
import '../infrastructure/transaction/transaction_repo.dart' as _i10;
import '../infrastructure/user/user_repo.dart' as _i14;

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
    gh.factory<_i3.ProfileCompletionProvider>(
        () => _i3.ProfileCompletionProvider());
    gh.factory<_i4.APIClient>(() => _i4.APIClient());
    gh.lazySingleton<_i5.ImpAuthRepository>(
        () => _i6.AuthRepository(gh<_i4.APIClient>()));
    gh.lazySingleton<_i7.ImpAnalyticsRepository>(
        () => _i8.AnalyticsRepository(gh<_i4.APIClient>()));
    gh.lazySingleton<_i9.ImpTransactionRepository>(
        () => _i10.TransactionRepo(gh<_i4.APIClient>()));
    gh.factory<_i11.AnalyticsProvider>(
        () => _i11.AnalyticsProvider(gh<_i7.ImpAnalyticsRepository>()));
    gh.factory<_i12.TransactionProvider>(
        () => _i12.TransactionProvider(gh<_i9.ImpTransactionRepository>()));
    gh.lazySingleton<_i13.ImpUserRepository>(
        () => _i14.UserRepository(gh<_i4.APIClient>()));
    gh.factory<_i15.UserProvider>(
        () => _i15.UserProvider(gh<_i13.ImpUserRepository>()));
    gh.factory<_i16.AuthProvider>(
        () => _i16.AuthProvider(gh<_i5.ImpAuthRepository>()));
    return this;
  }
}
