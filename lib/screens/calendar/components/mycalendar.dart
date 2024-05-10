import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:todolistproject/screens/home/components/task_card.dart';
import '../../../config.dart';

class MyCalendar extends StatefulWidget {
  final token;

  const MyCalendar({@required this.token, Key? key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late String userId;
  List<dynamic>? items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    GetUserTasksByDate(userId, DateTime.now());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.index == 0) {
        _calendarFormat = CalendarFormat.week;
      } else {
        _calendarFormat = CalendarFormat.month;
      }
    });
  }

  void GetUserTasksByDate(userId, DateTime date) async {
    var regBody = {"userId": userId, "date": date.toIso8601String()};
    var response = await http.post(
      Uri.parse(getUserTasksByDate),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        items = jsonResponse['success']; // cập nhật danh sách nhiệm vụ
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: TabBar(
            splashBorderRadius: BorderRadius.circular(10),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            dividerColor: Colors.transparent,
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Week'),
              Tab(text: 'Month'),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5.0,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 01, 01),
                  lastDay: DateTime.utc(2025, 01, 01),
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    GetUserTasksByDate(userId, selectedDay);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  headerVisible: true,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  ? items!.isNotEmpty
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
                                      //deleteItem('${task['_id']});
                                    },
                                  ),
                                ],
                              ),
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Color(int.parse(
                                    '0xFF${task['color']['color'].substring(1)}')),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        task['title'] ?? 'No title',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Readex',
                                        ),
                                      ),
                                      //SizedBox(height: 5.0),
                                      Text(
                                        task['note'] ?? 'No note',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                        DateTime.parse(task[
                                                            'start_time'])) +
                                                    ' - ' +
                                                    DateFormat('HH:mm').format(
                                                        DateTime.parse(
                                                            task['end_time'])),
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Image.asset("assets/images/splash1.png"),
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
