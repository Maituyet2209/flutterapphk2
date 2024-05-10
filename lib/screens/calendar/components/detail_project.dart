import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class detailsProject extends StatelessWidget {
  const detailsProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
      ),
      body: SfCalendar(

      ),
    );
  }
}
