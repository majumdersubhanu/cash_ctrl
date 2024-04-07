import 'package:get/get.dart';

import 'new_category_controller.dart';

class NewCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewCategoryController>(
      () => NewCategoryController(),
    );
  }
}
