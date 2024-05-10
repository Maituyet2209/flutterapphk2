import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todolistproject/screens/login_success/components/body.dart';
import 'package:todolistproject/size_config.dart';

class loginSuccessScreen extends StatelessWidget {
  final token;
  const loginSuccessScreen({super.key,@required this.token});

  static String routeName = "/login_success";

  // late String firstName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
      ),
      //body: Text('$firstName $lastName'),
      body: bodyLoginSuccess(token: token),
    );
  }
}
