import 'package:flutter/material.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/screens/chat/components/topChat.dart';

import 'content_chat.dart';
import 'form_chat.dart';

class chatPage extends StatefulWidget {
  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                topChat(),
                contentChat(),
                SizedBox(height: 120),
              ],
            ),
            formChat(),
          ],
        ),
      ),
    );
  }
}