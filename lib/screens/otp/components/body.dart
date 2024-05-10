import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistproject/components/defaut_button.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/size_config.dart';

import 'otp_form.dart';

class bodyOtpScreen extends StatelessWidget {
  const bodyOtpScreen({super.key});

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
              SizedBox(height: SizeConfig.screenHeight!*0.05,),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text(
                "We sent your code to +84 084 859 874 ",
                textAlign: TextAlign.center,
              ),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight!*0.15,),
              otpForm(),
              SizedBox(height: SizeConfig.screenHeight!*0.1,),
              GestureDetector(
                onTap: (){
                  //resend your OTP code
                },
                child: Text("Resend OTP Code",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in"),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            " 00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}


