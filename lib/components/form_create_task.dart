import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todolistproject/components/input_field.dart';
import 'package:todolistproject/layout/myBottomNavigation.dart';

import '../config.dart';

class createTask extends StatefulWidget {
  final token;
  const createTask({@required this.token,Key? key}) : super(key: key);

  @override
  State<createTask> createState() => _createTaskState();
}

  enum Repeat{None, Daily, Weekly, Monthly}

class _createTaskState extends State<createTask> {
  late String userId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();


  Repeat repeatView = Repeat.None;
  String _selectedRepeat = "None";
  TimeOfDay _notifyTime = TimeOfDay.now();
  String? _notifyDayOfWeek;

  int? _notifyDayOfMonth;


  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(hour: TimeOfDay
      .now()
      .hour + 1, minute: TimeOfDay
      .now()
      .minute);

  List<Map<String, dynamic>> colorList = [];

  int _selectedColor = 0;


  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.Hm().format(time);
  }

  String formatDateTimeForMongo(DateTime dateTime) {
    // Consider using a time zone library for better handling
    return dateTime.toUtc().toIso8601String(); // Convert to UTC and ISO 8601 format
  }

  @override
  void initState() {
    super.initState();
    fetchColors();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }


  void fetchColors() async {
    try {
      final response = await http.get(Uri.parse(getColorList));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          colorList = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to fetch colors');
      }
    } catch (error) {
      print('Error fetching colors: $error');
    }
  }

  void createTask() async {
    if (_titleController.text.isNotEmpty) {
// Calculate timezone offset
      var now = DateTime.now();
      var timeZoneOffset = DateTime.now().timeZoneOffset;  // Get offset from UTC

      // Get current date without time
      var currentDate = DateTime(now.year, now.month, now.day);

      // Create DateTime objects with user-selected time and current date
      var localStartTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _startTime.hour, _startTime.minute);
      var localEndTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _endTime.hour, _endTime.minute);

      // Adjust local times to UTC with offset
      var adjustedStartTime = localStartTime.add(timeZoneOffset);
      var adjustedEndTime = localEndTime.add(timeZoneOffset);

      String startTime = formatDateTimeForMongo(adjustedStartTime);  // Convert to UTC with adjusted time
      String endTime = formatDateTimeForMongo(adjustedEndTime);    // Convert to UTC with adjusted time
      var notificationTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _notifyTime.hour, _notifyTime.minute).add(timeZoneOffset);
      notificationTime = notificationTime.toUtc();
      String notificationTimeString = notificationTime.toIso8601String();
      print(notificationTimeString);

      DateTime localDateTime = _selectedDate;
      DateTime utcDateTime = DateTime.utc(localDateTime.year, localDateTime.month, localDateTime.day);
      String utcIsoString = utcDateTime.toIso8601String();
      print(utcIsoString);
      // Tạo payload
      Map<String, dynamic> regBody = {
        "userId": userId,
        "title": _titleController.text,
        "note": _noteController.text,
        "date": utcIsoString,
        "start_time": startTime,
        "end_time": endTime,
        "repeat": repeatView.toString().split('.').last,
        "notify_time": notificationTimeString,
        "color": colorList[_selectedColor]['_id'],
      };

      // Kiểm tra và thêm các trường optional
      if (_notifyDayOfWeek != null) {
        regBody["notify_day_of_week"] = _notifyDayOfWeek;
      }
      if (_notifyDayOfMonth != null) {
        regBody["notify_day_of_month"] = _notifyDayOfMonth;
      }

      try {
        // Gửi yêu cầu POST tạo task
        var response = await http.post(
          Uri.parse(createPrivateTask),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            // Xóa dữ liệu trong các trường nhập
            _titleController.clear();
            _noteController.clear();
            // Chuyển đến màn hình myBottomNavBar
            Navigator.push(context, MaterialPageRoute(builder: (context) => myBottomNavBar(token: widget.token,)));
          } else {
            print("Something went wrong");
          }
        } else {
          print("Failed to create task. Status code: ${response.statusCode}");
        }
      } catch (error) {
        print("Error creating task: $error");
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Task",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(title: "Title", hint: "Enter your title", controller: _titleController,),
                MyInputField(title: "Note", hint: "Enter your note", controller: _noteController,),
                MyInputField(
                  //controller: _DateController,
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Start Time',
                        hint: formatTimeOfDay(_startTime),
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStarTime: true);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: 'End Time',
                        hint: formatTimeOfDay(_endTime),
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _getTimeFromUser(isStarTime: false);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Repeat", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                Center(
                  child: SegmentedButton<Repeat>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      selectedForegroundColor: Colors.white,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    segments: const <ButtonSegment<Repeat>>[
                      ButtonSegment<Repeat>(
                        value: Repeat.None,
                        label: Text("None", style: TextStyle(fontSize: 10),),
                        //icon: Icon(Icons.filter_none),
                      ),
                      ButtonSegment<Repeat>(
                        value: Repeat.Daily,
                        label: Text("Daily", style: TextStyle(fontSize: 10),),
                        //icon: Icon(Icons.calendar_view_day),
                      ),
                      ButtonSegment<Repeat>(
                        value: Repeat.Weekly,
                        label: Text("Weekly", style: TextStyle(fontSize: 10),),
                        //icon: Icon(Icons.calendar_view_week),
                      ),
                      ButtonSegment<Repeat>(
                        value: Repeat.Monthly,
                        label: Text("Monthly", style: TextStyle(fontSize: 10),),
                        //icon: Icon(Icons.calendar_view_month),
                      ),
                    ],
                    selected: <Repeat>{repeatView},
                    onSelectionChanged: (Set<Repeat> newSelection){
                      setState(() {
                        repeatView = newSelection.first;
                      });
                    },
                  ),
                ),

                if (repeatView == Repeat.Daily)
                  MyInputField(
                    title: 'Time for notification',
                    hint: formatTimeOfDay(_notifyTime),
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _getTimeNotificationFromUser();
                      },
                    ),
                  ),
                if (repeatView == Repeat.Weekly)
                  ...[
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Notify Day of Week'),
                      items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) => setState(() => _notifyDayOfWeek = value!),
                      onSaved: (value) => _notifyDayOfWeek = value!,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyInputField(
                      title: 'Time for notification',
                      hint: formatTimeOfDay(_notifyTime),
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeNotificationFromUser();
                        },
                      ),
                    ),
                  ],
                if (repeatView == Repeat.Monthly)
                  ...[
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(labelText: 'Notify Day of Month'),
                      items: List<int>.generate(31, (i) => i + 1)
                          .map((int value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      ))
                          .toList(),
                      onChanged: (value) => setState(() => _notifyDayOfMonth = value!),
                      onSaved: (value) => _notifyDayOfMonth = value!,
                    ),
                    MyInputField(
                      title: 'Time for notification',
                      hint: formatTimeOfDay(_notifyTime),
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeNotificationFromUser();
                        },
                      ),
                    ),
                  ],

                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _colorPallete(),
                    ElevatedButton(
                      onPressed: () {
                        createTask();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        "Create Task",
                        style: TextStyle(
                          color: Colors.white, // Đặt màu văn bản của button là trắng
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(colorList.length, (int index) {
            final color = colorList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(int.parse(color['color'].substring(1), radix: 16) + 0xFF000000),
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 15,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate!;  // Keep in local time zone
        print("Selected date (local time zone): ${_selectedDate.toIso8601String()}");
      });
    } else {
      print("Something went wrong");
    }
  }

  _getTimeFromUser({required bool isStarTime}) async {
    TimeOfDay? pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStarTime ? _startTime : _endTime,
    );

    if (pickerTime != null) {
      setState(() {
        if (isStarTime) {
          _startTime = pickerTime;
        } else {
          _endTime = pickerTime;
        }
      });
    }
  }

  _getTimeNotificationFromUser() async {
    TimeOfDay? pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _notifyTime, // Đặt giá trị mặc định cho thời gian ban đầu
    );

    if (pickerTime != null) {
      setState(() {
        _notifyTime = pickerTime; // Gán giá trị pickerTime cho _startTime
      });
    }
  }


  _showTimePicker() async {
    TimeOfDay? pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _startTime,
    );

    if (pickerTime != null) {
      setState(() {
        _startTime = pickerTime;
      });
    }
  }

}
