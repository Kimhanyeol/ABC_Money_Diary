
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  //마크 표시 기능이 되는지 확인하기 위한 임의값, 나중에 지우고 db 받아와야댐
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023,09,13) : [ Event('title'), Event('title2') ],
    DateTime.utc(2023,09,14) : [ Event('title3') ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime(2023, 01),
      lastDay: DateTime.timestamp(),
      locale: 'ko-KR',
      daysOfWeekHeight: 50,

      //이벤트 있는 날짜 달력에 입력
      eventLoader: _getEventsForDay,

      //다른 달 날짜 선택시 그 달로 이동
      pageJumpingEnabled: true,

      //헤더 스타일
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),

      //캘린더 스타일
      calendarStyle: CalendarStyle(

        //오늘 날짜
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 1.5),
        ),
        todayTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),

        //선택 날짜
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 1.5),
        ),
        selectedTextStyle:
        TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),

        //이벤트 있는 날짜
        markerSize: 7,
        markerDecoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        )

      ),

      //날짜 선택 기능
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this.focusedDay = focusedDay;
          this.selectedDay = selectedDay;
        });
      },

      selectedDayPredicate: (DateTime day) {
        return isSameDay(selectedDay, day);
      },

    );
  }
}


class Event {
  String title;

  Event(this.title);
}
