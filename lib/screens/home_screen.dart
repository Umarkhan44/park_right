import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../inner screens/profile_screen.dart';
import 'add_new_tag.dart';
import 'main_home.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _ScreenState();
}

class _ScreenState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CurvedNavBar(
          actionButton: CurvedActionBar(
            onTab: (value) {
              /// perform action here
              print(value);
              if (_currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTag()),
                );
              }
            },
            activeIcon: GestureDetector(
              onTap: () {
                if (_currentIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTag()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            inActiveIcon: GestureDetector(
              onTap: () {
                if (_currentIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTag()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            text: "Camera",
          ),
          activeColor: Colors.red,
          navBarBackgroundColor: Colors.white,
          inActiveColor: Colors.black45,
          appBarItems: [
            FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                size: 27,
                color: Colors.black,
              ),
              inActiveIcon: Icon(
                Icons.home,
                size: 27,
                color: Colors.black,
              ),
              text: 'Home',
            ),
            FABBottomAppBarItem(
              activeIcon: Icon(
                Icons.account_circle_outlined,
                size: 27,
                color: Colors.black,
              ),
              inActiveIcon: Icon(
                Icons.account_circle_outlined,
                size: 27,
                color: Colors.black,
              ),
              text: 'Profile',
            ),
          ],
          bodyItems: [
            MainHome(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
