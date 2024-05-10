import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class calendarWidget extends StatefulWidget {
  const calendarWidget({super.key});

  @override
  State<calendarWidget> createState() => _calendarWidgetState();
}

class _calendarWidgetState extends State<calendarWidget> {


  @override
  Widget build(BuildContext context) {
    return SfCalendar(

    );
  }
}
