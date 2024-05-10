import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class splashContent extends StatelessWidget {
  const splashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "TimeWise",
          style: TextStyle(
            fontSize: 36,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: "Dancing_Script",
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: "Dancing_Script",
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: 250,
          width: 220,
        ),
      ],
    );
  }
}
