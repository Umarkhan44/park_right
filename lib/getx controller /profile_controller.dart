import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  void logout() async {
    await FirebaseAuth.instance.signOut();

    // Navigate to the login screen
    Get.offAllNamed('/login');
  }
}
