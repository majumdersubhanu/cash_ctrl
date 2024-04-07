import 'package:get/get.dart';

import 'lend_controller.dart';

class LendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LendController>(
      () => LendController(),
    );
  }
}
