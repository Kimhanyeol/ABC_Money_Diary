import 'package:flutter/material.dart';

import '../models/diary_model.dart';

class DayDiaryWidet extends StatelessWidget {
  final Diary diary;

  const DayDiaryWidet({
    super.key, required this.diary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //가계부 테두리랑 뒤에 그림자 효과 등등
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.orange,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            //날짜 및 c항목 금액 표시하는 곳
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  diary.date!,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Yeongdeok-Sea",
                  ),
                ),
                Text('C항목 ${diary.money}',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Yeongdeok-Sea",
                    )),
              ],
            ),

            //경계선
            Divider(
              thickness: 2,
              height: 5,
              color: Colors.orange,
            ),

            //각 지출들을 날짜 별로 출력하는 곳
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(diary.type!),
                  Text(diary.time!),
                  Text(diary.contents!),
                  Text(diary.money!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}