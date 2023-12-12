import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/diary_model.dart';
import '../../repository/sql_diary_crud_repository.dart';
import '../diary_directory/day_diary_widget.dart';

class ListCategoryScreen extends StatefulWidget {
  final List datas;
  final int sum;

  const ListCategoryScreen(
      {super.key, required this.datas, required this.sum,});

  @override
  State<ListCategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
          elevation: 4,
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                //타이틀
                Container(
                  height: 65,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Total List",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Yeongdeok-Sea"),
                  ),
                ),

                //표 리스트
                Expanded(
                  child: ListView(
                    physics: widget.datas.length < 4 ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
                    children: List.generate(
                      widget.datas.length,
                          (index) {
                        int money = widget.datas[index].b;
                        double per = money == 0 ? 0 :  money / widget.sum * 100;

                        return Column(
                          children: [
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),

                            //클릭 시 리스트 나오게 하는 부분
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black38,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      title: Text(widget.datas[index].a.toString()),
                                      titleTextStyle: TextStyle(
                                          color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
                                      scrollable: true,
                                      surfaceTintColor: Colors.white,
                                      contentPadding: EdgeInsets.all(0),
                                      content: SizedBox(
                                        height: 300,
                                        child: Expanded(
                                          child: FutureBuilder(
                                            future: _loadDiaryList(widget.datas[index].a.toString()),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text('Not Support Sqflite'),
                                                );
                                              }

                                              if (snapshot.hasData) {
                                                var datas = snapshot.data;

                                                //가계부 없는 날 나오는 화면
                                                if (datas!.isEmpty) {
                                                  return Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('정보가 없습니다', style: TextStyle(fontSize: 15)),
                                                      ],
                                                    ),
                                                  );
                                                }

                                                return ListView(
                                                  children: List.generate(
                                                    datas.length,
                                                        (index) => DayDiaryWidget(
                                                      diary: datas[index],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),

                                    );
                                  },
                                );
                                update();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    //% 부분
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.orange,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurStyle: BlurStyle.outer,
                                            blurRadius: 1,
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                          '${(per).toStringAsFixed(2)}%'),
                                    ),

                                    //카테고리명 부분
                                    Text(widget.datas[index].a.toString()),

                                    //금액 부분
                                    Text(
                                      moneyToCleanString(
                                        widget.datas[index].b.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10,)
              ],
            ),
          )
      ),
    );
  }

  //돈 3글자마다 ',' 넣어주기
  String moneyToCleanString(String money) {
    int temp = int.parse(money);
    String result = '${NumberFormat.decimalPattern('ko_KR').format(temp)}원';
    return result;
  }

  Future<List<Diary>> _loadDiaryList(String text) async {
    return await SqlDiaryCrudRepository.getSearchList(text);
  }
}
