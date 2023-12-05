import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListCategoryScreen extends StatefulWidget {
  final List datas;
  final int sum;

  const ListCategoryScreen(
      {super.key, required this.datas, required this.sum,});

  @override
  State<ListCategoryScreen> createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
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
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    child: Text('${(per).toStringAsFixed(2)}%'),
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
}
