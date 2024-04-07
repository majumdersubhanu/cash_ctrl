import 'package:cash_ctrl/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jiffy/jiffy.dart';

import '../../core/enums.dart';
import '../../core/extensions.dart';
import '../base_page/base_page_controller.dart';
import '../lending/lending_controller.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          primary: true,
          dragStartBehavior: DragStartBehavior.down,
          child: RefreshIndicator(
            onRefresh: () => _handleRefresh(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              textDirection: TextDirection.ltr,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  'Dashboard',
                  style: context.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Gap(40),
                Text(
                  'Hey 👋, ${controller.user?.displayName?.split(' ').first}',
                  style: context.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Obx(
                  () => GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      HomePageAnalyticsBox(
                          'Total expenditure for ${Jiffy.now().MMMM}',
                          controller.currentMonthTotal.value.toString()),
                      HomePageAnalyticsBox(
                          'Total expenditure for ${Jiffy.now().year}',
                          controller.currentYearTotal.value.toString()),
                      HomePageAnalyticsBox('Total expenditure of all time',
                          controller.allTimeTotal.value.toString()),
                      HomePageAnalyticsBox(
                          'Maximum expenditure ${Jiffy.now().MMMM}',
                          controller.currMaxCategory.value),
                    ]
                        .map(
                          (e) => AnalyticsBox(info: e.value, label: e.label),
                        )
                        .toList(),
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.theme.colorScheme.surface,
                  ),
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    children: [
                      IconButtonWithText(
                        label: 'Scan QR',
                        iconData: Ionicons.qr_code_outline,
                        onTap: () => Get.toNamed(Routes.LEND),
                      ),
                      IconButtonWithText(
                        label: 'Contacts',
                        iconData: Ionicons.people_circle_outline,
                        onTap: () => context.showWIP(),
                      ),
                      IconButtonWithText(
                        label: 'Phone',
                        onTap: () => context.showWIP(),
                        iconData: Ionicons.call_outline,
                      ),
                      IconButtonWithText(
                        label: 'UPI ID',
                        onTap: () => context.showWIP(),
                        iconData: Ionicons.id_card_outline,
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Expenses',
                      style: context.titleLarge?.copyWith(
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
                      itemCount: controller.expenses.length <= 5
                          ? controller.expenses.length
                          : 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String paymentMode = controller
                                .expenses[index].transaction?.paymentType ??
                            'Cash';

                        String paymentCategory = controller
                                .expenses[index].transaction?.paymentCategory ??
                            'Miscellaneous';

                        IconData? paymentIconData = getPaymentModeIcon(
                            getPaymentModeValue(paymentMode));
                        IconData? categoryIconData = getExpenseCategoryIcon(
                            getExpenseCategoryValue(paymentCategory));

                        return GestureDetector(
                          onTap: () => context.showWIP(),
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
                                      controller.expenses[index].transaction
                                              ?.title ??
                                          'N/A',
                                      style: context.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(Jiffy.parseFromDateTime(controller
                                            .expenses[index].createdAt!
                                            .toDate())
                                        .yMMMdjm)
                                  ],
                                ),
                                Text(
                                  '${controller.expenses[index].transaction?.amount}',
                                  style: context.titleMedium
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
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    controller.analyticsInfo();
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
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(iconData),
          padding: const EdgeInsets.all(16.0),
          color: Get.theme.colorScheme.primary,
        ),
        const Gap(5),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class AnalyticsBox extends StatelessWidget {
  final String info, label;

  const AnalyticsBox({super.key, required this.info, required this.label});

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
          Text(
            info,
            style: context.titleLarge!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 30,
              // color: Get.theme.colorScheme.primary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            label,
            style: context.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class HomePageAnalyticsBox {
  HomePageAnalyticsBox(this.label, this.value);

  final String label;
  final String value;
}
