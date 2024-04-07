import 'package:get/get.dart';

import 'base_page_controller.dart';

class BasePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasePageController>(
      () => BasePageController(),
    );
  }
}
