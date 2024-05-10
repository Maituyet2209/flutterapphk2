import 'package:flutter/material.dart';
import 'package:todolistproject/size_config.dart';

import 'components/body.dart';

class splashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [Colors.orange, Colors.white],
          //   ),
          // ),
          child: bodySplash()),
    );
  }
}
