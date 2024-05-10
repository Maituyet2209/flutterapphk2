import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todolistproject/screens/calendar/calendar_screen.dart';
import 'package:todolistproject/screens/chat/chat_screen.dart';
import 'package:todolistproject/screens/group/group_screen.dart';
import 'package:todolistproject/screens/home/home_screen.dart';
import 'package:todolistproject/screens/profile/profile_screen.dart';

import '../constants.dart';
class myBottomNavBar extends StatefulWidget {
  final dynamic token;
  const myBottomNavBar({Key? key, @required this.token}): super(key: key);

  @override
  State<myBottomNavBar> createState() => _myBottomNavBarState();
}

class _myBottomNavBarState extends State<myBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions(String token) {
    return [
      HomeScreen(token: token),
      groupScreen(token: token),
      calendarScreen(token: token),
      chatScreen(),
      profileScreen(token: token),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets = _widgetOptions(widget.token);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _widgets.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: kPrimaryColor,
          animationDuration: kAnimationDuration,
          items: [
            Icon(Icons.home_filled, color: Colors.white),
            Icon(Icons.groups, color: Colors.white),
            Icon(Icons.calendar_month_rounded, color: Colors.white),
            Icon(Icons.chat, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          ],
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
