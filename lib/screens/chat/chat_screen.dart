import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:todolistproject/constants.dart';

import '../../layout/myBottomNavigation.dart';
import 'components/body.dart';

class chatScreen extends StatelessWidget {
  const chatScreen({super.key});
  static String routeName ="/chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //   title: Text("Chat"),
      //   centerTitle: true,
      // ),
      body: bodyChatScreen(),
    );
  }
}


// class chatScreen extends StatefulWidget {
//   // const chatScreen({super.key});
//   // static String routeName="/chat";
//   @override
//   State<chatScreen> createState() => _chatScreenState();
// }
//
// class _chatScreenState extends State<chatScreen> {
//   // List<types.Message> _messages = [];
//   // final _user = const types.User(
//   //   id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
//   // );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//         body: bodyChatScreen(),
//       // body: Chat(
//       //     messages: _messages, onSendPressed: _handleSendPressed, user: _user),
//       // bottomNavigationBar: myBottomNavBar(
//       //   currentIndex: 2,
//       //   onTap: (index){
//       //     Navigator.pushNamed(context, chatScreen.routeName);
//       //   },
//       // ),
//     );
//   }
//
//   // void _handleSendPressed(types.PartialText message) {
//   //   final textMessage = types.TextMessage(
//   //     author: _user,
//   //     createdAt: DateTime.now().millisecondsSinceEpoch,
//   //     id: "id",
//   //     text: message.text,
//   //   );
//   //
//   //   _addMessage(textMessage);
//   // }
//   //
//   // void _addMessage(types.Message message) {
//   //   setState(() {
//   //     _messages.insert(0, message);
//   //   });
//   // }
// }
