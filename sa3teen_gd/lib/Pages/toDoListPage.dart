import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/ListViewforTasks.dart';
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
        body:const Column(
          children: [
            Flexible(
              child: customAppBar(),
            ),
            //customAppBar(),
            Expanded(child: ListViewforTasks())
          ],
        ),
      ),
    );
  }
}
