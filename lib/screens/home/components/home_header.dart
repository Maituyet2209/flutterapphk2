import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/screens/home/components/icon_notification.dart';
import 'package:todolistproject/screens/home/components/icon_settings.dart';

import 'greetings.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, @required this.token}) : super(key: key);
  final token;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEE, dd MMMM yyyy").format(now);

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  greetingsHeader(
                    token: token,
                  ),
                  Spacer(),
                  IconNotification(
                    numOfNotify: 1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconSettings(),
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   'Let\' make a \nhabits together ⏰✨',
            //   style: TextStyle(
            //       fontSize: 30, fontWeight: FontWeight.bold, color: kTextWhite),
            // ),
            // SizedBox(
            //   height: 25,
            // ),
          ],
        ),
      ),
    );
  }
}
