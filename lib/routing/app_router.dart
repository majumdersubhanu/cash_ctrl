import 'package:auto_route/auto_route.dart';
import 'package:fit_sync_plus/presentation/screens/forgot_password/forgot_password_page.dart';
import 'package:fit_sync_plus/presentation/screens/landing/landing_page.dart';
import 'package:fit_sync_plus/presentation/screens/login/login_page.dart';
import 'package:fit_sync_plus/presentation/screens/register/register_page.dart';
import 'package:fit_sync_plus/presentation/screens/user_details/user_details_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: UserDetailsRoute.page),
        AutoRoute(page: LandingRoute.page),
      ];
}
