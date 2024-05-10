import 'package:flutter/material.dart';
import 'package:todolistproject/components/defaut_button.dart';
import 'package:todolistproject/components/form_error.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'complete_profile_form.dart';

class bodyCompleteProfile extends StatelessWidget {
  const bodyCompleteProfile({super.key});

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
              SizedBox(height: SizeConfig.screenHeight! * 0.02,),
              Text(
                "Complete Profile",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Complete your details or continue \n with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.05,),
              completeProfileForm(),
              SizedBox(
                height: getProportionateScreenHeight(30),
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
