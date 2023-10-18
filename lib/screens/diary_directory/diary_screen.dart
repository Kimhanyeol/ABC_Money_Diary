//홈 화면 중 다이어리 칸

import 'package:abc_money_diary/models/diary_model.dart';
import 'package:abc_money_diary/repository/sql_diary_crud_repository.dart';
import 'package:abc_money_diary/screens/diary_directory/write_diary_screen.dart';
import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {

  String ABC = '';

  void update() => setState(() {});

  Future _onTapWriteDiaryButton() {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              //상하좌우 어디서 나오는지 고르는거
              var begin = const Offset(-1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) => WriteDiaryScreen())
    ).then((value) => update());
  }

  Widget dayDiaryScreenSmall(Diary diary) {
    return Container(
      width: 30,
      color: Colors.red,
      height: 30,
      padding: EdgeInsets.all(22),
      child: Text('만들어짐'),
    );
  }

  Future<List<Diary>> _loadDiaryList() async {
    return await SqlDiaryCrudRepository.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Diary>>(
        future: _loadDiaryList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Not Support Sqflite'),
            );
          }
          if (snapshot.hasData) {
            var datas = snapshot.data;
            return ListView(
              children: List.generate(datas!.length, (index) => dayDiaryScreenSmall(datas[index])),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
