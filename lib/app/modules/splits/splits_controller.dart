import 'package:get/get.dart';

class SplitsController extends GetxController {
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
