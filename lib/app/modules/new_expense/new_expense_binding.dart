import 'package:get/get.dart';

import 'new_expense_controller.dart';

class NewExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewExpenseController>(
      () => NewExpenseController(),
    );
  }
}
