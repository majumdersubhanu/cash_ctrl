import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../core/extensions.dart';
import '../../data/models/profile_model.dart';
import '../../data/providers/profile_provider.dart';

class ProfileController extends GetxController {
  var file = Rx<File?>(null);
  var user = Rx<User?>(FirebaseAuth.instance.currentUser);
  var profile = Rxn<Profile>();
  var formGroup = FormGroup({}).obs;

  ProfileProvider provider = ProfileProvider();

  @override
  void onInit() {
    super.onInit();
    readDataFromFirebase();

    setupForm();
  }

  Future<void> pickImage(BuildContext context,
      {ImageSource imageSource = ImageSource.gallery}) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      _editImage(File(pickedFile.path), context);
    } else {
      context.showSnackbar(
          'Oh shoot!', 'No image was selected, please try again.');
    }
    update();
  }

  Future<void> _editImage(File image, BuildContext context) async {
    final editedImage = await Get.to(() => ImageEditor(image: image));
    if (editedImage is Uint8List) {
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String filePath =
          '$dir/edited_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File editedFile = File(filePath);
      await editedFile.writeAsBytes(editedImage);

      file.value = editedFile;

      update();

      _uploadImageToFirebase(context);
    }
  }

  Future<void> _uploadImageToFirebase(BuildContext context) async {
    final storageRef = FirebaseStorage.instance.ref();
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imagesRef = storageRef.child(fileName);

    try {
      await imagesRef.putFile(file.value!).then((p0) async {
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

  Future<void> readDataFromFirebase() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    profile.value = await provider.getProfile(uid) ?? Profile();

    setupForm();
  }

  void setupForm() {
    formGroup(FormGroup({
      'personal_information': FormGroup({
        'full_name': FormControl<String>(
            value: profile.value?.personalInformation?.fullName),
        'date_of_birth': FormControl<String>(
            value: profile.value?.personalInformation?.dateOfBirth),
        'gender': FormControl<String>(
            value: profile.value?.personalInformation?.gender),
        'contact_information': FormGroup({
          'email': FormControl<String>(
              value: profile
                  .value?.personalInformation?.contactInformation?.email),
          'phone_number': FormControl<String>(
              value: profile
                  .value?.personalInformation?.contactInformation?.phoneNumber),
        }),
        'address': FormGroup({
          'current': FormControl<String>(
              value: profile.value?.personalInformation?.address?.current),
        }),
        'nationality': FormControl<String>(
            value: profile.value?.personalInformation?.nationality),
      }),
      'employment_details': FormGroup({
        'job_title': FormControl<String>(
            value: profile.value?.employmentDetails?.jobTitle),
        'company_name': FormControl<String>(
            value: profile.value?.employmentDetails?.companyName),
        'industry': FormControl<String>(
            value: profile.value?.employmentDetails?.industry),
        'employment_status': FormControl<String>(
            value: profile.value?.employmentDetails?.employmentStatus),
        'monthly_income': FormControl<String>(
            value: profile.value?.employmentDetails?.monthlyIncome),
      }),
      'financial_information': FormGroup({
        'bank_account_details': FormGroup({
          'account_number': FormControl<String>(
              value: profile.value?.financialInformation?.bankAccountDetails
                  ?.accountNumber),
          'ifsc_code': FormControl<String>(
              value: profile
                  .value?.financialInformation?.bankAccountDetails?.ifscCode),
          'bank_name': FormControl<String>(
              value: profile
                  .value?.financialInformation?.bankAccountDetails?.bankName),
        }),
        'upi_id': FormControl<String>(
            value: profile.value?.financialInformation?.upiId),
      }),
      'identification_documents': FormGroup({
        'pan_card': FormControl<String>(
            value: profile.value?.identificationDocuments?.panCard),
        'aadhaar_card': FormControl<String>(
            value: profile.value?.identificationDocuments?.aadhaarCard),
        'passport': FormControl<String>(
            value: profile.value?.identificationDocuments?.passport),
        'driver_license': FormControl<String>(
            value: profile.value?.identificationDocuments?.driverLicense),
      }),
    }));
  }
}
