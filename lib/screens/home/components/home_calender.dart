import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarHome extends StatefulWidget {
  const MyCalendarHome({Key? key, required this.press, required this.onDaySelected}) : super(key: key);
  final VoidCallback press;
  final Function(DateTime day) onDaySelected;

  @override
  State<MyCalendarHome> createState() => _MyCalendarHomeState();
}

class _MyCalendarHomeState extends State<MyCalendarHome> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    void _onDaySelected(DateTime day, DateTime focusedDay) {
      setState(() {
        selectedDate = day;
      });
      widget.onDaySelected(day);
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: TableCalendar(
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            weekendTextStyle: TextStyle(
              color: Colors.red,
            ),
            outsideTextStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          rowHeight: 35,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.arrow_circle_left_rounded, color: Colors.black),
            rightChevronIcon: Icon(Icons.arrow_circle_right_rounded, color: Colors.black),
            headerMargin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.lightBlue[200],
            ),
          ),
          availableGestures: AvailableGestures.all,
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) => isSameDay(day, selectedDate),
          focusedDay: selectedDate,
          firstDay: DateTime.utc(2020, 01, 01),
          lastDay: DateTime.utc(2050, 01, 01),
          rangeStartDay: DateTime.utc(2024, 4, 20),
          rangeEndDay: DateTime.utc(2024, 04, 22),
        ),
      ),
    );
  }
}
