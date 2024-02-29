import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/biuldBorder.dart';

class AddTaskBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              cursorColor: KPrimaryColourGreen,
              //style: Color(KPrimaryColourBrown),
              decoration: InputDecoration(
                enabledBorder: biuldBorder(),
                focusedBorder: biuldBorder(KPrimaryColourGreen),
                hintText: 'Enter task title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              //maxLines: 5,
              cursorColor: KPrimaryColourGreen,
              //style: Color(KPrimaryColourBrown),
              decoration: InputDecoration(
                enabledBorder: biuldBorder(),
                focusedBorder: biuldBorder(KPrimaryColourGreen),
                hintText: 'Enter due date',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () {
                  // Implement your add task logic here
                },
                child: const Text('Add Task'),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 48),
                    primary: Color(0xFF3C8243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ))),
          ],
        ),
      ),
    );
  }
}


