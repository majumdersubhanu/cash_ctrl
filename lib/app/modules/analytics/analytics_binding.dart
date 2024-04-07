import 'package:get/get.dart';

import 'analytics_controller.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AnalyticsController>(
      AnalyticsController(),
    );
  }
}
