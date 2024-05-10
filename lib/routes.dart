import 'package:flutter/material.dart';
import 'package:todolistproject/screens/chat/chat_screen.dart';
import 'package:todolistproject/screens/complete_profile/complete_profile_screen.dart';
import 'package:todolistproject/screens/forgot_password/forgot_password_screen.dart';
import 'package:todolistproject/screens/group/group_screen.dart';
import 'package:todolistproject/screens/home/home_screen.dart';
import 'package:todolistproject/screens/label/label_screen.dart';
import 'package:todolistproject/screens/login_success/login_success_screen.dart';
import 'package:todolistproject/screens/notification/notification_screen.dart';
import 'package:todolistproject/screens/otp/otp_screen.dart';
import 'package:todolistproject/screens/personal_task/personal_task_screen.dart';
import 'package:todolistproject/screens/profile/profile_screen.dart';
import 'package:todolistproject/screens/sign_in/sign_in_screen.dart';
import 'package:todolistproject/screens/sign_up/sign_up_screen.dart';
import 'package:todolistproject/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  splashScreen.routeName: (context) => splashScreen(),
  signInScreen.routeName: (context) => signInScreen(),
  forgotPasswordScreen.routeName: (context) => forgotPasswordScreen(),
  loginSuccessScreen.routeName: (context) => loginSuccessScreen(),
  signUpScreen.routeName: (context) => signUpScreen(),
  completeProfileScreen.routeName: (context) => completeProfileScreen(),
  otpScreen.routeName:(context)=>otpScreen(),
  notificationScreen.routeName:(context)=>notificationScreen(),
  HomeScreen.routeName:(context)=>HomeScreen(),
  groupScreen.routeName:(context)=>groupScreen(),
  chatScreen.routeName:(context)=>chatScreen(),
  profileScreen.routeName:(context)=>profileScreen(),

  listPersonalTaskScreen.routeName:(context) => listPersonalTaskScreen(),
  listLabelScreen.routeName:(context)=>listLabelScreen(),


};
