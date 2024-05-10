import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/layout/myBottomNavigation.dart';
import 'package:todolistproject/routes.dart';
import 'package:todolistproject/screens/splash/splash_screen.dart';
import 'package:todolistproject/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({@required this.token, Key?key}):super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData(),
      home: (token != null && JwtDecoder.isExpired(token) == false )?myBottomNavBar(token: token):splashScreen()
       //const MyHomePage(title: 'Flutter Demo Home Page'),
      // initialRoute: splashScreen.routeName,
      // routes: routes,
    );
  }
}
