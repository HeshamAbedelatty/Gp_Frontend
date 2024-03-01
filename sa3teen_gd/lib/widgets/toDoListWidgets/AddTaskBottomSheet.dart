import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/addTaskForm.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet(
      {super.key}); //M4 3RFA EHH LAZMTHA BS 34AN T4IL L WARNING

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const SingleChildScrollView(
        child: AddTaskForm(),
      ),
    );
  }
}
