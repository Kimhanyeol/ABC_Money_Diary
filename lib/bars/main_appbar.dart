import 'package:flutter/material.dart';

//스테이터스바 불투명하게 만들기 위해 임포트
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({super.key});

  late String diaryMonth;
  DateTime selectedDate = DateTime.now();

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}

class _MainAppBarState extends State<MainAppBar> {
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

      leadingWidth: double.infinity,
      leading: Row(
        children: [
          IconButton(
              onPressed: onTapLeftChevron,
              icon: Icon(
                Icons.chevron_left_outlined,
                color: Colors.white,
              )),
          TextButton(
            onPressed: () => DatePicker.showSimpleDatePicker(
              context,
              initialDate: widget.selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2090),
              dateFormat: "yyyy년-MMMM",
              locale: DateTimePickerLocale.ko,
              looping: false,
              cancelText: '취소',
              confirmText: '확인',
            ).then((date) {
              if (date != null) {
                setState(() {
                  widget.selectedDate = date;
                  widget.diaryMonth =
                      DateFormat('yyyy-MM-dd').format(widget.selectedDate);
                });
              }
            }),
            child: Text(
              getTimeNow(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: "Yeongdeok-Sea",
              ),
            ),
          ),
          IconButton(
              onPressed: onTapRightChevron,
              icon: Icon(
                Icons.chevron_right_outlined,
                color: Colors.white,
              )),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => Fluttertoast.showToast(
            msg: widget.diaryMonth,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent,
            fontSize: 20,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          ),
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

  void update() {
    setState(() {});
  }

  String getTimeNow() {
    widget.diaryMonth = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    return DateFormat('yyyy 년 MM 월').format(widget.selectedDate);
  }

  void onTapLeftChevron() {
    widget.selectedDate =
        DateTime(widget.selectedDate.year, widget.selectedDate.month - 1);
    widget.diaryMonth = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

    update();
  }

  void onTapRightChevron() {
    widget.selectedDate =
        DateTime(widget.selectedDate.year, widget.selectedDate.month + 1);
    widget.diaryMonth = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
    update();
  }
}
