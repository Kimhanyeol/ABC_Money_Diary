import 'dart:math';

import 'package:abc_money_diary/data/advice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EtcScreen extends StatelessWidget {
  const EtcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int randomNumber = Random().nextInt(9);

    return Scaffold(
      appBar: AppBar(
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

        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontFamily: "Yeongdeok-Sea",
            fontWeight: FontWeight.w600),
        title: Text('ABC 가계부'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //돈 사진 부분
            Card(
              child: Image.asset('assets/images/image${randomNumber + 1}.jpg'),
            ),

            //동기부여 글귀 부분
            AspectRatio(
              aspectRatio: randomNumber == 2
                  ? 1.2
                  : randomNumber == 7
                      ? 1
                      : randomNumber == 4
                          ? 0.8
                          : randomNumber == 6
                              ? 0.7
                              : randomNumber == 8
                                  ? 0.7
                                  : randomNumber == 5
                                      ? 1.2
                                      : 1.5,
              child: Card(
                color: Colors.black,
                child: Container(
                  padding: EdgeInsets.all(17),
                  alignment: Alignment.center,
                  child: Advice(num: randomNumber + 1),
                ),
              ),
            ),

            //앱 아이콘 넣을려고 하는데 아직 어떻게 만드는 지 모름
            Card(
              child: Image.asset('assets/images/abc_advice.png'),
            ),
          ],
        ),
      ),
    );
  }
}
