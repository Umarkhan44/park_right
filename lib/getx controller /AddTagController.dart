// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
//
// class AddTagController extends GetxController {
//   bool isPhotoSelected = true;
//   bool isBackPhotoSelected = true;
//   List<File> selectedImages = [];
//   List<File> selectedImages2 = [];
//
//   Future<List<File>> selectImagesFromGallery() async {
//     List<File> selectedImages = [];
//     try {
//       List<XFile>? files = await ImagePicker().pickMultiImage(
//         imageQuality: 90,
//       );
//       if (files != null) {
//         selectedImages = files.map((file) => File(file.path)).toList();
//       }
//     } catch (e) {
//       // Handle error
//     }
//     return selectedImages;
//   }
//
//   Future<List<File>> captureImagesFromCamera() async {
//     List<File> selectedImages = [];
//
//     try {
//       XFile? file = await ImagePicker().pickImage(
//         source: ImageSource.camera,
//         imageQuality: 90,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         // Specify additional options if needed
//       );
//
//       if (file != null) {
//         selectedImages.add(File(file.path));
//       }
//     } catch (e) {
//       // Handle error
//     }
//
//     return selectedImages;
//   }
//
//   void showImageSourceDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Choose Image Source"),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: [
//               GestureDetector(
//                 child: Text("Camera"),
//                 onTap: () async {
//                   List<File> capturedImages = await captureImagesFromCamera();
//                   selectedImages.addAll(capturedImages);
//                   Get.back();
//                 },
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 child: Text("Gallery"),
//                 onTap: () async {
//                   List<File> galleryImages = await selectImagesFromGallery();
//                   selectedImages.addAll(galleryImages);
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void dialogForBack() {
//     Get.dialog(
//       AlertDialog(
//         title: Text("Choose Image Source"),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: [
//               GestureDetector(
//                 child: Text("Camera"),
//                 onTap: () async {
//                   List<File> capturedImages = await captureImagesFromCamera();
//                   selectedImages2.addAll(capturedImages);
//                   Get.back();
//                 },
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 child: Text("Gallery"),
//                 onTap: () async {
//                   List<File> galleryImages = await selectImagesFromGallery();
//                   selectedImages2.addAll(galleryImages);
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
