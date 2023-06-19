import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                FirebaseAuth.instance.currentUser != null
                    ?Home()
                    : Login()
            ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: SizedBox(height: 100,)),
          Expanded(child: Image.asset("assets/splash back.png",)),

         Expanded(
           child: Align(
             alignment: Alignment.bottomCenter,
             child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 20,
                ),
           ),
         ),

        ],
      ),
    );
  }
}
