import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  final RxString selectedImagePath = ''.obs;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController addVenmo = TextEditingController();
  final TextEditingController email = TextEditingController();

  final FocusNode fNameFocusNode = FocusNode();
  final FocusNode lNameFocusNode = FocusNode();
  final FocusNode addFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  Future<void> selectImage() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Select Image From !',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath.value =
                          await selectImageFromGallery();
                          if (selectedImagePath.value.isNotEmpty) {
                            Get.back();
                          } else {
                            Fluttertoast.showToast(
                              msg: "No Image Selected!",
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/profile 1.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath.value =
                          await selectImageFromCamera();
                          if (selectedImagePath.value.isNotEmpty) {
                            Get.back();
                          } else {
                            Fluttertoast.showToast(
                              msg: "No Image Captured!",
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/profile 1.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Future<String> selectImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  void updateData() async {
    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
        barrierDismissible: false,
      );

      final String uid = _auth.currentUser!.uid;

      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('$uid.jpg');

      final UploadTask uploadTask =
      ref.putFile(File(selectedImagePath.value));

      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      await _usersCollection.doc(uid).update({
        'lastName': lastName.text.trim(),
        'firstName': firstName.text.trim(),
        'addVenmo': addVenmo.text.trim(),
        'about': email.text.trim(),
        'userImg': downloadUrl,
      });

      Get.offAllNamed('/home');

      Fluttertoast.showToast(
        msg: "Data uploaded successfully",
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    } finally {
      Get.back();
    }
  }

  void checkValues() {
    if (selectedImagePath.value.isEmpty) {
      Fluttertoast.showToast(msg: "Please select an image");
    } else if (addVenmo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please add Venmo/Zelle info");
    } else if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter the first name");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter the last name");
    } else {
      updateData();
    }
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    addVenmo.dispose();
    email.dispose();
    fNameFocusNode.dispose();
    lNameFocusNode.dispose();
    addFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
}
