import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  final emailFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final contactFocusNode = FocusNode();
  final feedbackFocusNode = FocusNode();

  void submitFeedback() {
    // Check if any of the required fields is empty
    if (nameController.text.isEmpty ||
        contactController.text.isEmpty ||
        emailController.text.isEmpty ||
        feedbackController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill in all the required fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return; // Stop further execution if any field is empty
    }

    // Show a progress indicator
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text('Submitting...'),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Generate a UUID
    String uuid = Uuid().v4();

    // Get the current user ID (replace this with your own logic for getting the current user ID)
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get the current timestamp
    Timestamp timestamp = Timestamp.now();

    // Create a map of the feedback data
    Map<String, dynamic> feedbackData = {
      'uuid': uuid,
      'userId': userId,
      'name': nameController.text,
      'contact': contactController.text,
      'email': emailController.text,
      'feedback': feedbackController.text,
      'timestamp': timestamp,
    };

    // Save the feedback data to Firestore
    FirebaseFirestore.instance
        .collection('helps')
        .doc(uuid)
        .set(feedbackData)
        .then((value) {
      // Hide the progress indicator
      Navigator.of(Get.context!).pop();

      nameController.clear();
      contactController.clear();
      emailController.clear();
      feedbackController.clear();
      // Feedback submitted successfully
      Fluttertoast.showToast(
        msg: 'Feedback uploaded successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );

      // TODO: Add your logic here
    }).catchError((error) {
      // Hide the progress indicator
      Navigator.of(Get.context!).pop();

      // Error occurred while submitting feedback
      Fluttertoast.showToast(
        msg: 'Failed to upload feedback',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );

      // TODO: Handle the error
    });
  }



  @override
  void dispose() {
    // Dispose the text editing controllers and focus nodes
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    feedbackController.dispose();
    emailFocusNode.dispose();
    nameFocusNode.dispose();
    contactFocusNode.dispose();
    feedbackFocusNode.dispose();
    super.dispose();
  }
}
