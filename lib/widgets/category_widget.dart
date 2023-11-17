import 'package:abc_money_diary/theme/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final TextEditingController categoryController;

  const CategoryWidget({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                categoryController.text = category1;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category1,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category2;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category2,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category3;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category3,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category4;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category4,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",fontSize: 15),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                categoryController.text = category5;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category5,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category6;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category6,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category7;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category7,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category8;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category8,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                categoryController.text = category9;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category9,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category10;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category10,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category11;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category11,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {
                categoryController.text = category12;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                category12,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Yeongdeok-Sea",
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
