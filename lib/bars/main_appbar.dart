import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//스테이터스바 불투명하게 만들기 위해 임포트
import 'package:flutter/services.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({super.key});

  String Month = DateFormat('yyyy년 MM월').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //스테이터스바 투명하게 만드는 부분
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.orange,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      //앱바 높이
      toolbarHeight: 70,
      //글자 가운데로
      centerTitle: true,
      //글자 색
      foregroundColor: Colors.white,
      //앱 바 색
      backgroundColor: Colors.orange,
      //앱 바 밑에 음영 사라지게 만드는 코드
      elevation: 2,
      leading: Icon(Icons.chevron_left_rounded),
      title: Text(
        Month,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Icon(Icons.chevron_right_rounded),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
