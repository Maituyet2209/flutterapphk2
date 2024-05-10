import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistproject/screens/sign_in/components/sign_in_form.dart';

import 'package:todolistproject/size_config.dart';

import '../../../components/no_account_text.dart';
import '../../../components/socal_card.dart';

class bodySignIn extends StatelessWidget {
  const bodySignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.04
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Sign in with your email and password \n or continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: SizeConfig.screenHeight! * 0.08
              ),
              signInForm(),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.08
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socalCard(
                    icon: "assets/icons/google.svg",
                    press: () {},
                  ),
                  socalCard(
                    icon: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  socalCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              noAccountText(),
            ],
          ),
        ),
      ),
    ));
  }
}

