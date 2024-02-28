import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';
import 'package:sa3teen_gd/widgets/customAppBar.dart';

class toDoListPage extends StatelessWidget {
  toDoListPage();
  static String id = "ToDoList";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: KPrimaryColour,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            customAppBar(),
            Container(
              width: 300,
              height: 300,
              color: KPrimaryColourGreen,),

          ],
        ),
      ),
    );
  }
}
