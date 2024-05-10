import 'package:flutter/material.dart';
import 'package:todolistproject/screens/forgot_password/components/body.dart';

class forgotPasswordScreen extends StatelessWidget {
  const forgotPasswordScreen({super.key});
  static String routeName="/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: bodyForgotPassword(),
    );
  }
}
