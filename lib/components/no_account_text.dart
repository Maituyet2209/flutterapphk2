import 'package:flutter/material.dart';
import 'package:todolistproject/screens/forgot_password/forgot_password_screen.dart';
import 'package:todolistproject/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class noAccountText extends StatelessWidget {
  const noAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => signUpScreen())),
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
