import 'package:cash_ctrl/app/core/extensions.dart';
import 'package:cash_ctrl/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'groups_controller.dart';

class GroupsView extends GetView<GroupsController> {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GroupsController(),
      builder: (controller) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          shape: const StadiumBorder(),
          backgroundColor: Get.theme.colorScheme.surface,
          foregroundColor: Get.theme.colorScheme.onSurface,
          onPressed: () => Get.toNamed(Routes.NEW_GROUP),
          label: const Row(
            children: [
              Icon(Ionicons.add_circle),
              Gap(10),
              Text('Add Group'),
            ],
          ),
        ),
        body: Obx(
          () => ListView.separated(
            itemCount: controller.contacts?.length ?? 0,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return InkWell(
                splashFactory: InkRipple.splashFactory,
                splashColor: Get.theme.colorScheme.secondary,
                overlayColor:
                    MaterialStatePropertyAll(Get.theme.colorScheme.secondary),
                onTap: () => context.showWorkInProgress(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Get.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(controller.contacts?[index].fullName ?? '')
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
    );
  }
}
