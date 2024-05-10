import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todolistproject/components/button_show_opt.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/notification_service.dart';
import 'package:todolistproject/screens/home/components/upcoming_task.dart';
import 'package:todolistproject/screens/home/components/body.dart';
import 'package:todolistproject/screens/home/components/home_header.dart';

import '../../components/menu_dialog.dart';
import 'components/card_task.dart';
import 'components/home_calender.dart';
import 'components/search_field.dart';
import 'components/team.dart';
import 'components/today_task.dart';

class HomeScreen extends StatelessWidget {
  final token;

  const HomeScreen({super.key, @required this.token});

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonShowOptions(token: token),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // Widgets for home header, search field, etc...
              HomeHeader(token: token),
              SizedBox(height: 20),
              SearchField(token: token),
              SizedBox(height: 20),
              ListTeams(token: token),
              SizedBox(height: 20),
              TodayTasks(token: token),
              SizedBox(height: 20),
              UpcomingTasks(token: token),
            ],
          ),
        ),
      ),
    );
  }
}
