import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:todolistproject/screens/home/components/task_card.dart';
import '../../../config.dart';

class TodayTasks extends StatefulWidget {
  final token;
  const TodayTasks({@required this.token, Key? key}) : super(key: key);

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  late String userId;
  List<dynamic>? items;
  bool isChecked = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTaskListToday(userId);
  }

  void getTaskListToday(userId) async {
    var regBody = {"userId": userId};
    var response = await http.post(
      Uri.parse(getUserTodayTasks),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    var tasks = jsonResponse['success'];

    if (tasks != null) {
      // Lấy danh sách các task đã hoàn thành và chưa hoàn thành
      var completedTasks = tasks.where((task) => task['status'] == 'completed').toList();
      var pendingTasks = tasks.where((task) => task['status'] != 'completed').toList();

      // Kết hợp danh sách các task chưa hoàn thành và đã hoàn thành
      var combinedTasks = [...pendingTasks, ...completedTasks];

      for (var task in combinedTasks) {
        GetTaskStatus(task['_id']); // Loại bỏ việc sử dụng kết quả của GetTaskStatus
      }

      setState(() {
        items = combinedTasks;
      });
    }
  }

  void GetTaskStatus(id) async {
    try {
      var response = await http.post(
        Uri.parse(getTaskStatus),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var taskIndex = items!.indexWhere((task) => task['_id'] == id);
        if (taskIndex != -1) {
          setState(() {
            items![taskIndex]['isCompleted'] = jsonResponse['success'] == 'completed';
          });
        }
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
      getTaskListToday(userId);
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
      getTaskListToday(userId);
      setState(() {
        isCompleted = false;
      });
    }
  }

  void deleteItem(id, isCompleted) async {
    if (isCompleted) {
      var regBody = {"id": id};
      var response = await http.post(Uri.parse(deleteTask),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        getTaskListToday(userId);
      } else {
        print('Error deleting task: ${jsonResponse['message'] ?? 'Unknown error'}');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:Colors.white,
            shadowColor: Colors.indigo,
            title: Text("Can't Delete Task"),
            content: Text("You can only delete completed tasks."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Today",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Container(
            child: items != null
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: items!.length,
              itemBuilder: (BuildContext context, int index) {
                var task = items![index];
                var isCompleted = task != null ? task['isCompleted'] ?? false : false;
                return Slidable(
                  key: Key('${task['_id']}'),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (BuildContext context) {
                          deleteItem('${task['_id']}', isCompleted);
                        },
                      ),
                    ],
                  ),
                  child:Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          task['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Readex',
                          ),
                        ),
                        //SizedBox(height: 5.0),
                        Text(
                          task['note'],
                          style: TextStyle(
                            //fontSize: 10.0,
                            fontFamily: 'Readex',
                          ),
                        ),
                        Divider(
                          height: 24,
                          thickness: 1,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.alarm, color: Colors.grey,),
                                SizedBox(width: 5),
                                Text(
                                  DateFormat('HH:mm').format(DateTime.parse(task['start_time'])) +
                                      ' - ' +
                                      DateFormat('HH:mm').format(DateTime.parse(task['end_time'])), style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),

                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isCompleted = !isCompleted;
                                  if (isCompleted) {
                                    UpdateTaskStatusToCompleted(task['_id']);
                                  } else {
                                    UpdateTaskStatusToPending(task['_id']);
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(int.parse('0xFF${task['color']['color'].substring(1)}')),// Màu nền của nút là màu xanh
                                foregroundColor: Colors.white, // Màu chữ là màu trắng
                              ),
                              child: Text(
                                task['status'],
                                style: TextStyle(
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
        ),
      ],
    );
  }
}




