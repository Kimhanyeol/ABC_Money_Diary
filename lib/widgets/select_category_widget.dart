
import 'package:flutter/material.dart';

import '../data/category.dart';

class SelectCategoryWidget extends StatelessWidget {
  final TextEditingController categoryController;

  const SelectCategoryWidget({super.key, required this.categoryController});

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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                Navigator.pop(context);
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
