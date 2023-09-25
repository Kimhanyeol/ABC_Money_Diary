import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class WriteDiaryScreen extends StatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  State<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends State<WriteDiaryScreen> {
  // ABC 선택 관련 변수
  bool aButton = false;
  bool bButton = false;
  bool cButton = false;
  late List<bool> isSelected;

  //날짜 선택 관련 변수
  String selectedDate = "";

  // 기본 오늘 날짜 구하는 곳
  String getToday() {
    if (selectedDate == "") {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyy-MM-dd (E)', 'ko');
      String Today = formatter.format(now);
      return Today;
    }
    return selectedDate;
  }

  // 날짜 클릭 시 선택 화면 나오게 만드는 곳
  Future onTapDateButton(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      //날짜 선택 부분의 색깔 등등 테마 설정부분
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
            ),
            child: child!);
      },
    );
    if (selected != null) {
      setState(() {
        selectedDate = (DateFormat('yyyy-MM-dd (E)', 'ko')).format(selected);
      });
    }
  }

  //시간 선택 관련 변수
  String selectedTime = "";

  // 기본 지금 시간 구하는 곳
  String getTimeNow() {
    if (selectedTime == "") {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('a HH:mm', 'ko');
      String NowTime = formatter.format(now);
      return NowTime;
    }
    return selectedTime;
  }

  // 시간 클릭 시 선택 화면 나오게 만드는 곳
  Future onTapTimeButton(BuildContext context) async {
    TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: Colors.orange,
            )),
            child: child!);
      },
    );

    if (selected != null) {
      setState(() {
        if (selected.hour < 12) {
          selectedTime = '오전 ${selected.hourOfPeriod}:${selected.minute}';
        } else {
          selectedTime = '오후 ${selected.hourOfPeriod}:${selected.minute}';
        }
      });
    }
  }

  @override
  void initState() {
    isSelected = [aButton, bButton, cButton];
    super.initState();
  }

  //ABC 버튼 선택
  void onTapToggleButton(index) {
    if (index == 0) {
      aButton = true;
      bButton = false;
      cButton = false;
    } else if (index == 1) {
      aButton = false;
      bButton = true;
      cButton = false;
    }
    if (index == 2) {
      aButton = false;
      bButton = false;
      cButton = true;
    }
    setState(() {
      isSelected = [aButton, bButton, cButton];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //스테이터스바 투명하게 만드는 부분
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.orange,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        //앱바 높이
        toolbarHeight: 70,
        //글자 색
        foregroundColor: Colors.white,
        //앱 바 색
        backgroundColor: Colors.orange,
        //앱 바 밑에 음영 사라지게 만드는 코드
        elevation: 2,
        //타이틀 왼쪽에 딱 붙이는 코드
        titleSpacing: 0,

        title: Text(
          '가계부 작성',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Yeongdeok-Sea",
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: null,
            icon: Icon(
              Icons.help,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //ABC 선택하는 부분
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: ToggleButtons(
              renderBorder: false,
              fillColor: Colors.orange,
              //선택한 버튼의 배경색
              color: Colors.white.withOpacity(0.6),
              //기본 버튼들의 글자색
              selectedColor: Colors.white,
              //선택한 버튼의 글자색
              splashColor: Colors.white30,
              //터치 이펙트 색
              isSelected: isSelected,
              onPressed: onTapToggleButton,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text(
                    'A',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: "ABCdiary",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text(
                    'B',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: "ABCdiary",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text(
                    'C',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: "ABCdiary",
                    ),
                  ),
                ),
              ],
            ),
          ),

          //날짜 선택하는 부분
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '날짜',
                  style: TextStyle(
                    fontFamily: "HakgyoansimWoojuR",
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey),

                //날짜선택
                TextButton(
                  onPressed: () => onTapDateButton(context),
                  child: Text(
                    getToday(),
                    style: TextStyle(
                      //decoration: TextDecoration.underline,
                      //fontFamily: "HakgyoansimWoojuR",
                      fontSize: 18,
                      //fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                ),

                //시간선택
                TextButton(
                  onPressed: () => onTapTimeButton(context),
                  child: Text(
                    getTimeNow(),
                    style: TextStyle(
                      //decoration: TextDecoration.underline,
                      //fontFamily: "HakgyoansimWoojuR",
                      fontSize: 15,
                      //fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '분류',
                  style: TextStyle(
                    fontFamily: "HakgyoansimWoojuR",
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey),



              ],
            ),
          )
        ],
      ),
    );
  }
}
