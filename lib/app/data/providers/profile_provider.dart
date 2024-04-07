import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';

class ProfileProvider {
  Profile profile = Profile();
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

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
}
