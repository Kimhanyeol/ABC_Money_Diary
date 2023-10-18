// 홈 화면에 있는 가계부 객체 중 하나를 클릭하면 그 객체의 자세한 내용들을 확인하는 디테일 화면

import 'package:abc_money_diary/models/diary_model.dart';
import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:flutter/material.dart';

class DayDiaryScreenBig extends StatefulWidget {
  final Diary diary;

  const DayDiaryScreenBig({super.key, required this.diary});

  @override
  State<DayDiaryScreenBig> createState() => _DayDiaryScreenBigState();
}

class _DayDiaryScreenBigState extends State<DayDiaryScreenBig> {
  Future<Diary?> _loadDiaryOne() async {
    return SqlDiaryCrudRepository.getDiaryOne(widget.diary.id!);
  }




  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
