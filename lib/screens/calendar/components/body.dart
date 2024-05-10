// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:todolistproject/screens/calendar/components/syncfusion_calendar.dart';
// import 'package:todolistproject/screens/home/components/home_calender.dart';
// import 'calendar.dart';

// class bodyCalendarScreen extends StatefulWidget {
//   const bodyCalendarScreen({super.key});

//   @override
//   State<bodyCalendarScreen> createState() => _bodyCalendarScreenState();
// }

// class _bodyCalendarScreenState extends State<bodyCalendarScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: myCalendar(),

//       // child: Column(
//       //   children: [
//       //     myCalendar(press: (){}),
//       //
//       //   ],
//       //   body: SfCalendar(
//       //     view: CalendarView.month,
//       //     firstDayOfWeek: 7,
//       //
//       //     dataSource: MeetingDataSource(getAppointments()),
//       //   ),
//       //),
//     );
//   }
// }

// // List<Appointment> getAppointments() {
// //   List<Appointment> meetings = <Appointment>[];
// //   final DateTime today = DateTime.now();
// //   final DateTime startTime =
// //   DateTime(today.year, today.month, today.day, 9, 0, 0);
// //   final DateTime endTime = startTime.add(const Duration(hours: 2));
// //
// //   meetings.add(Appointment(
// //       startTime: startTime,
// //       endTime: endTime,
// //       subject: 'Board Meeting',
// //       color: Colors.blue,
// //       recurrenceRule: 'FREQ=DAILY;COUNT=10',
// //       isAllDay: false));
// //
// //   return meetings;
// // }
// //
// // class MeetingDataSource extends CalendarDataSource {
// //   MeetingDataSource(List<Appointment> source) {
// //     appointments = source;
// //   }
