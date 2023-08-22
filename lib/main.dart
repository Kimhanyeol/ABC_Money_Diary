import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(),

          body: ListView(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.person, size: 60,),
                    ),

                    Expanded(
                      flex: 9,
                      child: Text('홍길동', style: TextStyle(fontSize: 30, ),),
                    ),

                  ],
                ),
              ),

              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.person, size: 60,),
                    ),

                    Expanded(
                      flex: 9,
                      child: Text('홍길동', style: TextStyle(fontSize: 30, ),),
                    ),

                  ],
                ),
              ),

              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.person, size: 60,),
                    ),

                    Expanded(
                      flex: 9,
                      child: Text('홍길동', style: TextStyle(fontSize: 30, ),),
                    ),

                  ],
                ),
              ),
            ],
          ),

          bottomNavigationBar: BottomWidget(),
        )
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.phone),
          Icon(Icons.message),
          Icon(Icons.notifications),
        ],
      ),
    );
  }
}


class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text('안녕'),
    );
  }
}
