import 'package:flutter/material.dart';
import 'package:todolistproject/components/defaut_button.dart';
import 'package:todolistproject/layout/myBottomNavigation.dart';
import 'package:todolistproject/screens/home/home_screen.dart';
import 'package:todolistproject/size_config.dart';

class bodyLoginSuccess extends StatefulWidget {
  final token;
  const bodyLoginSuccess({Key? key, @required this.token}) : super(key: key);
  @override
  State<bodyLoginSuccess> createState() => _bodyLoginSuccessState();
}

class _bodyLoginSuccessState extends State<bodyLoginSuccess> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => myBottomNavBar(token: widget.token),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Center(
          child: Image.asset(
            "assets/images/login_success.png",
            height: SizeConfig.screenHeight! * 0.5, //50%
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight! * 0.08,
        ),
        Text(
          "Login Success",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(28),
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: defaultButton(
            text: "Back to home",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => myBottomNavBar(token: widget.token),
                ),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
