import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class bodyNotification extends StatefulWidget {
  const bodyNotification({Key? key});

  @override
  State<bodyNotification> createState() => _bodyNotificationState();
}

class _bodyNotificationState extends State<bodyNotification> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications = [
      {
        'id': 1,
        'title': 'Thông báo 1',
        'message': 'Đây là thông báo số 1',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'read': false,
        'user': {
          'id': 1,
          'name': 'John Doe',
          'avatar': 'assets/images/avatar1.png',
        },
      },
      {
        'id': 2,
        'title': 'Thông báo 2',
        'message': 'Đây là thông báo số 2',
        'timestamp':
            DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch,
        'read': true,
        'user': {
          'id': 2,
          'name': 'Jane Smith',
          'avatar': 'assets/images/avatar2.png',
        },
      },
      {
        'id': 3,
        'title': 'Thông báo 3',
        'message': 'Đây là thông báo số 3',
        'timestamp':
            DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch,
        'read': false,
        'user': {
          'id': 3,
          'name': 'Alice Johnson',
          'avatar': 'assets/images/avatar3.png',
        },
      },
    ];
    return SafeArea(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationItem(notification: notifications[index]);
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationItem({required this.notification, Key? key});

  String _getFormattedTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = notification["user"];
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(user["avatar"]),
      ),
      title: Text(user["name"]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification["message"]),
          SizedBox(height: 4), // Khoảng cách giữa message và timestamp
          Text(
            _getFormattedTimestamp(notification["timestamp"]),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: notification["read"]
          ? null // Nếu đã đọc, không có icon
          : Icon(
        Icons.circle,
        color: Colors.blue, // Màu của icon cho thông báo chưa đọc
      ),
      onTap: () {
        // Xử lý khi người dùng nhấn vào một thông báo
      },
    );

    // Icon(
      //   notification["read"] ? Icons.done : Icons.circle,
      //   color: notification["read"] ? Colors.green : Colors.blue,
      // ),
      // onTap: () {
      //   // Xử lý khi người dùng nhấn vào một thông báo
      // },
    // );
  }
}
