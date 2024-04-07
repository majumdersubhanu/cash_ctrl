import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../routes/app_pages.dart';
import '../analytics/analytics_view.dart';
import '../home/home_view.dart';
import '../lending/lending_view.dart';
import '../splits/splits_view.dart';
import 'base_page_controller.dart';

class BasePageView extends GetView<BasePageController> {
  const BasePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.PROFILE),
            child: controller.user?.photoURL != null
                ? CircleAvatar(
                    radius: 22,
                    backgroundColor: Get.theme.colorScheme.secondary,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(controller.user?.photoURL ?? ""),
                    ),
                  )
                : RandomAvatar('saytoonz', height: 20, width: 20),
          ),
          const Gap(8),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Get.theme.colorScheme.surface,
        foregroundColor: Get.theme.colorScheme.onSurface,
        onPressed: () => Get.bottomSheet(
          backgroundColor: Get.theme.colorScheme.surface,
          isDismissible: true,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Ionicons.paper_plane_outline),
                title: const Text('New Expense'),
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.NEW_EXPENSE);
                },
              ),
              ListTile(
                leading: const Icon(Ionicons.scan_outline),
                title: const Text('Lend Money'),
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.LEND);
                },
              ),
              ListTile(
                leading: const Icon(Ionicons.qr_code_outline),
                title: const Text('Borrow Money'),
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.BORROW);
                },
              ),
            ],
          ),
        ),
        child: const Icon(Ionicons.add),
      ),
      extendBody: false,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            AnalyticsView(),
            SplitsView(),
            LendingView(),
          ],
        ),
      ),
      bottomNavigationBar: buildNavBar(),
    );
  }

  buildNavBar() {
    return Obx(
      () => NavigationBar(
        backgroundColor: Get.theme.colorScheme.surface,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: Get.theme.colorScheme.primary,
        selectedIndex: controller.currentIndex.value,
        surfaceTintColor: Get.theme.colorScheme.surface,
        onDestinationSelected: (value) => controller.changePage(value),
        // animationDuration: Durations.short4,
        destinations: [
          NavigationDestination(
            icon: Icon(Ionicons.cube_outline),
            label: 'Dashboard',
            selectedIcon: Icon(
              Ionicons.cube,
              color: Get.theme.colorScheme.surface,
            ),
          ),
          NavigationDestination(
            icon: Icon(Ionicons.pie_chart_outline),
            label: 'Analytics',
            selectedIcon: Icon(
              Ionicons.pie_chart,
              color: Get.theme.colorScheme.surface,
            ),
          ),
          NavigationDestination(
            icon: Icon(Ionicons.color_wand_outline),
            label: 'Split',
            selectedIcon: Icon(
              Ionicons.color_wand,
              color: Get.theme.colorScheme.surface,
            ),
          ),
          NavigationDestination(
            icon: Icon(Ionicons.wallet_outline),
            label: 'Transactions',
            selectedIcon: Icon(
              Ionicons.wallet,
              color: Get.theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
