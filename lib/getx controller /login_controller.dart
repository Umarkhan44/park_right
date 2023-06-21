import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final dialCodeDigits = "".obs;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression pattern to match a valid phone number
    // Adjust the pattern according to your desired phone number format
    final RegExp phoneRegex = RegExp(r'^\+?\d{1,3}[\s.-]?\(?\d{1,3}\)?[\s.-]?\d{1,4}[\s.-]?\d{1,4}$');

    return phoneRegex.hasMatch(phoneNumber);
  }
}
