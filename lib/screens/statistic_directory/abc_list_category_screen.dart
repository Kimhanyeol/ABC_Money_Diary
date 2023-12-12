import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ABCListCategoryScreen extends StatefulWidget {
  final List datas;
  final int sum;

  const ABCListCategoryScreen({
    super.key,
    required this.datas,
    required this.sum,
  });

  @override
  State<ABCListCategoryScreen> createState() => _ABCListCategoryScreenState();
}

class _ABCListCategoryScreenState extends State<ABCListCategoryScreen> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          //표 리스트
          Expanded(
            child: widget.datas.isEmpty ? Center(child: Text('정보가 없습니다'),) : ListView(
              physics: widget.datas.length < 4
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              children: List.generate(
                widget.datas.length,
                (index) {
                  int money = widget.datas[index].b;
                        double per = money == 0 ? 0 : money / widget.sum * 100;

                        return Column(
                          children: [
                            Divider(
                              thickness: 2,
                              color: Colors.black,
                            ),

                            //클릭 시 리스트 나오게 하는 부분
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  //돈 3글자마다 ',' 넣어주기
  String moneyToCleanString(String money) {
    int temp = int.parse(money);
    String result = '${NumberFormat.decimalPattern('ko_KR').format(temp)}원';
    return result;
  }


  void update() => setState(() {});
}
