import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/AddTaskBottomSheet.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/ListViewforTasks.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/customAppBar.dart';

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
            
            BottomAppBar(color: KPrimaryColour,child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    context: context,
                    builder: (context) {
                      return AddTaskBottomSheet();
                    });
              },
              child: Icon(Icons.add),
              backgroundColor: KPrimaryColourGreen,
            ),)
          ],
        ),
      ),
    );
  }
}
