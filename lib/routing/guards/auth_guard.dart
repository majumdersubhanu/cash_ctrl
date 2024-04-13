import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authUser = getIt<AppPrefs>().authUser.getValue();

    if (authUser != null) {
      resolver.next();
    } else {
      resolver.redirect(
        LoginRoute(),
      );
    }
  }
}
