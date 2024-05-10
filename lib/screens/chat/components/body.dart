import 'package:flutter/material.dart';
import 'package:todolistproject/screens/chat/components/header_chat.dart';

import 'list_chat_friend.dart';

class bodyChatScreen extends StatelessWidget {
  const bodyChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          headerChat(),
          chatListFriends(),
        ],
      ),
    );
  }
}
