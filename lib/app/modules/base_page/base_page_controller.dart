import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../analytics/analytics_binding.dart';
import '../home/home_binding.dart';
import '../lending/lending_binding.dart';
import '../profile/profile_binding.dart';
import '../splits/splits_binding.dart';

class BasePageController extends GetxController {
  static BasePageController get to => Get.find();

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  var currentIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
    HomeBinding().dependencies();
    AnalyticsBinding().dependencies();
    ProfileBinding().dependencies();
    LendingBinding().dependencies();
    SplitsBinding().dependencies();
  }

  void changePage(int index) {
    currentIndex.value = index;

    pageController.jumpToPage(index);
  }
}
