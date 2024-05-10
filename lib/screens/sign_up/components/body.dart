import 'package:flutter/material.dart';
import 'package:todolistproject/components/defaut_button.dart';
import 'package:todolistproject/components/form_error.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/screens/sign_up/components/sign_up_form.dart';
import 'package:todolistproject/size_config.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/socal_card.dart';

class bodySignUp extends StatelessWidget {
  const bodySignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              Text(
                "Register Account",
                style: headingStyle,
              ),
              Text(
                "Complete your details or countinue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.07,
              ),
              //7% of total height
              signUpForm(),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.07,
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
              Text(
                "By continuing your confirm that you agree \nwith our Term and Condition",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
