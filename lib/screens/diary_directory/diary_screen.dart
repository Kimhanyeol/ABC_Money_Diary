//홈 화면 중 다이어리 칸

import 'package:abc_money_diary/models/diary_model.dart';
import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:abc_money_diary/screens/diary_directory/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'day_diary_widget.dart';
import '../../widgets/total_abc_money.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
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

          //가계부 리스트들
          Expanded(
            child: FutureBuilder<List<Diary>>(
              future: _loadDiaryList(diaryMonth),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Not Support Sqflite'),
                  );
                }

                if (snapshot.hasData) {
                  var datas = snapshot.data;
                  return GroupedListView(
                    elements: datas!,
                    groupBy: (element) => element.date,
                    order: GroupedListOrder.DESC,
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, element) => DayDiaryWidget(diary: element),
                    //그룹 헤더 디자인부분
                    groupSeparatorBuilder: (value) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Divider(
                              thickness: 2,
                              color: Colors.orange,
                            ),
                            Text(
                              value!,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Yeongdeok-Sea",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),

      //가계부 작성화면으로 이동하는 플로팅버튼 부분
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapWriteDiaryButton,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.orange,
          size: 40,
        ),
      ),
    );
  }

  //setState 간단하게 update로 만들어둔 곳
  void update() => setState(() {});

  //하단에 + 플로팅버튼 클릭시 이벤트
  Future _onTapWriteDiaryButton() {
    //바텀시트 상세설정은 메인화면에 theme에서 설정했음
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 635,
          child: WriteDiaryScreen(),
        );
      },
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ).then((value) => update());
  }

  //한달치 가계부 목록 가져오기
  Future<List<Diary>> _loadDiaryList(String month) async {
    return await SqlDiaryCrudRepository.getMonthList(month);
  }

  //ABC 금액들 보여줄 때 작동하는 부분들
  String moneyToString(int money) =>
      NumberFormat.decimalPattern('ko_KR').format(money);

  //앱바 날짜 바꿀 때 작동하는 부분들
  String getTimeNow() {
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);
    return DateFormat('yyyy 년 MM 월').format(selectedDate);
  }

  void onTapLeftChevron() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);

    update();
  }

  void onTapRightChevron() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    diaryMonth = DateFormat('yyyy-MM-dd').format(selectedDate);
    update();
  }
}

