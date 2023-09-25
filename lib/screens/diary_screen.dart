import 'package:abc_money_diary/screens/write_diary_screen.dart';
import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {


  Future _onTapWriteDiaryButton() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteDiaryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('가계부 화면')),



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
