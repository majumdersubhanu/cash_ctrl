import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';

import '../../core/enums.dart';
import '../../core/extensions.dart';
import '../../routes/app_pages.dart';
import '../base_page/base_page_controller.dart';
import '../lending/lending_controller.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          primary: true,
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.ideographic,
            children: [
              PageLabel(label: 'Dashboard'),
              Gap(20),
              DashboardAnalytics(),
              Gap(20),
              DashboardQuickActionsContainer(),
              Gap(20),
              DashboardRecentExpensesListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardRecentExpensesListView extends StatelessWidget {
  const DashboardRecentExpensesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Expenses',
              style: Get.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.find<BasePageController>().changePage(3);
                Get.find<LendingController>().scrollToBottom();
              },
              child: const Text('View more'),
            ),
          ],
        ),
        const Gap(20),
        GetBuilder(
          init: HomeController(),
          builder: (controller) => Obx(
            () => ListView.separated(
              itemCount: controller.expenses.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String? paymentMode =
                    controller.expenses[index].transaction?.paymentType;

                String? paymentCategory =
                    controller.expenses[index].transaction?.paymentCategory;

                IconData? paymentIconData = getPaymentModeIcon(
                    getPaymentModeEnumValue(paymentMode ?? ''));
                IconData? categoryIconData = getCategoryIcon(
                    getExpenseCategoryEnumValue(paymentCategory ?? ''));

                return GestureDetector(
                  onTap: () => context.showWorkInProgress(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Icon(
                          categoryIconData,
                          color: Get.theme.colorScheme.primary,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.expenses[index].transaction?.title ??
                                  'N/A',
                              style: Get.theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            Text(Jiffy.parseFromDateTime(controller
                                    .expenses[index].createdAt!
                                    .toDate())
                                .yMMMdjm)
                          ],
                        ),
                        Text(
                          '${controller.expenses[index].transaction?.amount}',
                          style: Get.theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        Icon(
                          paymentIconData,
                          color: Get.theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(10),
            ),
          ),
        ),
      ],
    );
  }
}

class DashboardQuickActionsContainer extends StatelessWidget {
  const DashboardQuickActionsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Get.theme.colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonWithText(
            label: 'Scan QR',
            iconData: Ionicons.qr_code_outline,
            onTap: () => Get.toNamed(Routes.LEND),
          ),
          IconButtonWithText(
            label: 'Contacts',
            iconData: Ionicons.people_circle_outline,
            onTap: () => context.showWorkInProgress(),
          ),
          IconButtonWithText(
            label: 'Phone',
            onTap: () => context.showWorkInProgress(),
            iconData: Ionicons.call_outline,
          ),
          IconButtonWithText(
            label: 'UPI ID',
            onTap: () => context.showWorkInProgress(),
            iconData: Ionicons.at_outline,
          ),
        ],
      ),
    );
  }
}

class PageLabel extends StatelessWidget {
  final String label;

  const PageLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => Column(
        children: [
          Text(
            label,
            style: Get.theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonWithText extends StatelessWidget {
  final IconData? iconData;
  final String label;

  final void Function() onTap;

  const IconButtonWithText({
    super.key,
    this.iconData,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            iconData,
            color: Get.theme.colorScheme.primary,
          ),
          const Gap(5),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class DashboardAnalyticsContainer extends StatelessWidget {
  final Widget info;
  final String label;

  const DashboardAnalyticsContainer({
    super.key,
    required this.info,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          info,
          const Spacer(),
          Text(
            label,
            style: Get.theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class DashboardAnalyticsData {
  DashboardAnalyticsData(this.label, this.isLoading, [this.value]);

  final String label;
  final bool isLoading;
  final String? value; // Now value can be nullable
}

class DashboardAnalytics extends StatelessWidget {
  const DashboardAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      // Make sure your HomeController is properly initialized
      builder: (controller) => Obx(
        () {
          // Determine if data is still loading based on the controller state
          final isLoading = controller.expenses.isNotEmpty &&
              (controller.currentMonthTotal.value == 0.0 ||
                  controller.currentYearTotal.value == 0.0 ||
                  controller.allTimeTotal.value == 0.0 ||
                  controller.currMaxCategory.value == "N/A");

          final List<DashboardAnalyticsData> analyticsData = [
            DashboardAnalyticsData(
                'Total expenditure for ${Jiffy.now().MMMM}',
                isLoading,
                isLoading
                    ? null
                    : controller.currentMonthTotal.value.toString()),
            DashboardAnalyticsData(
                'Total expenditure for ${Jiffy.now().year}',
                isLoading,
                isLoading
                    ? null
                    : controller.currentYearTotal.value.toString()),
            DashboardAnalyticsData('Total expenditure of all time', isLoading,
                isLoading ? null : controller.allTimeTotal.value.toString()),
            DashboardAnalyticsData('Maximum expenditure ${Jiffy.now().MMMM}',
                isLoading, isLoading ? null : controller.currMaxCategory.value),
          ];

          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: analyticsData.map((data) {
              return DashboardAnalyticsContainer(
                // Adjust this widget to handle loading state and display data or loader
                info: data.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        data.value!,
                        style: Get.theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                label: data.label,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
