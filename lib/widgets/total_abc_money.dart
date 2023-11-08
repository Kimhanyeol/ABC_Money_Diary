import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/sql_diary_crud_repository.dart';

class TotalAbcMoney extends StatelessWidget {
  final String diaryMonth;

  const TotalAbcMoney({super.key, required this.diaryMonth});

  //A 합 가져오기
  Future<String> _loadTotalMoneyA() async {
    return await SqlDiaryCrudRepository.getTotalMoneyA(diaryMonth);
  }

  //B 합 가져오기
  Future<String> _loadTotalMoneyB() async {
    return await SqlDiaryCrudRepository.getTotalMoneyB(diaryMonth);
  }

  //C 합 가져오기
  Future<String> _loadTotalMoneyC() async {
    return await SqlDiaryCrudRepository.getTotalMoneyC(diaryMonth);
  }

  @override
  Widget build(BuildContext context) {

    //돈 3글자마다 ',' 넣어주기
    String moneyToCleanString(String money){
      int temp = int.parse(money);
      String result = NumberFormat.decimalPattern('ko_KR').format(temp);
      return result;
    }
    
    return Container(
      padding: EdgeInsets.all(2), //ABC 칸 밑에 회색 음영 주는 부분
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
            child: FutureBuilder(
              future: _loadTotalMoneyA(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Not Support Sqflite'),
                  );
                }
                if (snapshot.hasData) {
                  var datas = snapshot.data;
                  return Container(
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
                        Text(moneyToCleanString(datas!),
                            style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w600,
                            )),
                      ],
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

          // B 항목 금액
          Flexible(
            flex: 1,
            child: FutureBuilder(
              future: _loadTotalMoneyB(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Not Support Sqflite'),
                  );
                }
                if (snapshot.hasData) {
                  var datas = snapshot.data;
                  return Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'B',
                          style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w500),
                        ),
                        Text(moneyToCleanString(datas!),
                            style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w600,
                            )),
                      ],
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

          // C 항목 금액
          Flexible(
            flex: 1,
            child: FutureBuilder(
              future: _loadTotalMoneyC(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Not Support Sqflite'),
                  );
                }
                if (snapshot.hasData) {
                  var datas = snapshot.data;
                  return Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'C',
                          style: TextStyle(
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w500),
                        ),
                        Text(moneyToCleanString(datas!),
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Yeongdeok-Sea",
                              fontWeight: FontWeight.w600,
                            )),
                      ],
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

        ],
      ),
    );
    
  }
}
