import 'package:get/get.dart';

import 'new_group_controller.dart';

class NewGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewGroupController>(
      () => NewGroupController(),
    );
  }
}
