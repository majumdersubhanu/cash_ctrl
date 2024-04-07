import 'package:get/get.dart';

import 'lending_controller.dart';

class LendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LendingController>(
      () => LendingController(),
    );
  }
}
