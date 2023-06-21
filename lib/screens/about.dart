import 'package:flutter/material.dart';
import 'package:nwewew/screens/setting.dart';


class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SettingScreen()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
      ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              "Park Right!",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 70),
          child: Text("Version",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 5),
          child: Text("2.1.0"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 10),
          child: Text("Powered by",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 5),
          child: Text("Park Rights"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 20),
          child: Text("Servicing Cities",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 5),
          child: Text("Santa Cruz, CA"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 5),
          child: Text("Don't see your city? Contact us directly - we are adding cities monthly!",
            maxLines: 1,
          style: TextStyle(
            fontSize: 9
          ),),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 17,top: 40),
          child: Align(alignment: Alignment.topLeft,
              child: Text(
                  "Contact us",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18,top: 18),
          child: Row(
            children: [
              Icon(Icons.wordpress_outlined,color: Colors.green,),
              SizedBox(width: 10,),
              Text("www.parkright.app"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18,top: 22),
          child: Row(
            children: [
              Icon(Icons.email_outlined,color: Colors.red,),
              SizedBox(width: 10,),
              Text("Info@parkright.app"),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
