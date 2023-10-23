//홈 화면 중 다이어리 칸

import 'package:abc_money_diary/models/diary_model.dart';
import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:abc_money_diary/screens/diary_directory/write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../widgets/day_diary_widget.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  void update() => setState(() {});

  Future _onTapWriteDiaryButton() {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              //상하좌우 어디서 나오는지 고르는거
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.linear;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                WriteDiaryScreen())).then((value) => update());
  }

  //가계부 목록 ui 부분
  Widget dayDiaryScreenSmall(Diary diary) {
    return GestureDetector(
      //가계부 목록 클릭시 상세내용 보여주는 위젯
      onTap: () async {
        return showDialog(
          context: context,
          builder: (context) {
            var data = diary;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),

              content: SizedBox(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${data.type} 타입',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '금액 : ${data.money}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '날짜 : ${data.date}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '시간 : ${data.time}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '분류 : ${data.category}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '내용 : ${data.contents}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '메모 : ${data.memo}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(), child: Text('수정하기')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(), child: Text('삭제하기')),
              ],
            );
          },
        );
      },
      //가계부 목록들
      child: DayDiaryWidet(diary: diary,),
    );
  }

  Future<List<Diary>> _loadDiaryList() async {
    return await SqlDiaryCrudRepository.getList();
  }

  void getABC(String abc) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ABC 항목 별 금액 표시해주는 곳
          Container(
            padding: EdgeInsets.all(2),

            //ABC 칸 밑에 회색 음영 주는 부분
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),

            child: Row(
              children: [
                // A 항목 금액
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'A',
                          style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w500),
                        ),
                        Text('- 8000',
                            style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ),

                // B 항목 금액
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'B',
                          style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w500),
                        ),
                        Text('- 22000',
                            style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ),

                // C 항목 금액
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          'C',
                          style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w500),
                        ),
                        Text('- 50000',
                            style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                    itemBuilder: (context, element) =>
                        dayDiaryScreenSmall(element),
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
                } else {
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
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}

