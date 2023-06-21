import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  void updateProfile(String firstName, String lastName, String phoneNumber) async {
    try {
      isLoading(true);
      String userId = _auth.currentUser!.uid;
      await _firestore.collection("users").doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
      });
      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      print(e.toString());
    }
  }
}
