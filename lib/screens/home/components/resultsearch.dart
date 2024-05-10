import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:todolistproject/screens/home/components/detail_task.dart';
import '../../../config.dart';
import '../../../constants.dart';

class SearchResultPage extends StatefulWidget {
  final List<dynamic> tasks;

  const SearchResultPage({Key? key, required this.tasks}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
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
        MaterialPageRoute(
            builder: (context) => DetailTask(task: jsonResponse['success'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.orange,
          centerTitle:true,
        title: Text('Search Result', style: TextStyle(fontFamily: "Readex", fontWeight: FontWeight.w700),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.tasks!.length,
          itemBuilder: (BuildContext context, int index) {
            var task = widget.tasks![index];
            return Container(
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
                          Icon(
                            Icons.alarm,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(
                            DateFormat('HH:mm').format(
                                    DateTime.parse(task['start_time'])) +
                                ' - ' +
                                DateFormat('HH:mm')
                                    .format(DateTime.parse(task['end_time'])),
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          detailsTask('${task['_id']}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(int.parse(
                              '0xFF${task['color']['color'].substring(1)}')),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Details",
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
