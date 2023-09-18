import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2023, 01),
      lastDay: DateTime.timestamp(),
      locale: 'ko-KR',
      daysOfWeekHeight: 50,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}
