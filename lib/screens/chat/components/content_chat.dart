import 'package:flutter/material.dart';

import 'item_chat.dart';

class contentChat extends StatelessWidget {
  const contentChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            chatItem(
              avatar: 'assets/images/avatar1.png',
              chat: 1,
              message:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              time: '18.00',
            ),
            chatItem(
              avatar: 'assets/images/avatar1.jpg',
              chat: 1,
              message:
              'Hello Mai',
              time: '18.01',
            ),
            chatItem(
              avatar: 'assets/images/avatar1.jpg',
              chat: 0,
              message:
              'Hello John 🐣',
              time: '19.00',
            ),
            chatItem(
              avatar: 'assets/images/avatar1.jpg',
              chat: 1,
              message:
              'It has survived not only five centuries, 😀',
              time: '19.00',
            ),
          ],
        ),
      ),
    );
  }
}
