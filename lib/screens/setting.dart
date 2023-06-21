import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nwewew/screens/privacy_policy.dart';
import 'package:nwewew/screens/term_conditions.dart';
import '../getx controller /settings_controller.dart';
import 'about.dart';
import 'home_screen.dart';

class SettingScreen extends StatelessWidget {
  final SettingController settingController = Get.put(SettingController());

  SettingScreen({Key? key}) : super(key: key);

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
          "Setting",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 33, right: 10, left: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => TermConditionsScreen());
              },
              child: ListTile(
                horizontalTitleGap: 18,
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.orangeAccent,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
                  ),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.article_outlined, color: Colors.white),
                ),
                title: Text("Terms & Conditions"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => PrivacyPolicy());
              },
              child: ListTile(
                horizontalTitleGap: 18,
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.orangeAccent,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
                  ),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.fact_check_outlined, color: Colors.white),
                ),
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => About());
              },
              child: ListTile(
                horizontalTitleGap: 18,
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.orangeAccent,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
                  ),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.info_outline, color: Colors.white),
                ),
                title: Text("About"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:nwewew/screens/privacy_policy.dart';
// import 'package:nwewew/screens/term_conditions.dart';
//
// import 'about.dart';
// import 'home_screen.dart';
//
//
// class Setting extends StatelessWidget {
//   const Setting({Key? key}) : super(key: key);
//
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
//                 context, MaterialPageRoute(builder: (context) => Home()));
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           "Setting",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body:
//       Padding(
//         padding: const EdgeInsets.only(top: 33,right: 10,left: 10),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: (){
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => TermConditions()));
//               },
//               child: ListTile(
//                 horizontalTitleGap: 18,
//                 leading: Container(
//                    decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Colors.orangeAccent,
//                       boxShadow: [
//                         BoxShadow(blurRadius: 2, color: Colors.grey)
//                       ],
//                     ),
//                   height: 40,
//                   width: 40,
//
//                     child: Icon(Icons.article_outlined,color: Colors.white,)),
//                 title: Text("Terms & Conditions"),
//                 trailing: Icon(Icons.arrow_forward_ios_rounded),
//               ),
//             ),
//             GestureDetector(
//               onTap: (){
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PrivacyPolicy()));
//               },
//               child: ListTile(
//                 horizontalTitleGap: 18,
//                 leading: Container(
//                    decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Colors.orangeAccent,
//                       boxShadow: [
//                         BoxShadow(blurRadius: 2, color: Colors.grey)
//                       ],
//                     ),
//                   height: 40,
//                   width: 40,
//
//                     child: Icon(Icons.fact_check_outlined,color: Colors.white,)),
//                 title: Text("Privacy Policy"),
//                 trailing: Icon(Icons.arrow_forward_ios_rounded),
//               ),
//             ),
//             GestureDetector(
//               onTap: (){
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => About()));
//               },
//               child: ListTile(
//                 horizontalTitleGap: 18,
//                 leading: Container(
//                    decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       color: Colors.orangeAccent,
//                       boxShadow: [
//                         BoxShadow(blurRadius: 2, color: Colors.grey)
//                       ],
//                     ),
//                   height: 40,
//                   width: 40,
//
//                     child: Icon(Icons.info_outline,color: Colors.white,)),
//                 title: Text("About"),
//                 trailing: Icon(Icons.arrow_forward_ios_rounded),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
// }
