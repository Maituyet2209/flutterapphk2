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

class CardList extends StatefulWidget {
  final token;
  final DateTime selectedDate;

  const CardList({@required this.token, required this.selectedDate, Key? key}) : super(key: key);
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  late String userId;
  List? items;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getTaskList(userId, widget.selectedDate);
  }

  void getTaskList(userId, DateTime selectedDate) async {
    var formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    var regBody = {"userId": userId, "date": formattedDate};
    var response = await http.post(Uri.parse("getUserPrivateTaskList"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
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
      getTaskList(userId, widget.selectedDate);
    }
  }




  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: items == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ReorderableListView.builder(
          itemCount: items!.length,
          itemBuilder: (context, int index) {
            return ReorderableDragStartListener(
              key: Key('${items![index]['_id']}'),
              index: index,
              child: Column(
                children: [
                  Slidable(
                    key: Key('${items![index]['_id']}'),
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
                            print('${items![index]['_id']}');
                            deleteItem('${items![index]['_id']}');
                          },
                        ),
                      ],
                    ),
                    child: Card(
                       elevation: 5,
                      shadowColor: Color(int.parse(
                          '0xFF${items![index]['color']['color'].substring(1)}')),
                      color: Colors.white,
                      surfaceTintColor: Color(int.parse(
                          '0xFF${items![index]['color']['color'].substring(1)}')),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                    Icons.task_alt_rounded, color: Color(int.parse(
                                    '0xFF${items![index]['color']['color']
                                        .substring(1)}')),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${items![index]['title']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('${items![index]['note']}'),
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: 60,
                              child: Center(
                                child: Icon(Icons.switch_camera),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,), // Add a divider between tasks
                ],
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final item = items!.removeAt(oldIndex);
              items!.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }


  String _formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    return '${hour}:${dateTime.minute} $period';
  }
}
