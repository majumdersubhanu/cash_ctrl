import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/models/profile_model.dart';
import '../../data/providers/profile_provider.dart';

class BorrowController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Profile? profile;

  ProfileProvider provider = ProfileProvider();

  @override
  void onInit() {
    super.onInit();

    profileSetup();
  }

  profileSetup() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    profile = await provider.getProfile(uid);
  }

  Future<void> fetchAndSetupProfile() async {
    // Simulate fetching profile data and updating the UI accordingly
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    await provider.getProfile(
        uid); // This method should be your asynchronous call to fetch the profile data
    // Once the profile is fetched, you can update the state (if using StatefulWidgets) or update the reactive variables (if using GetX or similar)
  }
}
