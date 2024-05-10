import 'package:flutter/material.dart';

import 'components/body.dart';

class signUpScreen extends StatelessWidget {
  const signUpScreen({super.key});

  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
        ),
        centerTitle: true,
      ),
      body: bodySignUp(),
    );
  }
}
