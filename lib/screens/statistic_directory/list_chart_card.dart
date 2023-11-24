import 'package:flutter/material.dart';

import '../../repository/sql_diary_crud_repository.dart';
import '../../widgets/none_information_widget.dart';
import '../../widgets/pair.dart';
import 'list_category_screen.dart';

class ListChartCard extends StatefulWidget {
  final String diaryMonth;
  const ListChartCard({super.key, required this.diaryMonth});

  @override
  State<ListChartCard> createState() => _ListChartCardState();
}

class _ListChartCardState extends State<ListChartCard> {

  List<Pair> categoryMoney = [];
  Map<String, String> categoryMap = {};

  Future<List<Pair>> _getTotalCategory(String month) async {
    List<Pair> newList = await SqlDiaryCrudRepository.getTotalCategory(month);
    categoryMoney = newList;
    return categoryMoney;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getTotalCategory(widget.diaryMonth),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return NoneInformationWidget();
          }

          var datas = snapshot.data!.reversed.toList();

          int sum = 0;
          for (int i = 0; i < datas.length; i++) {
            int money = datas[i].b;
            sum += money;
          }

          return ListCategoryScreen(
            datas: datas,
            sum: sum,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
