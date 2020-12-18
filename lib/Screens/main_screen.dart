import 'package:book1/Screens/home_screen.dart';
import 'package:book1/Screens/profile_screen.dart';
import 'package:book1/Screens/update_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 30),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          UpdateScreen(),
          ProfileScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0XFF990011))),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps, color: Color(0XFF990011))),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Color(0XFF990011))),
        ],
      ),
    );
  }
}
