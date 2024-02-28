import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';
import 'package:sa3teen_gd/widgets/customAppBar.dart';
import 'package:sa3teen_gd/widgets/taskItems.dart';

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
          children: const[
            customAppBar(),
            SizedBox(height: 30),
            taskItem(),
            taskItem(),
            taskItem(),
            taskItem(),
            taskItem(),
            // Container(
            //   width: 300,
            //   height: 300,
            //   color: KPrimaryColourGreen,
            // ),
          ],
        ),
      ),
    );
  }
}
