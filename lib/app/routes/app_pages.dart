import 'package:get/get.dart';

import '../modules/auth/forgot_password/forgot_password_binding.dart';
import '../modules/auth/forgot_password/forgot_password_view.dart';
import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/otp_verification/otp_verification_binding.dart';
import '../modules/auth/otp_verification/otp_verification_view.dart';
import '../modules/auth/register/register_binding.dart';
import '../modules/auth/register/register_view.dart';
import '../modules/base_page/base_page_binding.dart';
import '../modules/base_page/base_page_view.dart';
import '../modules/borrow/borrow_binding.dart';
import '../modules/borrow/borrow_view.dart';
import '../modules/groups/groups_binding.dart';
import '../modules/groups/groups_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/lend/lend_binding.dart';
import '../modules/lend/lend_view.dart';
import '../modules/lending/lending_binding.dart';
import '../modules/lending/lending_view.dart';
import '../modules/new_expense/new_expense_binding.dart';
import '../modules/new_expense/new_expense_view.dart';
import '../modules/new_group/new_group_binding.dart';
import '../modules/new_group/new_group_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/profile_completion/profile_completion_binding.dart';
import '../modules/profile_completion/profile_completion_view.dart';
import '../modules/split_payments/split_payments_binding.dart';
import '../modules/split_payments/split_payments_view.dart';
import '../modules/splits/splits_binding.dart';
import '../modules/splits/splits_view.dart';
import '../modules/transaction_details/transaction_details_binding.dart';
import '../modules/transaction_details/transaction_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_COMPLETION,
      page: () => ProfileCompletionView(),
      binding: ProfileCompletionBinding(),
    ),
    GetPage(
      name: _Paths.BASE_PAGE,
      page: () => const BasePageView(),
      binding: BasePageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LENDING,
      page: () => const LendingView(),
      binding: LendingBinding(),
    ),
    GetPage(
      name: _Paths.NEW_EXPENSE,
      page: () => NewExpenseView(),
      binding: NewExpenseBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.BORROW,
      page: () => BorrowView(),
      binding: BorrowBinding(),
    ),
    GetPage(
      name: _Paths.LEND,
      page: () => const LendView(),
      binding: LendBinding(),
    ),
    GetPage(
      name: _Paths.SPLITS,
      page: () => const SplitsView(),
      binding: SplitsBinding(),
    ),
    GetPage(
      name: _Paths.SPLIT_PAYMENTS,
      page: () => const SplitPaymentsView(),
      binding: SplitPaymentsBinding(),
    ),
    GetPage(
      name: _Paths.GROUPS,
      page: () => const GroupsView(),
      binding: GroupsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_DETAILS,
      page: () => const TransactionDetailsView(),
      binding: TransactionDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NEW_GROUP,
      page: () => NewGroupView(),
      binding: NewGroupBinding(),
    ),
  ];
}
