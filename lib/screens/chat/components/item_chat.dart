import 'package:flutter/material.dart';
import 'avatar.dart';

class chatItem extends StatelessWidget {
  const chatItem({
    Key? key,
    required this.chat,
    required this.message,
    required this.time,
    this.avatar = '',
  }) : super(key: key);
  final int chat;
  final String avatar;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chat == 0
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (avatar.isNotEmpty)
          Avatar(
            image: avatar,
            size: 50,
          )
        else
          Text(
            '$time',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: chat == 0
                  ? Colors.indigo.shade100
                  : Colors.indigo.shade50,
              borderRadius: chat == 0
                  ? BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )
                  : BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text('$message'),
          ),
        ),
        if (chat == 1)
          Text(
            '$time',
            style: TextStyle(color: Colors.grey.shade400),
          )
        else
          SizedBox(),
      ],
    );
  }
}
