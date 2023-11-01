import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//스테이터스바 불투명하게 만들기 위해 임포트
import 'package:flutter/services.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({super.key});

  final String Month = DateFormat('yyyy년 MM월').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //스테이터스바 투명하게 만드는 부분
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.light,

        systemNavigationBarColor: Colors.orange,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      //앱바 높이
      toolbarHeight: 70,
      //글자 색
      foregroundColor: Colors.white,
      //앱 바 색
      backgroundColor: Colors.orange,
      //앱 바 밑에 음영 사라지게 만드는 코드
      elevation: 2,
      title: Text(
        '< 2023 년 10 월 >',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontFamily: "Yeongdeok-Sea",
        ),
      ),
      actions: [
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.question_answer_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20),
          onPressed: null,
          icon: Icon(
            Icons.help_outline,
            size: 30,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
