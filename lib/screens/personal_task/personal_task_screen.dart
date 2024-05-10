import 'package:flutter/material.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/size_config.dart';

import 'components/body.dart';

class listPersonalTaskScreen extends StatelessWidget {
  const listPersonalTaskScreen({super.key});

  static String routeName = "/personal_task";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> personalTasks = [
      {"name": "Học Toeic", "due": "","progress":0,"label":"label_name","status":"done"},
      {"name": "Học lập trình Mobile", "due": "","progress":0,"label":"label_name","status":"done"},
      {"name": "Làm báo cáo thực tập", "due": "","progress":0,"label":"label_name","status":"done"},
      {"name": "Học thêm", "due": "","progress":0,"label":"label_name","status":"done"},
      // {"icon": "assets/icons/plus.svg", "text": "Task"},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List personal task",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              //fontSize: getProportionateScreenWidth(20),
        ),
        ),
        centerTitle: true,
      ),
      body: bodyPersonalTaskList(),
    );
  }
}
