import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';

import '../../core/extensions.dart';

class NewGroupController extends GetxController {
  RxList<Contact>? contacts = <Contact>[].obs;
  final FlutterContactPicker contactPicker = FlutterContactPicker();

  pickContact() async {
    Contact? contact = await contactPicker.selectContact();
    contacts?.addIf(contact != null, contact!);
  }

  createGroup(BuildContext context) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('groups').add({
        "created_by": {
          "uid": FirebaseAuth.instance.currentUser?.uid,
          "name": FirebaseAuth.instance.currentUser?.displayName,
          "phone_number": FirebaseAuth.instance.currentUser?.phoneNumber,
        },
        "people": contacts?.value
            .map((e) => {"name": e.fullName, "phone_numbers": e.phoneNumbers})
            .toList(),
      });

      context.showSnackbar('Success!', 'Group created successfully');

      Navigator.of(context).pop();
    } catch (e) {
      context.showSnackbar(
          'Error!', 'Failed to create group. Please try again.');
    }
  }
}
