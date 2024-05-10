import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';
class socalCard extends StatelessWidget {
  const socalCard({Key? key, required this.icon, required this.press})
      : super(key: key);
  final String icon;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration:
        BoxDecoration(color: Color(0xfff5f6f9), shape: BoxShape.circle),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}