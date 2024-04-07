import 'package:get/get.dart';

import 'split_payments_controller.dart';

class SplitPaymentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplitPaymentsController>(
      () => SplitPaymentsController(),
    );
  }
}
