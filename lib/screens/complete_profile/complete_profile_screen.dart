import 'package:flutter/material.dart';

import 'components/body.dart';
class completeProfileScreen extends StatelessWidget {
  const completeProfileScreen({super.key});
static String routeName="/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
        ),
        centerTitle: true,
      ),
      body: bodyCompleteProfile(),
    );
  }
}