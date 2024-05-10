import 'package:flutter/material.dart';
import 'package:todolistproject/components/button_show_opt.dart';
import 'package:todolistproject/screens/calendar/components/body.dart';
import 'package:todolistproject/screens/calendar/components/calendar.dart';

import 'components/mycalendar.dart';

class calendarScreen extends StatelessWidget {
  final token;
  const calendarScreen({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonShowOptions(token: token),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            MyCalendar(
              token: token,
            ),
          ],
        ),
      )),
      //floatingActionButton: ButtonShowOptions(),
    );
  }
}
