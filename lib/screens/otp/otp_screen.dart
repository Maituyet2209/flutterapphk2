import 'package:flutter/material.dart';

import 'components/body.dart';
class otpScreen extends StatelessWidget {
  const otpScreen({super.key});
static String routeName="/opt_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
      ),
      body: bodyOtpScreen(),
    );
  }
}
