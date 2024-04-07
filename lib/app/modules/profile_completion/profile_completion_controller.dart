import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/extensions.dart';
import '../../routes/app_pages.dart';

class ProfileCompletionController extends GetxController {
  File? file;

  var user = Rx<User?>(FirebaseAuth.instance.currentUser);

  Future<void> pickImage(BuildContext context,
      {ImageSource imageSource = ImageSource.gallery}) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      _editImage(File(pickedFile.path), context);
    } else {
      context.showSnackbar(
          'Oh shoot!', 'No image was selected, please try again.');
    }
  }

  Future<void> _editImage(File image, BuildContext context) async {
    final editedImage = await Get.to(() => ImageEditor(
          image: image,
        ));
    if (editedImage is Uint8List) {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String filePath =
          '$dir/edited_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File editedFile = File(filePath);
      await editedFile.writeAsBytes(editedImage);
      file = editedFile;
      update();

      _uploadToFirebase(context);
    }
  }

  Future<void> _uploadToFirebase(BuildContext context) async {
    if (file == null) {
      context.showSnackbar(
          'Error', 'There was a problem getting the image file.');
      return;
    }

    final storageRef = FirebaseStorage.instance.ref();
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imagesRef = storageRef.child(fileName);

    try {
      await imagesRef.putFile(file!).then((p0) async {
        String photoURL = await imagesRef.getDownloadURL();
        user.value?.updatePhotoURL(photoURL).then((_) {
          context.showSnackbar(
              'Success', 'Profile picture updated successfully.');
          update();
        });
      });
    } catch (e) {
      context.showSnackbar(
          'Error', 'Failed to upload image. Please try again.');
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  uploadToFirestore(BuildContext context, Map<String, Object?> value) async {
    try {
      await _firestore
          .collection('user-data')
          .doc(user.value?.uid)
          .set(value, SetOptions(merge: true));
      Get.snackbar('Success', 'Data uploaded successfully');
      Get.offAndToNamed(Routes.BASE_PAGE);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload data: $e');
    }
  }
}
