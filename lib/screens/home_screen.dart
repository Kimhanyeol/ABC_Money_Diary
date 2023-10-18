import 'package:abc_money_diary/bars/main_appbar.dart';
import 'package:abc_money_diary/screens/calendar_screen.dart';
import 'package:abc_money_diary/screens/diary_directory/diary_screen.dart';
import 'package:abc_money_diary/screens/etc_screen.dart';
import 'package:abc_money_diary/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:abc_money_diary/screens/diary_directory/write_diary_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),

      body:Center(
        child: body_item.elementAt(selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (int index) {

          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: '가계부',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: '더보기',
          ),
        ],
      ),
    );
  }
}

List body_item = [
  DiaryScreen(),
  CalendarScreen(),
  StatisticScreen(),
  EtcScreen(),
];
