import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';


class EditProfile extends StatefulWidget {
   var firstName;
   var userImg;
   var phoneNumber;
   var addVenmo;
   var lastName;
   EditProfile({Key? key,
   this. firstName,
   this. userImg,
   this. phoneNumber,
   this. addVenmo,
   this. lastName
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();

}

class _EditProfileState extends State<EditProfile> {

  late  TextEditingController addVenmo ;
  late  TextEditingController _firstNameTextController;
  late   TextEditingController _LastNameTextController ;
  late    TextEditingController phoneNumber ;
  final fnameFocusNode = FocusNode();
  final lnameFocusNode = FocusNode();
  final contactFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final vemoFocusNode = FocusNode();



  String selectedImagePath = '';
  // final TextEditingController _userImgController = TextEditingController();
  void initState() {
    super.initState();

    // Initialize the text editing controllers with the data passed from the previous screen
    _firstNameTextController = TextEditingController(text: widget.firstName);
    _LastNameTextController=TextEditingController(text:  widget.lastName);
    addVenmo=TextEditingController(text: widget.addVenmo);
    phoneNumber=TextEditingController(text:widget.phoneNumber );


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Home()));
          },
          child: Icon(
            Icons.arrow_back_ios,color: Colors.black,
          ),
        ),
        title: Text(
          "Profile",style: TextStyle(
          color: Colors.black
        ),
        ),
      ),
   body: Center(
     child: SingleChildScrollView(
       child: Column(

         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(

             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(
                 color: Colors.green,
                 width: 1,
               ),
             ),
             child: Stack(
               children: [
                 Center(
                   child: CircleAvatar(
                     backgroundColor: Colors.white,
                     radius: 48,
                     backgroundImage: selectedImagePath == ''
                         ? NetworkImage(widget.userImg)
                         : Image.file(File(
                       selectedImagePath,
                     )).image,
                   ),
                 ),
                 Positioned(
                   bottom: 4,
                   left: 80,
                   right: 0,
                   child: Container(
                     width: 24,
                     height: 24,
                     decoration: BoxDecoration(
                       color: Colors.green,
                       shape: BoxShape.circle,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.3),
                           spreadRadius: 1,
                           blurRadius: 3,
                         ),
                       ],
                     ),
                     child: InkWell(
                       onTap: () {
                         selectImage();
                         setState(() {});
                       },
                       child: Icon(
                         Icons.camera_alt_outlined,
                         color: Colors.white,
                         size: 16,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),

           Padding(
             padding:  EdgeInsets.all(20.0),
             child: TextField(
               focusNode: fnameFocusNode,
               controller: _firstNameTextController,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Color(0xffE1E1E1),
                 border: OutlineInputBorder(
                   borderSide: BorderSide.none,
                 ),
                 labelText: 'First Name',
                 labelStyle: TextStyle(
                   fontSize: 15,
                   color: Colors.black,
                 ),
                 hintText: "Umar",
               ),
               textInputAction: TextInputAction.next, // Set the keyboard action to "Next"
               onEditingComplete: () {
                 // Move focus to the next text field when the current field is completed
                 lnameFocusNode.requestFocus();
               },
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: TextField(
               focusNode: lnameFocusNode,

            controller: _LastNameTextController,
               decoration: InputDecoration(filled: true,
                   fillColor: Color(0xffE1E1E1),
                 border: OutlineInputBorder(
                   borderSide: BorderSide.none
                 ),
                 labelText: 'Last Name',labelStyle: TextStyle(
                     fontSize: 15,
                     color: Colors.black
                   ),
                 hintText: "Khan"
               ),
                 textInputAction: TextInputAction.next, // Set the keyboard action to "Next"
                 onEditingComplete: () {
                   // Move focus to the next text field when the current field is completed
                   contactFocusNode.requestFocus();
                 }  ),
           ),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: TextField(
               keyboardType: TextInputType.number,
              focusNode: contactFocusNode,
               controller: phoneNumber,
               decoration: InputDecoration(filled: true,
                   fillColor: Color(0xffE1E1E1),
                 border: OutlineInputBorder(
                   borderSide: BorderSide.none
                 ),
                 labelText: 'Phone',labelStyle: TextStyle(
                     fontSize: 15,
                     color: Colors.black
                   ),
                 hintText: "03955835353853"
               ),
                 textInputAction: TextInputAction.next, // Set the keyboard action to "Next"
                 onEditingComplete: () {
                   // Move focus to the next text field when the current field is completed
                   emailFocusNode.requestFocus();
                 }
             ),
           ),
           Padding(
             padding:  EdgeInsets.all(20.0),
             child: TextField(
               focusNode: emailFocusNode,
               decoration: InputDecoration(filled: true,
                   fillColor: Color(0xffE1E1E1),
                 border: OutlineInputBorder(
                   borderSide: BorderSide.none
                 ),
                 labelText: 'Email',labelStyle: TextStyle(
                     fontSize: 15,
                     color: Colors.black
                   ),
                 hintText: "Example123@gmail.com",hintStyle: TextStyle(
                     color: Colors.red
                   )
               ),
               textInputAction: TextInputAction.next,
               onEditingComplete: (){
                 vemoFocusNode.requestFocus();
               },
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: TextField(
               focusNode: vemoFocusNode,
              maxLines: 8,
              controller: addVenmo,
               decoration: InputDecoration(
                   filled: true,
                   fillColor: Color(0xffE1E1E1),
                 border: OutlineInputBorder(
                   borderSide: BorderSide.none
                 ),
                 labelText: 'Venmo / Zelle Info',labelStyle: TextStyle(
                     fontSize: 15,
                     color: Colors.black
                   ),
                 hintText: "dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
               ),
               textInputAction: TextInputAction.done,
               onEditingComplete: (){
                 UpdateData();
               },
             ),
           ),
           Center(
             child: Container(
               margin: EdgeInsets.symmetric(vertical: 30),
               height: 43,
               width: 300,
               child: ElevatedButton(
                 onPressed: () {
                   UpdateData();
                 },
                 child: Text('Update'),
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
   ), );
  }
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
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
                      'Select Image From !',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
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
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(Icons.camera),
                                  Text('Camera'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
  void UpdateData() async {
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
      final _uid = _auth.currentUser!.uid;
      String? downloadUrl;

      if (selectedImagePath != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child(_uid + '.png');
        await ref.putFile(File(selectedImagePath));
        downloadUrl = await ref.getDownloadURL();
      }

      FirebaseFirestore.instance.collection('users').doc(_uid).update({

        'firstName': _firstNameTextController.text.trim(),
        'lastName': _LastNameTextController.text.trim(),
        'addVenmo': addVenmo.text.trim(),
        'phoneNumber': phoneNumber.text.trim(),
       // 'about': _aboutTextController.text.trim(),
        // 'email': _emailTextController.text.trim(),
        if (downloadUrl != null) 'userImg': downloadUrl,
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Update successfully")));
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
