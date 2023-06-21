// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../getx controller/home_controller.dart';
// import '../inner screens/profile_screen.dart';
//
// import '../screens/add_new_tag.dart';
// import '../screens/main_home.dart';
//
// class HomeScreen extends GetWidget<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Obx(
//               () => IndexedStack(
//             index: controller.currentIndex.value,
//             children: [
//               MainHome(),
//               Profile(),
//             ],
//           ),
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           index: controller.currentIndex.value,
//           onTap: controller.changeTabIndex,
//           backgroundColor: Colors.white,
//           color: Colors.red,
//           height: 50,
//           items: [
//             Icon(Icons.home),
//             Icon(Icons.account_circle_outlined),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             if (controller.currentIndex.value == 0) {
//               Get.to(() => AddTag());
//             }
//           },
//           child: Icon(Icons.add),
//           backgroundColor: Colors.red,
//         ),
//       ),
//     );
//   }
// }
