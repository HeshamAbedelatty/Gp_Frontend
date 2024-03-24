// ignore: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/toDoListPage/ToDoListFinal.dart';
import 'package:gp_screen/Pages/toDoListPage/todorefactored_notdone.dart';

enum Priority { high, normal, low }

class PriorityIcon extends StatefulWidget {
  final Task task; // Pass Task object to PriorityIcon

  const PriorityIcon({super.key, required this.task});

  @override
  // ignore: library_private_types_in_public_api
  _PriorityIconState createState() => _PriorityIconState();
}

class _PriorityIconState extends State<PriorityIcon> {
  List<ToDoListClass> toDoLists = [];
  Priority priority = Priority.normal; // Default priority
  @override
  void initState() {
    super.initState();
    priority = widget.task.priority; // Initialize priority from Task object
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Priority>(
      onSelected: (Priority value) {
        setState(() {
          priority = value;
          widget.task.priority = value;
          // toDoLists[listIndex].tasks[taskIndex].priority = value!;
        });
      },

      itemBuilder: (BuildContext context) => <PopupMenuEntry<Priority>>[
        const PopupMenuItem(
          value: Priority.high,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.red),
            title: Text('High Priority'),
          ),
        ),
        const PopupMenuItem(
          value: Priority.normal,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.yellow),
            title: Text('Normal Priority'),
          ),
        ),
        const PopupMenuItem(
          value: Priority.low,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.green),
            title: Text('Low Priority'),
          ),
        ),
      ],
      child: Icon(
        Icons.flag,
        color: priority == Priority.high
            ? Colors.red
            : priority == Priority.normal
                ? Colors.yellow
                : Colors.green,
      ),
      // Icon(Icons.keyboard_arrow_down),
    );
  }
}
