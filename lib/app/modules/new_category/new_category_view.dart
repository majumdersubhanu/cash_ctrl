import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'new_category_controller.dart';

class NewCategoryView extends GetView<NewCategoryController> {
  const NewCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewCategoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewCategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
