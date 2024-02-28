import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/ListViewforTasks.dart';
import 'package:sa3teen_gd/widgets/constants.dart';
import 'package:sa3teen_gd/widgets/customAppBar.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage();
  static String id = "ToDoList";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: KPrimaryColour,
        body: Column(
          children: [
            const Flexible(
              child: customAppBar(),
            ),
            const Expanded(child: ListViewforTasks()),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: KPrimaryColourGreen,
            ),
          ],
        ),
      ),
    );
  }
}
