import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todolistproject/config.dart';
import '../../../config.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;
  final token;
  final List<dynamic>? tasks;

  const TaskCard({Key? key, required this.task, required this.token, this.tasks}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    GetTaskStatus();
  }

  void GetTaskStatus() async {
    try {
      var response = await http.post(
        Uri.parse(getTaskStatus),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": widget.task['_id']}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          isCompleted = jsonResponse['success'] == 'completed';
          isChecked = isCompleted;
        });
      } else {
        throw Exception('Failed to load task status');
      }
    } catch (error) {
      print('Error fetching task status: $error');
    }
  }

  void UpdateTaskStatusToCompleted(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(updateTaskStatusToCompleted),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      setState(() {
        isCompleted = true;
      });
    }
  }

  void UpdateTaskStatusToPending(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(updateTaskStatusPending),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      setState(() {
        isCompleted = false;
      });
    }
  }

  void deleteItem(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(deleteTask),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // Remove task from local data source (assuming you have a list)
      setState(() {
        // Update your list to remove the task with the matching id
        // (replace 'tasks' with your actual data source variable name)
        widget.tasks!.removeWhere((task) => task['_id'] == id);
      });
    } else {
      print('Error deleting task: ${jsonResponse['message'] ?? 'Unknown error'}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        color: isCompleted ? Colors.grey.withOpacity(0.5) : Colors.transparent, // Màu xám khi task đã hoàn thành
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.task['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(int.parse(
                            '0xFF${widget.task['color']['color'].substring(1)}')),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.alarm),
                    SizedBox(width: 5),
                    Text(DateFormat('HH:mm')
                        .format(DateTime.parse(widget.task['start_time']))),
                    Text(' - '),
                    Icon(Icons.alarm_on_outlined),
                    SizedBox(width: 5),
                    Text(DateFormat('HH:mm')
                        .format(DateTime.parse(widget.task['end_time']))),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.event_note_outlined,
                        color: Color(int.parse(
                            '0xFF${widget.task['color']['color'].substring(1)}'))),
                    SizedBox(width: 5),
                    Text(widget.task['note']),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          if (isCompleted) 
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
               deleteItem(widget.task['_id']);
              },
            ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
                // Thực hiện chức năng của bạn khi checkbox được nhấn vào và truyền token nếu cần
                if (isChecked) {
                  UpdateTaskStatusToCompleted(widget.task['_id']);
                } else {
                  UpdateTaskStatusToPending(widget.task['_id']);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
