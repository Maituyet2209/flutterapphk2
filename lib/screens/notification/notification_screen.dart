import 'package:flutter/material.dart';
import 'package:todolistproject/screens/notification/components/body.dart';

class notificationScreen extends StatelessWidget {
  const notificationScreen({super.key});
  static String routeName ="/notification";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
      ),
      body: bodyNotification(),
    );
  }
}
