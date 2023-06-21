import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../getx controller /login_controller.dart';
import 'verification.dart';


class Login extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 65),
          child: SingleChildScrollView(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(
                        "Welcome to",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          letterSpacing: 1,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(
                        "Park Right!",
                        maxLines: 1,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(
                        "To verify, enter your phone number",
                        maxLines: 1,
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: IntlPhoneField(
                        initialCountryCode: "+92",
                        initialValue: "Pak",
                        controller: _controller.phoneController,
                        keyboardType: TextInputType.number,
                        dropdownIconPosition: IconPosition.trailing,
                        style: TextStyle(fontSize: 23),
                        flagsButtonMargin: EdgeInsets.only(left: 21),
                        dropdownTextStyle: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 9),
                          filled: true,
                          focusColor: Color(0xffFFFFFF),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                        onChanged: (country) {
                          _controller.dialCodeDigits.value = country.countryCode;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 43,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {
                            final phone = _controller.phoneController.text.trim();
                            if (phone.isEmpty) {
                              _controller.showToast("Please enter a phone number");
                            } else if (!_controller.isValidPhoneNumber(phone)) {
                              _controller.showToast("Invalid phone number. Please fix it.");
                            } else {
                              Get.to(() => Verification(
                                phone: phone,
                                codeDigits: _controller.dialCodeDigits.value,
                              ));
                            }
                          },
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
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
        ),
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:nwewew/screens/verification.dart';
//
//
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
// @override
// State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   TextEditingController _controller = TextEditingController();
//   String dialCodeDigits = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.only(top: 65),
//           child: SingleChildScrollView(
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 26),
//                       child: Text(
//                         "Welcome to",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                           letterSpacing: 1,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 26),
//                       child: Text(
//                         "Park Right!",
//                         maxLines: 1,
//                         style: TextStyle(
//                           letterSpacing: 1,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 26),
//                       child: Text(
//                         "To verify, enter your phone number",
//                         maxLines: 1,
//                         style: TextStyle(
//                           letterSpacing: 1,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.normal,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 30, right: 30),
//                       child: IntlPhoneField(
//                         initialCountryCode: "+92",
//                         initialValue: "Pak",
//                         controller: _controller,
//                         keyboardType: TextInputType.number,
//                         dropdownIconPosition: IconPosition.trailing,
//                         style: TextStyle(fontSize: 23),
//                         flagsButtonMargin: EdgeInsets.only(left: 21),
//                         dropdownTextStyle: TextStyle(fontSize: 24),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left: 9),
//                           filled: true,
//                           focusColor: Color(0xffFFFFFF),
//                           border: OutlineInputBorder(borderSide: BorderSide()),
//                         ),
//                         onChanged: (country) {
//                           setState(() {
//                             dialCodeDigits = country.countryCode;
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 75,
//                     ),
//                     SizedBox(
//                       height: 45,
//                     ),
//                     Center(
//                       child: Container(
//                         margin: EdgeInsets.only(top: 30),
//                         height: 43,
//                         width: MediaQuery.of(context).size.width * 0.6,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_controller.text.trim().isEmpty) {
//                               showToast("Please enter a phone number");
//                             } else if (!isValidPhoneNumber(_controller.text.trim())) {
//                               showToast("Invalid phone number. Please fix it.");
//                             } else {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Verification(
//                                     phone: _controller.text.trim(),
//                                     codeDigits: dialCodeDigits,
//                                   ),
//                                 ),
//                               );
//                             }
//                           },
//                           child: Text(
//                             'Verify',
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(32.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void showToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//   }
//
// }
// bool isValidPhoneNumber(String phoneNumber) {
//   // Regular expression pattern to match a valid phone number
//   // Adjust the pattern according to your desired phone number format
//   final RegExp phoneRegex = RegExp(r'^\+?\d{1,3}[\s.-]?\(?\d{1,3}\)?[\s.-]?\d{1,4}[\s.-]?\d{1,4}$');
//
//   return phoneRegex.hasMatch(phoneNumber);
// }
