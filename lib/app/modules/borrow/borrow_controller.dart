import 'package:cash_ctrl/app/core/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../data/models/profile_model.dart';
import '../../data/providers/profile_provider.dart';

class BorrowController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Profile? profile;

  ProfileProvider provider = ProfileProvider();

  Future<void> fetchAndSetupProfile() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    await provider.getProfile(uid);
  }

  Future<void> uploadToFirebase(
      BuildContext context, Map<String, Object?> value) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      var borrowMap = {"transaction": value, "user": user?.uid};

      await firestore
          .collection('borrowing-data')
          .add(borrowMap as Map<String, dynamic>);
      context.showSnackbar('Success!', 'Borrowed money successfully');
    } catch (e) {
      context.showSnackbar(
          'Error!', 'Failed to borrow money. Please try again.');
    }
  }
}
