import 'package:abc_money_diary/widgets/pair.dart';
import 'package:flutter/material.dart';

class ListCategoryWidget extends StatefulWidget {
  final List<Pair> categoryMoney;
  final Map<String, String> categoryMap;

  const ListCategoryWidget({super.key, required this.categoryMoney, required this.categoryMap});

  @override
  State<ListCategoryWidget> createState() => _ListCategoryWidgetState();
}

class _ListCategoryWidgetState extends State<ListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.white,
        child: Text('리스트 목록 나열할 곳'),
      ),
    );
  }
}
