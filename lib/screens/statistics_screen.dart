import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:abc_money_diary/widgets/circle_category_widget.dart';
import 'package:abc_money_diary/widgets/list_category_widget.dart';
import 'package:abc_money_diary/widgets/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widgets/total_abc_money.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late String diaryMonth;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
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
                    initialDate: selectedDate,
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
                        selectedDate = date;
                        diaryMonth =
                            DateFormat('yyyy-MM-dd').format(selectedDate);
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
                  msg: diaryMonth,
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
          ),

          // ABC 항목 별 금액 표시해주는 곳
          TotalAbcMoney(
            diaryMonth: diaryMonth,
          ),

          //통계부분
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 1,),
                  //원형 통계부분
                  FutureBuilder(
                    future: _getTotalCategory(diaryMonth),
                    initialData: [],
                    builder: (context, snapshot) {
                      return CircleCategoryWidget(
                        categoryMap: categoryMap,
                        categoryMoney: categoryMoney,
                      );
                    },
                  ),

                  //표 부분
                  FutureBuilder(
                    future: _getTotalCategory(diaryMonth),
                    initialData: [],
                    builder: (context, snapshot) {
                      return ListCategoryWidget(
                        categoryMap: categoryMap,
                        categoryMoney: categoryMoney,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  //setState 간단하게 update로 만들어둔 곳
  void update() => setState(() {});

  /*-------------------------------------------appbar 관련 부분----------------------------------------------------------------*/

  //왼쪽 화살표
  void onTapLeftChevron() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);

    update();
  }

  //오른쪽 화살표
  void onTapRightChevron() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);
    update();
  }

  //앱바 날짜 바꿀 때 작동하는 부분들
  String getTimeNow() {
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);
    return DateFormat('yyyy 년 MM 월').format(selectedDate);
  }

  //돈 입력 시 3자리마다 , 붙여주는 등 관련 설정
  String moneyToString(int money) => NumberFormat.decimalPattern('ko_KR').format(money);

  /*-------------------------------------------appbar 관련 부분----------------------------------------------------------------*/

  /*----------------------------------------------원형 차트 관련 부분-----------------------------------------------------------*/

  List<Pair> categoryMoney = [];
  Map<String, String> categoryMap = {};

  Future<List<Pair>> _getTotalCategory(String month) async {
    List<Pair> newList = await SqlDiaryCrudRepository.getTotalCategory(month);
    categoryMoney = newList;
    print(categoryMoney.length);
    print("After sort:---------");
    for (int i = 0; i < categoryMoney.length; i++) {
      print("${categoryMoney[i].a} ${categoryMoney[i].b}");
    }
    return categoryMoney;
  }

/*----------------------------------------------원형 차트 관련 부분-----------------------------------------------------------*/

/*----------------------------------------------도표 관련 부분-----------------------------------------------------------*/



}
