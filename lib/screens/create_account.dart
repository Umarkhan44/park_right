import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home_screen.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController addVenmo = TextEditingController();
  final TextEditingController email = TextEditingController();

  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Create Profile",
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        if (selectedImagePath.isEmpty)
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.red,
                            child: CircleAvatar(
                              radius: 54,
                              backgroundImage:
                              AssetImage('assets/profile 1.png'),
                              backgroundColor: Colors.red,
                            ),
                          )
                        else
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.red,
                            child: CircleAvatar(
                              radius: 54,
                              backgroundColor: Colors.red,
                              backgroundImage: Image.file(
                                File(selectedImagePath),
                              ).image,
                            ),
                          ),
                        Positioned(
                          bottom: 25,
                          right: 25,
                          child: InkWell(
                            onTap: () {
                              selectImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 33,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Material(
                          elevation: 10,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Material(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 10,
                    child: TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        labelStyle:
                        TextStyle(fontSize: 16, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Material(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 10,
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email (Optional)',
                        labelStyle:
                        TextStyle(fontSize: 16, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Material(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 10,
                    child: TextFormField(
                      controller: addVenmo,
                      decoration: InputDecoration(
                        labelText: 'Add Venmo / Zelle Info',
                        labelStyle:
                        TextStyle(fontSize: 16, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    height: 43,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        checkValues();
                      },
                      child: Text('Done'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        //onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
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
                          selectedImagePath =
                          await selectImageFromGallery();
                          print('Image_Path:-');
                          print(selectedImagePath);
                          if (selectedImagePath.isNotEmpty) {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("No Image Selected!"),
                              ),
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
                          selectedImagePath = await selectImageFromCamera();
                          print('Image_Path:-');
                          print(selectedImagePath);

                          if (selectedImagePath.isNotEmpty) {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("No Image Captured!"),
                              ),
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      );

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final String _uid = _auth.currentUser!.uid;

      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('$_uid.jpg');

      final UploadTask uploadTask = ref.putFile(File(selectedImagePath));

      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      final userRef = FirebaseFirestore.instance.collection('users').doc(_uid);
      await userRef.update({
        'lastName': lastName.text.toString().trim(),

        'firstName': firstName.text.toString().trim(),
        'addVenmo': addVenmo.text.toString().trim(),
        'about': email.text.toString().trim(),
        'userImg': downloadUrl,
      },);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data uploaded successfully")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }


  void checkValues() {
    if (selectedImagePath.isEmpty) {
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
}
