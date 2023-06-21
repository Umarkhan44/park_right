import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nwewew/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nwewew/screens/edit_profile.dart';
import 'package:nwewew/screens/help.dart';
import 'package:nwewew/screens/login_screen.dart';
import 'package:nwewew/screens/setting.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'park_right',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Splash()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/editProfile', page: () => EditProfile()),
        GetPage(name: '/settings', page: () => SettingScreen()),
        GetPage(name: '/help', page: () => HelpScreen()),
        GetPage(name: '/help', page: () => HelpScreen()),
      ],
      home: Splash(),
    );
  }
}
