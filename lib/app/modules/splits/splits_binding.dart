import 'package:get/get.dart';

import 'splits_controller.dart';

class SplitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplitsController>(
      () => SplitsController(),
    );
  }
}
