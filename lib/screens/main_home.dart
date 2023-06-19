import 'package:flutter/material.dart';

import '../inner screens/approved.dart';
import '../inner screens/denied_screen.dart';
import '../inner screens/requested_screen.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome>with SingleTickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 18,right:18),
        child: Column(
          children: [
            SizedBox(height: 23,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Park Right!",style: TextStyle(
                    fontSize: 27,color: Colors.red
                ),),
                Icon((Icons.notification_add_outlined))
              ],
            ),
            SizedBox(height: 18,),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0), // Add desired padding
                child: TabBar(
                  labelStyle: TextStyle(
                    fontSize: 12,
                  ),
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.3),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'Requested',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Approved',
                        style: TextStyle(fontSize: 15.0),
                        maxLines: 1,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Denied',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Expanded(
              child: TabBarView(

                controller: _tabController,
                children: [
                  RequestScreen(),
                  ApprovedScreen(),
                  // ApprovedScreen(),
                  DeniedScreen(),

                ],
              ),
            ),
          ],
        ),
      ),
      // body:  Stack(
      //   children: [
      //     Positioned(
      //         top: 20,
      //         left: 25,
      //         child: Text(
      //             "Park Right!",
      //           style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.w400,
      //             color: Colors.red,
      //             fontStyle: FontStyle.normal
      //           ),
      //         )),
      //     Positioned(
      //       top: 30,
      //       right: 15,
      //       left: 15,
      //       child: Container(
      //         margin: EdgeInsets.only(right: 15,left: 12,top: 33),
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10.0),
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(blurRadius: 9, color: Colors.grey)
      //           ],
      //         ),
      //         child: Row(
      //           children: <Widget>[
      //             Expanded(
      //               child: TextField(
      //
      //                 cursorColor: Colors.black,
      //                 keyboardType: TextInputType.text,
      //                 textInputAction: TextInputAction.go,
      //                 decoration: InputDecoration(
      //                     filled: true,
      //                     fillColor: Colors.white,
      //                     suffixIcon: Icon(
      //                       Icons.search,
      //                       color: Colors.black,
      //                     ),
      //
      //                     border: InputBorder.none,
      //                     contentPadding: EdgeInsets.symmetric(
      //                         horizontal: 15, vertical: 15),
      //                     hintText: "Search..."),
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //       ),
      //     ),
      //   Padding(
      //     padding: const EdgeInsets.only(top: 140),
      //     child: ListView.builder(
      //       itemCount: 34,
      //       itemBuilder: (BuildContext context, int index) {
      //         return Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             height: 87,
      //             margin: EdgeInsets.only(right: 17, left: 17),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10.0),
      //               color: Colors.white,
      //               boxShadow: [
      //                 BoxShadow(blurRadius: 9, color: Colors.grey)
      //               ],
      //             ),
      //             child: GestureDetector(
      //               onTap: (){
      //                 Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => TagDatil()));
      //               },
      //               child: ListTile(
      //                 leading: Image.asset(
      //                   "assets/car.png",
      //                   fit: BoxFit.cover,
      //                 ),
      //                 title: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text("Parking in a Red Zone"),
      //                 ),
      //                 subtitle: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text("19 Jun, 2022 11:50"),
      //                 ),
      //               ),
      //             ),
      //
      //             //  Login()
      //           ),
      //         );
      //       }),
      //   ),
      // ],
      //
      // ),
    );
  }
}
