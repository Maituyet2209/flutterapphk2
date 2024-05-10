import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todolistproject/screens/profile/components/profile_menu.dart';
import 'package:todolistproject/screens/profile/components/profile_pic.dart';

class bodyProfile extends StatelessWidget {
  const bodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          profilePic(),
          const SizedBox(
            height: 20,
          ),
          profileMenu(
              text: "My Account", icon: "assets/icons/user.svg", press: () {}),
          profileMenu(
              text: "Labels", icon: "assets/icons/user.svg", press: () {}),
          profileMenu(
              text: "Reset Password", icon: "assets/icons/user.svg", press: () {}),
          profileMenu(
              text: "Help Center", icon: "assets/icons/user.svg", press: () {}),
        ],
      ),
    );
  }
}
