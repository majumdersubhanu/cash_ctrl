import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
      Profile profile = Profile.fromJson(snapshot.data()!);
      this.profile = profile;

      return profile;
    } else {
      return null;
    }
  }

  Future<Response<Profile>> postProfile(Profile profile) async =>
      await post('profile', profile);

  Future<Response> deleteProfile(int id) async => await delete('profile/$id');
}
