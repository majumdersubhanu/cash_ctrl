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
        title: Text(
          'Hey 👋, ${controller.user?.displayName?.split(' ').first}',
          style: Get.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
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
        onPressed: () => _handleFabPressed(),
        child: const Icon(Ionicons.add),
      ),
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  _handleFabPressed() {
    Get.bottomSheet(
      backgroundColor: Get.theme.colorScheme.surface,
      isDismissible: true,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Ionicons.paper_plane_outline),
            title: const Text('Add new expense'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.NEW_EXPENSE);
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.scan_outline),
            title: const Text('Lend money'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.LEND);
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.qr_code_outline),
            title: const Text('Borrow money'),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.BORROW);
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.pricetag_outline),
            title: const Text('Create new budget'),
            onTap: () {
              Get.back();
              // Get.toNamed(Routes.BORROW);
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.earth_outline),
            title: const Text('Add new category'),
            onTap: () {
              Get.back();
              // Get.toNamed(Routes.BORROW);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BasePageController(),
      builder: (controller) => Obx(
        () => NavigationBar(
          backgroundColor: Get.theme.colorScheme.surface,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Get.theme.colorScheme.primary,
          selectedIndex: controller.currentIndex.value,
          surfaceTintColor: Get.theme.colorScheme.surface,
          onDestinationSelected: (value) => controller.changePage(value),
          destinations: [
            NavigationDestination(
              icon: const Icon(Ionicons.cube_outline),
              label: 'Dashboard',
              selectedIcon: Icon(
                Ionicons.cube,
                color: Get.theme.colorScheme.surface,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Ionicons.pie_chart_outline),
              label: 'Analytics',
              selectedIcon: Icon(
                Ionicons.pie_chart,
                color: Get.theme.colorScheme.surface,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Ionicons.color_wand_outline),
              label: 'Split',
              selectedIcon: Icon(
                Ionicons.color_wand,
                color: Get.theme.colorScheme.surface,
              ),
            ),
            NavigationDestination(
              icon: const Icon(Ionicons.wallet_outline),
              label: 'Transactions',
              selectedIcon: Icon(
                Ionicons.wallet,
                color: Get.theme.colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
