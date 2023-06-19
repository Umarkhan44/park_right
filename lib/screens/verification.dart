import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nwewew/screens/home_screen.dart';
import 'package:pinput/pinput.dart';

import 'package:uuid/uuid.dart';

import 'create_account.dart';
import 'login_screen.dart';
import 'main_home.dart';

class Verification extends StatefulWidget {
  final String phone;
  final String codeDigits;
  Verification({required this.phone, required this.codeDigits});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  String? verificationCode;
  bool isVerifying = false;
  late UserCredential userCredential;


  @override
  void initState() {
    super.initState();
   verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    setState(() {
      isVerifying = true;
    });

    final phoneNumber = "${widget.codeDigits + widget.phone}";
    final verificationCompleted = (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential).then((userCredential) async {
        if (userCredential.user != null) {
          final uid = userCredential.user!.uid;
          final String uuid = Uuid().v4(); // Generate a UUID

          final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
          if (userDoc.exists) {
            // User already exists, move to MainHome screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else {
            // New user, create user collection
            await FirebaseFirestore.instance.collection('users').doc(uid).set({
              'userId': uid,
              'phoneNumber': phoneNumber,
              'userName': '',
              'creationTime': Timestamp.now(),
              'uuid': uuid, // Add the UUID field
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Account()),
            );
          }
        }
      });
    };

    final verificationFailed = (FirebaseAuthException e) {
      Fluttertoast.showToast(
        msg: "Verification failed. Please check your internet connection.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    };

    final codeSent = (String verificationId, int? resendToken) {
      setState(() {
        verificationCode = verificationId;
      });
    };

    final codeAutoRetrievalTimeout = (String verificationId) {
      setState(() {
        verificationCode = verificationId;
      });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: Duration(seconds: 30),
    );
  }



  void verifyOTP(String pin) async {
    setState(() {
      isVerifying = true;
    });

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode!,
          smsCode: pin,
        ),
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;
        final phoneNumber = "${widget.codeDigits + widget.phone}";
        final String uuid = Uuid().v4(); // Generate a UUID

        final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          // User already exists, move to MainHome screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          // New user, create user collection
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'userId': uid,
            'phoneNumber': phoneNumber,
            'userName': '',
            'creationTime': Timestamp.now(),
            'uuid': uuid, // Add the UUID field
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Account()),
          );
        }
      }
    } catch (e) {
      FocusScope.of(context).unfocus();
      Fluttertoast.showToast(
        msg: "Invalid OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    setState(() {
      isVerifying = false;
    });
  }


  void showVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Verifying...'),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              Padding(
                padding:  EdgeInsets.only(left: 30, top: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Icon(Icons.arrow_back_ios)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Verification",
                  style: TextStyle(
                    wordSpacing: 2,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "You will receive an OTP code on your phone that\n you must enter",
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.grey, fontSize: 14, letterSpacing: 0.4),
                ),
              ),
              Text("${widget.codeDigits}-${widget.phone}"),
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  length: 6,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  pinAnimationType: PinAnimationType.rotation,
                  controller: _pinOTPCodeController,
                  defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 4, color: Colors.grey)
                          ],
                          border: Border.all(
                              color: Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(15))),
                  onSubmitted: (pin) async {
                    verifyOTP(pin);
                  },
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                  child: Text(
                    "Did not receive a code?",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey, letterSpacing: 2),
                  )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                    "R E S E N D",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffEA0016)),
                  )),
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  height: 43,
                  width: 300,
                  child: ElevatedButton(
                    onPressed:  () {
                      verifyOTP(_pinOTPCodeController.text);
                    },
                    child:
                         Text('Done'),
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
    );
  }

}

// children: [
//   Form(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       SizedBox(
//         height: 68,width: 58,
//       child: TextField(
//         style: Theme.of(context).textTheme.headline6,
//
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         inputFormatters: [LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly],
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.green,
//           focusColor: Colors.green,
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(5.0),
//         ),
//
//       ),
//       ),),
//       SizedBox(width: 10,),
//       SizedBox(height: 68,width: 58,
//         child: TextField(
//           style: Theme.of(context).textTheme.headline6,
//
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           inputFormatters: [LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly],
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.green,
//             focusColor: Colors.green,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//
//           ),
//         ),),
//       SizedBox(width: 10,),
//       SizedBox(height: 68,width: 58,
//         child: TextField(
//           style: Theme.of(context).textTheme.headline6,
//
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           inputFormatters: [LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly],
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.green,
//             focusColor: Colors.green,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//
//           ),
//         ),), SizedBox(width: 10,),
//       SizedBox(height: 68,width: 58,
//         child: TextField(
//           style: Theme.of(context).textTheme.headline6,
//
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           inputFormatters: [LengthLimitingTextInputFormatter(1),
//             FilteringTextInputFormatter.digitsOnly],
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.green,
//             focusColor: Colors.green,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//
//           ),
//         ),),],
//   ),
//   ),
// ],





// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pinput/pinput.dart';
// // import 'package:untitled/create_account.dart';
// // import 'package:untitled/home_screen.dart';
// // import 'package:untitled/login_screen.dart';
// //
// // class Verification extends StatefulWidget {
// //
// //   final String phone;
// //   final String codeDigits;
// //
// //
// //   Verification({required this.phone, required this.codeDigits,});
// //
// //   @override
// //   State<Verification> createState() => _VerificationState();
// // }
// //
// // class _VerificationState extends State<Verification> {
// //   final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
// //   final TextEditingController _pinOTPCodeCotroller = TextEditingController();
// //   String? verificationCode;
// //
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     verifyPhoneNumber();
// //
// //   }
// //
// //   verifyPhoneNumber() async {
// //     await FirebaseAuth.instance.verifyPhoneNumber(
// //       phoneNumber: "${widget.codeDigits+widget.phone}",
// //       verificationCompleted: (PhoneAuthCredential credential) async {
// //         await FirebaseAuth.instance
// //             .signInWithCredential(credential)
// //             .then((value) async {
// //           if (value.user != null)   {
// //             final CollectionReference usersCollection =  await FirebaseFirestore.instance.collection("user");
// //             await usersCollection.doc(value.user!.uid).set({
// //               'phone': '${widget.codeDigits}-${widget.phone}',
// //             });
// //             Navigator.pushReplacement(
// //                 context, MaterialPageRoute(builder: (context) => Account()));
// //           }
// //         });
// //       },
// //       verificationFailed: (FirebaseAuthException e) {
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text(e.message.toString()),
// //           duration: Duration(seconds: 4),
// //         ));
// //
// //       },
// //       codeSent: (String vID, resentToken) {
// //         setState(() {
// //           verificationCode =  vID;
// //         });
// //       },
// //       codeAutoRetrievalTimeout: (String vID) {
// //         setState(() {
// //           verificationCode = vID;
// //         });
// //       },
// //       timeout: Duration(seconds: 30),
// //     );
// //   }
// //
// //
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         key: _scaffolkey,
// //         body: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisAlignment: MainAxisAlignment.start,
// //
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 30, top: 20),
// //                 child: GestureDetector(
// //                     onTap: () {
// //                       Navigator.pushReplacement(context,
// //                           MaterialPageRoute(builder: (context) => Login()));
// //                     },
// //                     child: Icon(Icons.arrow_back_ios)),
// //               ),
// //               SizedBox(
// //                 height: 30,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 30),
// //                 child: Text(
// //                   "Verification",
// //                   style: TextStyle(
// //                     wordSpacing: 2,
// //                     letterSpacing: 3,
// //                     fontWeight: FontWeight.w800,
// //                     fontSize: 24,
// //                     color: Color(0xff000000),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 30),
// //                 child: Text(
// //                   "You will receive an OTP code on your phone that\n you must enter",
// //                   maxLines: 2,
// //                   style: TextStyle(
// //                       color: Colors.grey, fontSize: 14, letterSpacing: 0.4),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 60,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(bottom: 20,left: 27),
// //                 child: Text(
// //                   'Verify ${widget.codeDigits}-${widget.phone}',
// //                 ),
// //               ),
// //               Align(
// //                 alignment: Alignment.center,
// //                 child: Pinput(
// //                   length: 6,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   pinAnimationType: PinAnimationType.rotation,
// //                   controller: _pinOTPCodeCotroller,
// //                   defaultPinTheme: PinTheme(
// //                       width: 50,
// //                       height: 50,
// //                       decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           boxShadow: [
// //                             BoxShadow(blurRadius: 4, color: Colors.grey)
// //                           ],
// //                           border: Border.all(
// //                               color: Color.fromRGBO(234, 239, 243, 1)),
// //                           borderRadius: BorderRadius.circular(15))),
// //                   onSubmitted: (pin) async {
// //                     try {
// //                       await FirebaseAuth.instance
// //                           .signInWithCredential(PhoneAuthProvider.credential(
// //                           verificationId: verificationCode!, smsCode: pin))
// //                           .then((value) {
// //                         if (value.user != null) {
// //
// //                           Navigator.pushReplacement(context,
// //                               MaterialPageRoute(builder: (context) => Account( )));
// //                         }
// //                       });
// //                     } catch (e) {
// //                       FocusScope.of(context).unfocus();
// //                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //
// //                         padding: EdgeInsets.only(bottom: 100),
// //                         content: Container(color: Colors.orange,
// //                           height: 50,
// //                           width: 70,
// //
// //                           child: Center(
// //                             child: Text(
// //                               "invalid otp",
// //                             ),
// //                           ),
// //                         ),
// //                         duration: Duration(seconds: 4),
// //                       ));
// //                     }
// //                   },
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 70,
// //               ),
// //               Center(
// //                   child: Text(
// //                     "Did not receive a code?",
// //                     style: TextStyle(
// //                         fontSize: 18, color: Colors.grey, letterSpacing: 2),
// //                   )),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               Center(
// //                   child: GestureDetector(
// //                     onTap: (){
// //                       verifyPhoneNumber();
// //                     },
// //                     child: Text(
// //                       "R E S E N D",
// //                       style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.w700,
// //                           color: Color(0xffEA0016)),
// //                     ),
// //                   )),
// //               SizedBox(
// //                 height: 70,
// //               ),
// //               Center(
// //                 child: Container(
// //                   margin: EdgeInsets.symmetric(vertical: 30),
// //                   height: 43,
// //                   width: 300,
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       verifyPhoneNumber();
// //                       // Navigator.pushReplacement(context,
// //                       //     MaterialPageRoute(builder:
// //                       //         (context) =>
// //                       //         Account()));
// //                     },
// //                     child: Text(
// //                       'Done:',
// //                     ),
// //                     style: ElevatedButton.styleFrom(
// //                       primary: Colors.black,
// //                       //onPrimary: Colors.white,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(25.0),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   TextEditingController _controller = TextEditingController();
//   String dialCodeDigits = "+00";
//   @override
//
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
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 26),
//                       child: Text(
//                         "Welcome to",
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                             letterSpacing: 1,
//                             fontWeight: FontWeight.normal),
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
//                             letterSpacing: 1,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red),
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
//                             letterSpacing: 1,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.normal,
//                             fontSize: 14),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(left: 30, right: 30),
//                       child: IntlPhoneField(
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
//
//                           // value = phone as PhoneNumber;
//                           //  print(phone.completeNumber);
//                         },
//                         onCountryChanged: (country) {
//
//                           country;
//                           //  Country changed to: ' + country.name);
//                         },
//                       ),
//                     ),
//                     // Center(
//                     //   child: Container(
//                     //     width: MediaQuery.of(context).size.width * 0.8,
//                     //     height: 53,
//                     //     margin: EdgeInsets.only(top: 50),
//                     //     decoration: BoxDecoration(
//                     //       borderRadius: BorderRadius.circular(19.0),
//                     //       color: Colors.white,
//                     //       boxShadow: [
//                     //         BoxShadow(blurRadius: 9, color: Colors.grey)
//                     //       ],
//                     //     ),
//                     //     // margin: EdgeInsets.only(right: 42,left: 42),
//                     //     child: Center(
//                     //       child: TextField(
//                     //         decoration: InputDecoration(
//                     //             contentPadding: EdgeInsets.only(left: 9),
//                     //             //  filled: true,
//                     //             focusColor: Color(0xffFFFFFF),
//                     //             border: OutlineInputBorder(
//                     //               borderSide: BorderSide.none,
//                     //             ),
//                     //             hintText: "Phone",
//                     //             hintStyle:
//                     //                 TextStyle(fontSize: 16, color: Colors.grey)),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
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
//
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Verification(
//                                       phone : _controller.text,
//                                       codeDigits : dialCodeDigits,
//                                     )));
//
//                           },
//
//                           child: Text(
//                             'Verify',
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.black,
//                             // onPrimary: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(32.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
