import 'package:flutter/material.dart';

import '../../layout/myBottomNavigation.dart';
import 'components/body.dart';

class groupScreen extends StatelessWidget {
  final token;
  const groupScreen({super.key, this.token});
  static String routeName="/group";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group"),
        centerTitle: true,
      ),
      body: bodyGroup(),
      // bottomNavigationBar: myBottomNavBar(
      //   currentIndex: 1,
      //   onTap: (index){
      //     Navigator.pushNamed(context, groupScreen.routeName);
      //   },
      // ),
    );
  }
}
