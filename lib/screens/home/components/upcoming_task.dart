import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import 'detail_task.dart';

class UpcomingTasks extends StatefulWidget {
  final token;
  const UpcomingTasks({@required this.token, Key? key}) : super(key: key);

  @override
  State<UpcomingTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<UpcomingTasks> {
  late String userId;
  List<dynamic>? items;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTaskListUpcoming(userId);
  }

  void getTaskListUpcoming(userId) async {
    var regBody = {"userId": userId};
    var response = await http.post(
      Uri.parse(getUserUpcomingTasks),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      items = jsonResponse['success'];
    });
  }

  void deleteItem(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(deleteTask),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getTaskListUpcoming(userId);
    }
  }

  void detailsTask(id) async {
    var regBody = {"id": id};
    var response = await http.post(Uri.parse(getTaskDetails),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // Truyền thông tin chi tiết của task vào trang DetailTask
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailTask(task: jsonResponse['success'])),
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
            "Upcoming",
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
                        deleteItem('${task['_id']}');
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
                              detailsTask('${task['_id']}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(int.parse('0xFF${task['color']['color'].substring(1)}')),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              "Details",
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

