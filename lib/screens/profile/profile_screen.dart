import 'package:flutter/material.dart';
import 'package:todolistproject/screens/profile/components/body.dart';
import 'package:todolistproject/screens/profile/components/profile_menu.dart';

import '../../layout/myBottomNavigation.dart';

class profileScreen extends StatelessWidget {
  final token;
  const profileScreen({super.key, this.token});
  static String routeName ="/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: bodyProfile(),
      // bottomNavigationBar: myBottomNavBar(
      //   currentIndex: 3,
      //   onTap: (index){
      //     Navigator.pushNamed(context, profileScreen.routeName);
      //   },
      // ),
    );
  }
}
