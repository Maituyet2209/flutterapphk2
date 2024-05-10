import 'package:flutter/material.dart';
import 'package:todolistproject/size_config.dart';

const kPrimaryColor = Colors.orange;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xfffac000), Color(0xFFFFECDF)],
);
const kSecondaryColor = Color(0xffd7d7d7);
const kTextColor = Colors.black;
const kTextWhite = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: getProportionateScreenWidth(28),
  height: 1.5,
);

//Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  enabledBorder:outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),);
}