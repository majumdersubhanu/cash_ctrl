import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/domain/auth/imp_auth_repo.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:cash_ctrl/shared/widgets/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

enum LoginStatus { initial, loading, loaded, error }

@injectable
class AuthProvider extends ChangeNotifier {
  final ImpAuthRepository authRepository;

  AuthProvider(this.authRepository);

  LoginStatus loginStatus = LoginStatus.initial;

  Future<void> login(BuildContext context, Map<String, dynamic> data) async {
    final result = await authRepository.login(data);

    loginStatus = LoginStatus.loading;
    notifyListeners();

    await result.fold(
      (left) {
        logger.e("Error : $left");
        loginStatus = LoginStatus.error;
        notifyListeners();

        NotificationMessage.showError(context, message: left);
      },
      (authenticatedUser) async {
        await getIt<AppPrefs>().authUser.setValue(authenticatedUser);

        logger.i("Login Response : $authenticatedUser");

        loginStatus = LoginStatus.loaded;
        notifyListeners();

        NotificationMessage.showSuccess(context, message: "Login Success");

        context.replaceRoute(const BaseRoute());
      },
    );
  }

  Future<void> register(BuildContext context, Map<String, dynamic> data) async {
    final result = await authRepository.register(data);

    loginStatus = LoginStatus.loading;
    notifyListeners();

    await result.fold(
      (left) {
        logger.e("Error : $left");
        loginStatus = LoginStatus.error;
        notifyListeners();

        NotificationMessage.showError(context, message: left);
      },
      (authenticatedUser) async {
        await getIt<AppPrefs>().authUser.setValue(authenticatedUser);

        logger.i("Registration Response : $authenticatedUser");

        loginStatus = LoginStatus.loaded;
        notifyListeners();

        NotificationMessage.showSuccess(context,
            message: "Registration Successful");

        context.replaceRoute(ProfileCompletionRoute());
      },
    );
  }

  Future<void> resetPassword(
      BuildContext context, Map<String, dynamic> data) async {
    final result = await authRepository.resetPassword(
        data['username'], data['new_password'], data['confirm_new_password']);

    if (result.ok) {
      NotificationMessage.showSuccess(context,
          message: "Password reset successfully");
      AutoRouter.of(context).pushAndPopUntil(
        LoginRoute(),
        predicate: (_) => false,
      );
    } else {
      NotificationMessage.showError(context,
          message: "Failed to reset password");
    }
  }

  Future<void> logout(BuildContext context) async {
    await getIt<AppPrefs>().clear();

    AutoRouter.of(context).pushAndPopUntil(
      LoginRoute(),
      predicate: (_) => false,
    );
  }
}
