import 'package:get/get.dart';

import 'borrow_controller.dart';

class BorrowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BorrowController>(
      () => BorrowController(),
    );
  }
}
