import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';

class EditProfile extends StatefulWidget {
  final firstName;
  final userImg;
  final phoneNumber;
  final addVenmo;
  final lastName;

  EditProfile({
    Key? key,
    this.firstName,
    this.userImg,
    this.phoneNumber,
    this.addVenmo,
    this.lastName,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController addVenmo;
  late TextEditingController _firstNameTextController;
  late TextEditingController _LastNameTextController;
  late TextEditingController phoneNumber;
  late TextEditingController email;
  final fnameFocusNode = FocusNode();
  final lnameFocusNode = FocusNode();
  final contactFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final vemoFocusNode = FocusNode();

  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();

    _firstNameTextController = TextEditingController(text: widget.firstName);
    _LastNameTextController = TextEditingController(text: widget.lastName);
    addVenmo = TextEditingController(text: widget.addVenmo);
    phoneNumber = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    addVenmo.dispose();
    _firstNameTextController.dispose();
    _LastNameTextController.dispose();
    phoneNumber.dispose();
    fnameFocusNode.dispose();
    super.dispose();
  }

  Future selectImage() {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 170,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Select Image From!',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        selectedImagePath = await selectImageFromGallery();
                        print('Image_Path:-');

                        if (selectedImagePath != '') {
                          Get.back();
                          setState(() {});
                        } else {
                          Get.snackbar(
                            'No Image Selected!',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(Icons.photo_camera_back_sharp),
                              Text('Gallery'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        selectedImagePath = await selectImageFromCamera();
                        print('Image_Path:-');
                        print(selectedImagePath);

                        if (selectedImagePath != '') {
                          Get.back();
                          setState(() {});
                        } else {
                          Get.snackbar(
                            'No Image Captured!',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(Icons.photo_camera),
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
      ),
    );
  }

  Future<String> selectImageFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return '';
    }
  }

  Future<String> selectImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return '';
    }
  }

  Future<void> saveProfile() async {
    try {
      if (selectedImagePath != '') {
        // Upload image to Firebase Storage
        File imageFile = File(selectedImagePath);
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(imageName);
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String imageURL = await taskSnapshot.ref.getDownloadURL();

        // Update user profile data in Firestore
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'firstName': _firstNameTextController.text.trim(),
            'lastName': _LastNameTextController.text.trim(),
            'phoneNumber': phoneNumber.text.trim(),
            'addVenmo': addVenmo.text.trim(),
            'userImg': imageURL,
          });

          Get.snackbar(
            'Profile Saved Successfully!',
            '',
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.offAll(Home());
        } else {
          Get.snackbar(
            'Error',
            'Failed to update profile',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'No Image Selected!',
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(

        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: selectedImagePath != ''
                      ? FileImage(File(selectedImagePath))
                      : widget.userImg != ''
                          ? NetworkImage(widget.userImg)
                          : AssetImage('assets/images/placeholder.png')
                              as ImageProvider,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _firstNameTextController,
                focusNode: fnameFocusNode,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => lnameFocusNode.requestFocus(),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _LastNameTextController,
                focusNode: lnameFocusNode,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => contactFocusNode.requestFocus(),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: phoneNumber,
                focusNode: contactFocusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onEditingComplete: () => vemoFocusNode.requestFocus(),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: addVenmo,
                focusNode: vemoFocusNode,
                decoration: InputDecoration(
                  labelText: 'Add Venmo',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onEditingComplete: () => saveProfile(),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  saveProfile();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
