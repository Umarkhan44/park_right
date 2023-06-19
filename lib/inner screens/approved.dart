import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/tag_detail.dart';



class ApprovedScreen extends StatefulWidget {
   ApprovedScreen({super.key});

  @override
  State<ApprovedScreen> createState() => _ApprovedScreenState();

}

class _ApprovedScreenState extends State<ApprovedScreen>with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000), // Adjust the duration as desired
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Adjust the curve as desired
    );

    // Add a delay before starting the animation
    Future.delayed(Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tag')
            .where('Approved', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());

          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // No approved documents found
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/empty-box.png'),
                Material(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text('Not Approved Yet',style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23
                    ),),
                  ),
                ),
                SizedBox(height: 33,),
                SizedBox(height: 33,),
              ],
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = documents[index];
              Timestamp timestamp = document['tagtime'];
              DateTime dateTime = timestamp.toDate();
              String formattedTime =
              DateFormat('dd MMM, yyyy hh:mm a').format(dateTime);

              return SlideTransition(
                  position: Tween<Offset>(
                  begin: Offset(1, 0), // Adjust the start position as desired
              end: Offset.zero,
              ).animate(_animation),
              child: Container(
                height: 87,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 5, color: Colors.grey),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TagDatil(
                          formattedTime: formattedTime,
                          frontImages: document['frontPhoto'],
                          backImages: document['backPhoto'],
                          selectedValue: document['selectedValue2'],
                          Approved: document['Approved'],
                          Denied: document['Denied'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        documents[index]['backPhoto'][0],
                        fit: BoxFit.cover,
                        height: 69,
                        width: 64,
                      ),
                    ),
                    title: Text(
                      document['selectedValue2'],
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        SizedBox(width: 6),
                        Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Approved",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff165E96),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )  );
            },
          );
        },
      ),

    );
  }
}
