import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screens/about.dart';
import '../screens/home_screen.dart';
import '../screens/privacy_policy.dart';
import '../screens/term_conditions.dart';


class SettingController extends GetxController {
  void goToHomeScreen() {
    Get.offAll(() => Home());
  }

  void goToTermConditions() {
    Get.to(() => TermConditionsScreen());
  }

  void goToPrivacyPolicy() {
    Get.to(() => PrivacyPolicy());
  }

  void goToAbout() {
    Get.to(() => About());
  }
}