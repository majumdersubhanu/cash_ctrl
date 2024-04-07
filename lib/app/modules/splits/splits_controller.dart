import 'package:get/get.dart';

class SplitsController extends GetxController {
  RxInt tabIndex = 0.obs;

  // Method to change the tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
