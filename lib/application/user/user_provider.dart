import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/domain/user/imp_user_repo.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:cash_ctrl/shared/widgets/notification_message.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserProvider extends ChangeNotifier {
  final ImpUserRepository userRepository;

  UserProvider(this.userRepository);

  Future<void> update(BuildContext context, Map<String, dynamic> data) async {
    final result = await userRepository.update(data);

    notifyListeners();

    await result.fold(
      (left) {
        logger.e("Error : $left");
        notifyListeners();

        NotificationMessage.showError(context, message: left);
      },
      (user) async {
        await getIt<AppPrefs>().currentUser.setValue(user);

        logger.i("Profile Update Response : $user");
        notifyListeners();

        NotificationMessage.showSuccess(context,
            message: "Profile Creation Successful");

        context.replaceRoute(const BaseRoute());
      },
    );
  }
}
