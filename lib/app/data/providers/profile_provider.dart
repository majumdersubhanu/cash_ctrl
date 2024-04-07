import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/profile_model.dart';

class ProfileProvider extends GetConnect {
  Profile profile = Profile();
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    getProfile(uid);
  }

  Future<Profile?> getProfile(String uid) async {
    var db = FirebaseFirestore.instance;
    final snapshot = await db.collection("user-data").doc(uid).get();

    if (snapshot.data() != null) {
      Profile profile = Profile.fromJson(
          snapshot.data()!); // Ensure this method correctly parses the UPI ID
      Logger().i("Firebase Data: ${snapshot.data().toString()}");
      Logger().i("Profile Data: ${profile.toJson()}");
      this.profile =
          profile; // Make sure this is the profile object you're using throughout your app

      return profile;
    } else {
      Logger().i("No data found for user: $uid");
      return null;
    }
  }

  Future<Response<Profile>> postProfile(Profile profile) async =>
      await post('profile', profile);

  Future<Response> deleteProfile(int id) async => await delete('profile/$id');
}
