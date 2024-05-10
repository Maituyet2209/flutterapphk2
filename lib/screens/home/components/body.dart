import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/size_config.dart';

import 'bodyHome.dart';
import 'card_task.dart';
import 'greetings.dart';
import 'home_calender.dart';
import 'home_header.dart';

class bodyHomeScreen extends StatelessWidget {
  const bodyHomeScreen({super.key,@required this.token});
  final token;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            HomeHeader(token: token,),
            // myCalendarHome(
            //   press: () {},
            //   Onpress: () {},
            // ),
            //functionOfApp(),
            bodyHome(token: token),
          ],
        ),
    );
  }
}

// class myCalendarHome extends StatefulWidget {
//   const myCalendarHome({Key? key, required this.press, required this.Onpress})
//       : super(key: key);
//   final VoidCallback press;
//   final VoidCallback Onpress;

//   @override
//   State<myCalendarHome> createState() => _myCalendarHomeState();
// }

// class _myCalendarHomeState extends State<myCalendarHome> {
  // DateTime today = DateTime.now();

  // void _onDaySelected(DateTime day, DateTime focusedDay) {
  //   setState(() {
  //     today = day;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.all(10),
  //     child: Container(
  //       child: Column(
  //         children: [
  //           Text(
  //             "Selected Day =" +today.toString().split(" ")[0],
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Container(
  //             decoration: ShapeDecoration(
  //                 shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20),
  //               side: BorderSide(color: kPrimaryColor, width: 2),
  //             )),
  //             child: TableCalendar(
  //               rowHeight: 40,
  //               headerStyle: HeaderStyle(
  //                   titleCentered: true, formatButtonVisible: false),
  //               availableGestures: AvailableGestures.all,
  //               selectedDayPredicate: (day) => isSameDay(day, today),
  //               focusedDay: today,
  //               firstDay: DateTime.utc(2020, 10, 16),
  //               lastDay: DateTime.utc(2030, 3, 14),
  //               onDaySelected: _onDaySelected,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
//}
