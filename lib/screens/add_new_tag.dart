

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';
import 'locations.dart';




class AddTag extends StatefulWidget {
  AddTag({Key? key}) : super(key: key);

  @override
  State<AddTag> createState() => _AddTagState();


}

class _AddTagState extends State<AddTag> {
  // Future<LocationData?> getCurrentLocation() async {
  //   Location location = Location();
  //
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       // Handle case when user doesn't enable location services
  //       return null;
  //     }
  //   }
  //
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       // Handle case when user doesn't grant location permission
  //       return null;
  //     }
  //   }
  //
  //   return await location.getLocation();
  // }


  bool isButtonPressed = false;
  double buttonOffset = 0;

  List<String> selectedImagePathsStep1 = [];
  List<String> selectedImagePaths = [];
  List<File> selectedImages = [];
  List<File> selectedImages2 = [];
  bool isPhotoSelected = true;
  bool isBackPhotoSelected = true;
  String? selectedValue2;
  final List<String> items = [
    "Parking in a RED ZONE (Fire/Emergency)",
    'Parking in a Handicap Space (without a visible placard)',
    'Parking on a Sidewalk',
    'Parking in a Crosswalk',
    'Double parked',
    'Expired Registration (this is an easy one)',
    'Parking in Bike Lane',
    'Blocking Driveway',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),

        title: Text(
          "Add a new TAG!",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19,vertical: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Step 1:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Color(0xff000000),
                    ),),
                  RichText(
                    text: TextSpan(
                      text: 'Add ',
                      style: TextStyle(
                        fontSize: 17,
                        color:  isPhotoSelected ? Colors.black : Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text: 'FRONT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor:  isPhotoSelected ? Colors.black : Colors.red,
                            decorationThickness: 2,
                          ),
                        ),
                        TextSpan(text: ' or ',style: TextStyle(
                          color:  isPhotoSelected ? Colors.black : Colors.red,
                        )),
                        TextSpan(
                          text: 'BACK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor:  isPhotoSelected ? Colors.black : Colors.red,
                            decorationThickness: 2,
                          ),
                        ),
                        TextSpan(
                          text: ' view of vehicle\nshowing the license plate',style: TextStyle(color:  isPhotoSelected ? Colors.black : Colors.red,)
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2,),
                  SizedBox(
                    height: 80,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Add button
                          return GestureDetector(
                            onTap: () {
                              showImageSourceDialog(context);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 23,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        // Selected images
                        File imageFile = selectedImages[index - 1];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImages.removeAt(index - 1);
                                  });
                                },
                                child: SvgPicture.asset(
                                  'assets/cancel2.svg',height: 12,width: 15,
                                  // Additional options and parameters can be specified here
                                ),
                              ),
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )



                            ],
                          ),
                        );


                      },
                    ),


                  ),
                  Text("TAP TO SELCET IMAGE (Minimum 1 image at each step) ",style: TextStyle(fontSize: 10,color: isPhotoSelected? Colors.grey:Colors.red),)
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  RichText(
                    text: TextSpan(
                      text: 'Add ',
                      style: TextStyle(
                        fontSize: 17,
                        color: isBackPhotoSelected ? Colors.black : Colors.red,
                      ),
                      children: [
                        TextSpan(
                          text: '45°',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 2,
                          ),
                        ),
                        TextSpan(text: ' or '),
                        TextSpan(
                          text: 'SIDE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: isBackPhotoSelected ? Colors.black : Colors.red,
                            decorationThickness: 2,
                          ),
                        ),
                        TextSpan(
                          text: ' view showing the parking infraction',style: TextStyle(
                          color: isBackPhotoSelected ? Colors.black : Colors.red,
                        )
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2,),
                  SizedBox(
                    height: 80,
                    child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages2.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Add button
                          return GestureDetector(
                            onTap: () {
                              dialogForBack(context);
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:  isBackPhotoSelected ? Colors.black : Colors.red,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 23,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isBackPhotoSelected ? Colors.black : Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        // Selected images
                        File imageFile = selectedImages2[index - 1];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedImages2.removeAt(index - 1);

                                  });
                                },
                                child: SvgPicture.asset(
                                  'assets/cancel2.svg',height: 12,width: 15,
                                  // Additional options and parameters can be specified here
                                ),
                              ),
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )



                            ],
                          ),
                        );


                      },
                    ),


                  ),
                  Text("TAP TO SELCET IMAGE (Minimum 1 image at each step) ",style: TextStyle(fontSize: 10,color: isBackPhotoSelected ? Colors.grey : Colors.red,),),

                ],
              ),
            ),

            Divider(
              thickness: 4,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Step 3:",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),),
                  SizedBox(height: 13),
                  Text("Possible Parking FAILS",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),),
                  SizedBox(height: 13),
                  Text(
                    'Parking Fails', // Label text
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 26,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text(
                            'Please select a value',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ...items.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                      value: selectedValue2,
                      onChanged: (value) {
                        setState(() {
                          selectedValue2 = value as String?;
                        });
                      },

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 23),
            GestureDetector(
              onTap: ()  {

                 // _openMapAndSelectLocation(context);

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("current location"),
                  SizedBox(width: 80,),
                  Icon(Icons.my_location),
                ],
              ),
            ),
            SizedBox(height: 43,),
            Center(
              child:ElevatedButton(
                child: Text('TAG IT!'),
                style: ElevatedButton.styleFrom(
                  primary: (selectedImages.isEmpty && selectedImages2.isEmpty) ? Colors.red :
                  (selectedImages.isNotEmpty && selectedImages2.isEmpty) ? Colors.red :
                  (selectedImages.isEmpty && selectedImages2.isNotEmpty) ? Colors.red : Colors.black,
                  //onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  minimumSize: Size(233, 43),
                ),
                onPressed: () {
                  if (selectedImages.isEmpty && selectedImages2.isEmpty) {
                    setState(() {
                      isPhotoSelected = false;
                      isBackPhotoSelected = false;
                    });
                  } else if (selectedImages.isNotEmpty && selectedImages2.isEmpty) {
                    setState(() {
                      isPhotoSelected = true;
                      isBackPhotoSelected = false;
                    });
                  } else if (selectedImages.isEmpty && selectedImages2.isNotEmpty) {
                    setState(() {
                      isPhotoSelected = false;
                      isBackPhotoSelected = true;
                    });
                  } else {
                    setDataInFirebase(context);

                    setState(() {
                      isPhotoSelected = true;
                      isBackPhotoSelected = true;
                    });
                  }
                },
              ),








            ) ],
        ),
      ),
    );
  }
  Future<List<File>> selectImagesFromGallery() async {
    List<File> selectedImages = [];
    try {
      List<XFile>? files = await ImagePicker().pickMultiImage(
        imageQuality: 90,
      );
      if (files != null) {
        selectedImages = files.map((file) => File(file.path)).toList();
      }
    } catch (e) {
      // Handle error
    }
    return selectedImages;
  }

  Future<List<File>> captureImagesFromCamera() async {
    List<File> selectedImages = [];

    try {
      XFile? file = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 1920,
        maxHeight: 1080,
        // Specify additional options if needed
      );

      if (file != null) {
        selectedImages.add(File(file.path));
      }
    } catch (e) {
      // Handle error
    }

    return selectedImages;
  }




  void showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () async {
                    List<File> capturedImages = await captureImagesFromCamera();
                    setState(() {
                      selectedImages.addAll(capturedImages);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () async {
                    List<File> galleryImages = await selectImagesFromGallery();
                    setState(() {
                      selectedImages.addAll(galleryImages);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void dialogForBack(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () async {
                    List<File> capturedImages = await captureImagesFromCamera();
                    setState(() {
                      selectedImages2.addAll(capturedImages);
                    });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () async {
                    List<File> galleryImages = await selectImagesFromGallery();
                    setState(() {
                      selectedImages2.addAll(galleryImages);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }




  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        ConfettiController _controller = ConfettiController();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.play();
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                   height: 40,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/img_2.png',
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: ConfettiWidget(
                          blastDirectionality: BlastDirectionality.explosive,
                          confettiController: _controller,
                          emissionFrequency: 0.25,
                          numberOfParticles: 5,
                          gravity: 0.05,
                          shouldLoop: false,
                          colors: [
                            Colors.green,
                            Colors.red,
                            Colors.yellow,
                            Colors.blue,
                            Colors.black,
                            Colors.orange,
                          ],
                          particleDrag: 0.05,
                          maxBlastForce: 10,
                          minBlastForce: 5,
                          blastDirection: -19.5708, // 90 degrees in radians (upward)
                          minimumSize: Size(1.100, 1.100),
                          maximumSize: Size(5.200, 5.200),
                        ),
                      ),
                    ],
                  ),





                  SizedBox(height: 16.0),
                  Text(
                    'Thank you for Tagging!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Center(
                    child: Text(
                      'You will be notified when your\n Request has been approved \n or denied.',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        wordSpacing: 1,
                        color: Color(0xff3D3D3D),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isButtonPressed = !isButtonPressed;
                      });

                      // Perform additional actions when the button is pressed
                      // TODO: Add your logic here
                      if (isButtonPressed) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        });
                      }
                    },
                    child: LimitedBox(
                      maxWidth: 153,
                      maxHeight: 66,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(33),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              left: isButtonPressed ? -15 : 110,
                              child: Container(
                                width: 153,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.arrow_back_rounded, color: Colors.white),
                                    Text(
                                      'Back to Home',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void setDataInFirebase(BuildContext context) async {
    final FirebaseStorage storage = FirebaseStorage.instance;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text('Uploading data...'),
                ],
              ),
            ),
          );
        },
      );

      final CollectionReference collection =
      FirebaseFirestore.instance.collection('tag');
      final DocumentReference document = collection.doc();

      List<String> backPhotoUrls = [];
      List<String> frontPhotoUrls = [];

      // Upload selectedImages to Firebase Storage and retrieve download URLs
      for (File backPhotoFile in selectedImages) {
        String filePath = 'images/${document.id}/${backPhotoFile.path.split('/').last}';

        // Upload the pack photo file to Firebase Storage
        final Reference ref = storage.ref().child(filePath);
        final UploadTask uploadTask = ref.putFile(backPhotoFile);

        // Wait for the upload to complete and retrieve the download URL
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Store the download URL in the packPhotoUrls list
        backPhotoUrls.add(downloadURL);
      }

      // Upload selectedImages2 to Firebase Storage and retrieve download URLs
      for (File frontPhotoFile in selectedImages2) {
        String filePath = 'images/${document.id}/${frontPhotoFile.path.split('/').last}';

        // Upload the front photo file to Firebase Storage
        final Reference ref = storage.ref().child(filePath);
        final UploadTask uploadTask = ref.putFile(frontPhotoFile);

        // Wait for the upload to complete and retrieve the download URL
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Store the download URL in the frontPhotoUrls list
        frontPhotoUrls.add(downloadURL);
      }

      // Save data to Firestore including the image download URLs
      await document.set({
        'selectedValue2': selectedValue2,
        'backPhoto': backPhotoUrls, // Add the list of pack photo download URLs to the document
        'frontPhoto': frontPhotoUrls,
         "tagtime": Timestamp.now(),
         "Approved": false,
         "Denied": false,
         "userId":FirebaseAuth.instance.currentUser!.uid
        // Add the list of front photo download URLs to the document
      });

      Navigator.pop(context); // Close the loading dialog

      // Open the custom bottom sheet after the data is uploaded
      showCustomBottomSheet(context);

      print('Data saved to Firebase Firestore');
    } catch (error) {
      Navigator.pop(context); // Close the loading dialog
      print('Error saving data to Firebase Firestore: $error');
    }
  }


  // void _openMapAndSelectLocation(BuildContext context) async {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //   final LocationData? selectedPosition = await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => AroundMe1(
  //           userId: userId
  //       ),
  //     ),
  //   );
  // }




}
