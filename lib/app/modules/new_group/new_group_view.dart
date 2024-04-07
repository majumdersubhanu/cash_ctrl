import 'package:cash_ctrl/app/core/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'new_group_controller.dart';

class NewGroupView extends GetView<NewGroupController> {
  NewGroupView({super.key});

  final FormGroup _formGroup = FormGroup({
    'group_name': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.pickContact(),
        child: const Icon(Ionicons.add),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        TextButton.icon(
          onPressed: () => Get.back(),
          label: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          icon: const Icon(
            Ionicons.close_circle_outline,
            color: Colors.red,
          ),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () {
            _formGroup.valid
                ? controller.createGroup(context)
                : _formGroup.markAllAsTouched();
          },
          label: Text(
            'Create group',
            style: TextStyle(
              color: Colors.green.shade700,
            ),
          ),
          icon: Icon(
            Ionicons.create_outline,
            color: Colors.green.shade700,
          ),
        ),
      ],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        primary: true,
        dragStartBehavior: DragStartBehavior.down,
        child: ReactiveForm(
          formGroup: _formGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                'New Group',
                style: Get.theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(20),
              Text(
                'Add the group members one by one',
                style: Get.theme.textTheme.titleMedium?.copyWith(),
              ),
              const Gap(40),
              ReactiveTextField<String>(
                formControlName: 'group_name',
                decoration: const InputDecoration(
                  labelText: 'Group Name',
                  hintText: 'Enter the group name',
                ),
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'Group name is required',
                },
              ),
              const Gap(40),
              Obx(
                () => ListView.separated(
                  itemCount: controller.contacts?.value.length ?? 0,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashFactory: InkRipple.splashFactory,
                      splashColor: Get.theme.colorScheme.secondary,
                      overlayColor: MaterialStatePropertyAll(
                          Get.theme.colorScheme.secondary),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller.contacts?[index].fullName ?? ''),
                                const Gap(10),
                                Text(controller
                                        .contacts?[index].phoneNumbers?.first ??
                                    ''),
                              ],
                            ),
                            IconButton(
                                onPressed: () =>
                                    controller.contacts?.removeAt(index),
                                icon: const Icon(Ionicons.close_outline))
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Gap(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
