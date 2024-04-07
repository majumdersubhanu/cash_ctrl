import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'split_payments_controller.dart';

class SplitPaymentsView extends GetView<SplitPaymentsController> {
  const SplitPaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: const StadiumBorder(),
        backgroundColor: Get.theme.colorScheme.surface,
        foregroundColor: Get.theme.colorScheme.onSurface,
        onPressed: () => true,
        label: const Row(
          children: [
            Icon(Ionicons.add_circle),
            Gap(10),
            Text('New Split'),
          ],
        ),
      ),
    );
  }
}
