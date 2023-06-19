import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/edit_profile.dart';
import '../screens/help.dart';
import '../screens/login_screen.dart';
import '../screens/setting.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(snapshot.data!.docs[0]['userImg']),
                ),
                SizedBox(height: 20),
                Text(
                  (snapshot.data!.docs[0]['firstName']),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(height: 10),
                Text( (snapshot.data!.docs[0]['phoneNumber']),),
                SizedBox(height: 20),
                Container(
                  color: Color(0xffC4C4C4),
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Preferences"),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfile(
                      firstName: snapshot.data!.docs[0]['firstName'],
                      lastName: snapshot.data!.docs[0]['lastName'],
                      userImg: snapshot.data!.docs[0]['userImg'],
                      phoneNumber: snapshot.data!.docs[0]['phoneNumber'],
                      //email: snapshot.data!.docs[0]['email'],
                      addVenmo: snapshot.data!.docs[0]['addVenmo'],

                    )));
                  },
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 36,
                      width: 36,
                      color: Color(0xffC4C4C4),
                      child: Icon(Icons.person_outline),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Edit Profile"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Setting()));
                  },
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 36,
                      width: 36,
                      color: Color(0xffC4C4C4),
                      child: Icon(Icons.settings),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Settings"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Help()));
                  },
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 36,
                      width: 36,
                      color: Color(0xffC4C4C4),
                      child: Icon(Icons.help_outline),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Help"),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: 43,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          Column(
                            children: [
                              Container(
                                height: 80,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.grey,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 7, color: Colors.white),
                                  ],
                                ),
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
                                "Logout",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text("Are you sure you want to Logout?"),
                              SizedBox(height: 50),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                height: 43,
                                width: 230,
                                child: ElevatedButton(
                                  onPressed: () {
                                    logout(context);
                                  },
                                  child: Text('Logout now'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 36,
                      width: 36,
                      color: Color(0xffC4C4C4),
                      child: Icon(Icons.logout),
                    ),
                    title: Text("Logout"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          );
        },
      ),

        ));
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}
