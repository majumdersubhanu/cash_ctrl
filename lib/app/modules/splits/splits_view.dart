import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../groups/groups_view.dart';
import '../split_payments/split_payments_view.dart';
import 'splits_controller.dart';

class SplitsView extends GetView<SplitsController> {
  const SplitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              automaticIndicatorColorAdjustment: true,
              onTap: controller.changeTabIndex, // Update the tab index on tap
              tabs: const [
                Tab(
                  icon: Icon(Ionicons.people_circle_outline),
                  text: 'Groups',
                ),
                Tab(
                  icon: Icon(Ionicons.medical_outline),
                  text: 'Split Payments',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            GroupsView(),
            SplitPaymentsView(),
          ],
        ),
      ),
    );
  }
}
