import 'package:flutter/material.dart';
import 'package:todolistproject/screens/chat/components/search.dart';

import 'list_avatar.dart';

class headerChat extends StatelessWidget {
  const headerChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chat with \nyour friends',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              searchIcon(),
              SizedBox(width: 15),
              Expanded(child: avatarList()),
            ],
          ),
        ],
      ),
    );
  }
}
