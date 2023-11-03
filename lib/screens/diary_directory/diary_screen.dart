//홈 화면 중 다이어리 칸


import 'dart:convert';
import 'dart:ffi';

import 'package:abc_money_diary/models/diary_model.dart';
import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:abc_money_diary/screens/diary_directory/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../widgets/day_diary_widget.dart';
import '../../widgets/total_abc_money.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  void update() => setState(() {});

  //하단에 + 버튼 클릭시 이벤트
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
  Future<List<Diary>> _loadDiaryList() async {
    return await SqlDiaryCrudRepository.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ABC 항목 별 금액 표시해주는 곳
          TotalAbcMoney(),

          //가계부 리스트들
          Expanded(
            child: FutureBuilder<List<Diary>>(
              future: _loadDiaryList(),
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

  String moneyToString(int money) => NumberFormat.decimalPattern('ko_KR').format(money);

  String addMoney(int addVal, String abc){
    if( abc == "" ) {
      abc = moneyToString(addVal);
    } else{
      int newVal = int.parse(abc.replaceAll(',', '')) + addVal;
      abc = moneyToString(newVal);
    }

    return abc;
  }

  int moneyToInt(String money){
    if(money == "") {
      money = "0";
    }
    int result = int.parse(money.replaceAll(',', ''));
    return result;
  }



}

