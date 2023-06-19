// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// import 'package:nwewew/screens/add_new_tag.dart';
//
// class AroundMe1 extends StatefulWidget {
//   final String userId;
//
//    AroundMe1({Key? key, required this.userId}) : super(key: key);
//   @override
//   _AroundMe1State createState() => _AroundMe1State();
// }
//
// class _AroundMe1State extends State<AroundMe1> {
//   Completer<GoogleMapController> _controller = Completer();
//   CameraPosition? _kGooglePlex; // Make it nullable
//
//   final Location location = Location();
//   LocationData? _currentPosition;
//   Marker? _currentLocationMarker;
//   Set<Marker> markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   void _getCurrentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     final currentLocation = await location.getLocation();
//     setState(() async {
//       _currentPosition = currentLocation;
//       _currentLocationMarker = Marker(
//         markerId: MarkerId('currentLocation'),
//         position: LatLng(
//           _currentPosition!.latitude!,
//           _currentPosition!.longitude!,
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindow: InfoWindow(
//           title: 'Current Location',
//           snippet: 'Lat: ${_currentPosition!.latitude}, Lng: ${_currentPosition!.longitude}',
//         ),
//       );
//
//       markers.add(_currentLocationMarker!);
//
//       _kGooglePlex = CameraPosition(
//         target: LatLng(
//           _currentPosition!.latitude!,
//           _currentPosition!.longitude!,
//         ),
//         zoom: 14.4746,
//       );
//
//       if (_kGooglePlex != null && _controller.isCompleted) {
//         final GoogleMapController controller = await _controller.future;
//         controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));
//       }
//     });
//
//     // Fetch current user's location using the user ID
//     final userId = widget.userId;
//     final locationDocument = {
//       'latitude': _currentPosition!.latitude,
//       'longitude': _currentPosition!.longitude,
//     };
//
//     try {
//       await FirebaseFirestore.instance.collection('locations').doc(userId).set(locationDocument);
//       print('Location saved successfully!');
//     } catch (e) {
//       print('Error saving location: $e');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition: _kGooglePlex ?? CameraPosition(
//                 target: LatLng(0, 0), // Default target if _kGooglePlex is null
//                 zoom: 14.4746,
//               ),
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               markers: markers, // Add the markers to the GoogleMap widget
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             Positioned(
//               top: 10,
//               right: 10,
//               left: 19,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: BackButton(
//                       color: Colors.black,
//                     ),
//                     title: const Text(
//                       "Locations",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     horizontalTitleGap: 87,
//                   ),
//                   const SizedBox(
//                     height: 22,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 30,
//               left: 88,
//               right: 85,
//               child: ElevatedButton(
//                 onPressed: () {
//                    _saveLocation();
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.green),
//                 child: const Text(
//                   "Save",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _saveLocation() async {
//     // Get the current user's ID
//     final userId = widget.userId;
//
//     // Get the current location
//     LocationData locationData;
//     var location = Location();
//
//     try {
//       locationData = await location.getLocation();
//     } catch (e) {
//       // Handle location error
//       print('Error getting location: $e');
//       return;
//     }
//
//     // Extract latitude and longitude from location data
//     final latitude = locationData.latitude;
//     final longitude = locationData.longitude;
//
//     // Create a location document with user ID, latitude, and longitude
//     // final locationDocument = {
//     //   'uid': userId,
//     //   'latitude': latitude,
//     //   'longitude': longitude,
//     //   'timestamp': FieldValue.serverTimestamp(),
//     //   'isImage': false, // Assuming it's not an image message
//     // };
//
//     try {
//       // // Save the location document to Firestore
//       // await FirebaseFirestore.instance
//       //     .collection('messages')
//       //     .doc(chatRoomId)
//       //     .collection('chats')
//       //     .add(locationDocument);
//
//       print('Location saved successfully!');
//     } catch (e) {
//       // Handle Firestore error
//       print('Error saving location: $e');
//     }
//   }
//
//
// }
