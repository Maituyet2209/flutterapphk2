import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolistproject/components/button_show_opt.dart';
import 'package:todolistproject/screens/calendar/components/detail_project.dart';
import 'package:todolistproject/screens/chat/components/avatar.dart';
import 'package:todolistproject/size_config.dart';

import '../../../config.dart';
import '../../../constants.dart';
import 'create_event.dart';
import 'event.dart';

class myCalendar extends StatefulWidget {
  final token;
  const myCalendar({@required this.token, Key? key}) : super(key: key);

  @override
  State<myCalendar> createState() => _myCalendarState();
}

class _myCalendarState extends State<myCalendar> {
  late String userId;
  List<dynamic>? items;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _forcusedDay = DateTime.now();
  late DateTime _selectedDay;

  Map<DateTime, List<Event>> events = {};

  TextEditingController _eventController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    _selectedDay = _forcusedDay;
    _selectedEvent = ValueNotifier(_getEventsForDay(_selectedDay!));
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    GetUserTasksByDate(userId,_selectedDay );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _forcusedDay = focusedDay;
        _selectedEvent.value = _getEventsForDay(selectedDay);
      });
    }
  }

  void GetUserTasksByDate(userId, _selectedDay) async {
    var regBody = {"userId": userId};
    var response = await http.post(
      Uri.parse(getUserTasksByDate),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    var tasks = jsonResponse['success'];

    if (tasks != null) {
      setState(() {});
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
        //GetUserTasksByDate(userId);
      } else {
        print(
            'Error deleting task: ${jsonResponse['message'] ?? 'Unknown error'}');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
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

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Padding(
      padding: EdgeInsets.all(20),
      child: Scaffold(
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2050, 01, 01),
              focusedDay: _forcusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _forcusedDay = focusedDay;
              },
              rowHeight: 35,
              availableGestures: AvailableGestures.all,
            ),
            SizedBox(
              height: 8.0,
            ),
 SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var task = items![index];
                                              var isCompleted = task != null
                                                  ? task['isCompleted'] ?? false
                                                  : false;
                                              return Slidable(
                                                key: Key('${task['_id']}'),
                                                endActionPane: ActionPane(
                                                  motion: ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      backgroundColor:
                                                          Color(0xFFFE4A49),
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: 'Delete',
                                                      onPressed: (BuildContext
                                                          context) {
                                                        deleteItem(
                                                            '${task['_id']}',
                                                            isCompleted);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        blurRadius: 5,
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        task['title'],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                        color: Colors
                                                            .grey.shade200,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.alarm,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                DateFormat('HH:mm').format(
                                                                        DateTime.parse(task[
                                                                            'start_time'])) +
                                                                    ' - ' +
                                                                    DateFormat(
                                                                            'HH:mm')
                                                                        .format(
                                                                            DateTime.parse(task['end_time'])),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ],
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
                              ),
                            ),
          ]
                          )
    )
    );
                        }
                         }
