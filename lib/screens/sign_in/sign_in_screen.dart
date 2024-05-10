import 'package:flutter/material.dart';
import 'package:todolistproject/screens/sign_in/components/body.dart';

class signInScreen extends StatelessWidget {
  const signInScreen({super.key});

  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,),
        ),
        centerTitle: true,
        //leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: bodySignIn(),
    );
  }
}
