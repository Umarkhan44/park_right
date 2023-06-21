
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../getx controller /help_controller.dart';

class HelpScreen extends StatelessWidget {
  final HelpController controller = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Help",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19.0),
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 9, color: Colors.grey)],
              ),
              margin: EdgeInsets.only(top: 70, left: 15, right: 15),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller.nameController,
                        focusNode: controller.nameFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Name",
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(controller.contactFocusNode);
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller.contactController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Contact Number",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: controller.contactFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(controller.emailFocusNode);
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Email",
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(controller.feedbackFocusNode);
                        },
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller.feedbackController,
                        maxLines: 4,
                        maxLength: 1113,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Feedback, Questions, Concerns...We want to hear from you!!",
                        ),
                        textInputAction: TextInputAction.done,
                        focusNode: controller.feedbackFocusNode,
                        onSubmitted: (_) {
                          controller.submitFeedback();
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 43,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: controller.submitFeedback,
                          child: Text('Send'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We Are Available On",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.wordpress_outlined, color: Colors.green),
                      SizedBox(width: 10),
                      Text("www.parkright.app"),
                    ],
                  ),
                  SizedBox(height: 33),
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Info@parkright.app"),
                    ],
                  ),
                  SizedBox(height: 33),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'home_screen.dart';
// class Help extends StatefulWidget {
//   Help({Key? key}) : super(key: key);
//
//   @override
//   State<Help> createState() => _HelpState();
// }
//
// class _HelpState extends State<Help> {
//   final TextEditingController emailcontroller = TextEditingController();
//   final TextEditingController contact = TextEditingController();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController feedback = TextEditingController();
//   final emailFocusNode = FocusNode();
//   final nameFocusNode = FocusNode();
//   final contactFocusNode = FocusNode();
//   final feedbackFocusNode = FocusNode();
//
//
//
//
//   void _submitFeedback() {
//     // Generate a UUID
//     String uuid = Uuid().v4();
//
//     // Get the current user ID (replace this with your own logic for getting the current user ID)
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//
//     // Get the current timestamp
//     Timestamp timestamp = Timestamp.now();
//
//     // Create a map of the feedback data
//     Map<String, dynamic> feedbackData = {
//       'uuid': uuid,
//       'userId': userId,
//       'name': name.text,
//       'contact': contact.text,
//       'email': emailcontroller.text,
//       'feedback': feedback.text,
//       'timestamp': timestamp,
//     };
//
//     // Save the feedback data to Firestore
//     FirebaseFirestore.instance
//         .collection('helps')
//         .doc(uuid)
//         .set(feedbackData)
//         .then((value) {
//       name.clear();
//       contact.clear();
//       emailcontroller.clear();
//       feedback.clear();
//       // Feedback submitted successfully
//       Fluttertoast.showToast(
//         msg: 'Feedback uploaded successfully',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//       );
//
//       // TODO: Add your logic here
//     }).catchError((error) {
//       // Error occurred while submitting feedback
//       Fluttertoast.showToast(
//         msg: 'Failed to upload feedback',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//       );
//
//       // TODO: Handle the error
//     });
//   }
//
//
//   @override
//   void dispose() {
//     // Dispose the text editing controllers and focus nodes
//     emailcontroller.dispose();
//     contact.dispose();
//     name.dispose();
//     feedback.dispose();
//     emailFocusNode.dispose();
//     nameFocusNode.dispose();
//     contactFocusNode.dispose();
//     feedbackFocusNode.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 4,
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => Home()),
//             );
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           "Help",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(19.0),
//                 color: Colors.white,
//                 boxShadow: [BoxShadow(blurRadius: 9, color: Colors.grey)],
//               ),
//               margin: EdgeInsets.only(top: 70, left: 15, right: 15),
//               height: MediaQuery.of(context).size.height * 0.65,
//               width: MediaQuery.of(context).size.width,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 15, right: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 16),
//                       Text(
//                         "Contact Us",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: name,
//                         focusNode: nameFocusNode,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
//                         ],
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xffF5F5F5),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                           ),
//                           hintText: "Name",
//                         ),
//                         textInputAction: TextInputAction.next,
//                         onEditingComplete: () {
//                           FocusScope.of(context).requestFocus(contactFocusNode);
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: contact,
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                         ],
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xffF5F5F5),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                           ),
//                           hintText: "Contact Number",
//                         ),
//                         textInputAction: TextInputAction.next,
//                         focusNode: contactFocusNode,
//                         onEditingComplete: () {
//                           FocusScope.of(context).requestFocus(emailFocusNode);
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: emailcontroller,
//                         focusNode: emailFocusNode,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xffF5F5F5),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                           ),
//                           hintText: "Email",
//                         ),
//                         textInputAction: TextInputAction.next,
//                         onEditingComplete: () {
//                           FocusScope.of(context).requestFocus(feedbackFocusNode);
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: feedback,
//                         maxLines: 4,
//                         maxLength: 1113,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Color(0xffF5F5F5),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                           ),
//                           hintText: "Feedback, Questions, Concerns...We want to hear from you!!",
//                         ),
//                         textInputAction: TextInputAction.done,
//                         focusNode: feedbackFocusNode,
//                         onSubmitted: (_) {
//                           _submitFeedback();
//                           // Handle the submission of the feedback
//                           // TODO: Add your logic here
//                         },
//                       ),
//                       SizedBox(height: 16),
//                       Container(
//                         margin: EdgeInsets.symmetric(vertical: 20),
//                         height: 43,
//                         width: 140,
//                         child: ElevatedButton(
//                           onPressed: _submitFeedback, // Call the submit feedback function on button press
//                           child: Text('Send'),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.red,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                 ),
//               ),
//             ),
//             SizedBox(height: 25),
//             Divider(
//               thickness: 1,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "We Are Available On",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     children: [
//                       Icon(Icons.wordpress_outlined, color: Colors.green),
//                       SizedBox(width: 10),
//                       Text("www.parkright.app"),
//                     ],
//                   ),
//                   SizedBox(height: 33),
//                   Row(
//                     children: [
//                       Icon(Icons.email_outlined, color: Colors.red),
//                       SizedBox(width: 10),
//                       Text("Info@parkright.app"),
//                     ],
//                   ),
//                   SizedBox(height: 33), ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
