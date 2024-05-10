import 'package:flutter/material.dart';

import 'item_chats.dart';

class chatListFriends extends StatelessWidget {
  const chatListFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 35),
          physics: BouncingScrollPhysics(),
          children: [
            chatItems(
              avatar: 'assets/images/avatar1.png',
              name: 'Johnny Doe',
              chat:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              time: '08.10',
            ),
            chatItems(
              avatar: 'assets/images/avatar2.png',
              name: 'Adrian',
              chat:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              time: '08.10',
            ),
            chatItems(
              avatar: 'assets/images/avatar3.png',
              name: 'Fiona',
              chat:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              time: '08.10',
            ),
            // Add more ChatItems here
          ],
        ),
      ),
    );
  }
}
