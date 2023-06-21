import 'package:get/get.dart';

class TagDatilController extends GetxController {
  var formattedTime = '';
  var frontImages = <String>[];
  var backImages = <String>[];
  var selectedValue = '';
  var approved = false.obs;
  var denied = false.obs;

  void setStatus(bool isApproved, bool isDenied) {
    approved.value = isApproved;
    denied.value = isDenied;
  }
}
