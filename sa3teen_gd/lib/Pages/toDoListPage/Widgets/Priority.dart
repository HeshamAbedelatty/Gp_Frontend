
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/toDoListPage/ThePage/tryingToChange(didnotWork)/ToDoListFinal%20copy.dart';
import 'package:gp_screen/Pages/toDoListPage/ThePage/ToDoListFinal.dart';
import 'package:gp_screen/Pages/toDoListPage/ThePage/todorefactored_notdone.dart';

import '../otherTries/chatgptToDoListTryWorking.dart';

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
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/toDoListPage/ThePage/tryingToChange(didnotWork)/ToDoListFinal%20copy.dart';
// import 'package:gp_screen/Pages/toDoListPage/ThePage/ToDoListFinal.dart';
// import 'package:gp_screen/Pages/toDoListPage/ThePage/todorefactored_notdone.dart';
//
// enum Priority { high, normal, low }
//
// class PriorityIcon extends StatefulWidget {
//   final Task task;
//   final Function(Priority) onPriorityChanged; // Callback function
//
//   const PriorityIcon({super.key, required this.task, required this.onPriorityChanged});
//
//   @override
//   _PriorityIconState createState() => _PriorityIconState();
// }
//
// class _PriorityIconState extends State<PriorityIcon> {
//   Priority priority = Priority.normal;
//
//   @override
//   void initState() {
//     super.initState();
//     priority = widget.task.priority;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<Priority>(
//       onSelected: (Priority value) {
//         setState(() {
//           priority = value;
//           widget.task.priority = value;
//           widget.onPriorityChanged(value); // Call the callback with the new value
//         });
//       },
//       itemBuilder: (BuildContext context) => <PopupMenuEntry<Priority>>[
//         const PopupMenuItem(
//           value: Priority.high,
//           child: ListTile(
//             leading: Icon(Icons.flag, color: Colors.red),
//             title: Text('High Priority'),
//           ),
//         ),
//         const PopupMenuItem(
//           value: Priority.normal,
//           child: ListTile(
//             leading: Icon(Icons.flag, color: Colors.yellow),
//             title: Text('Normal Priority'),
//           ),
//         ),
//         const PopupMenuItem(
//           value: Priority.low,
//           child: ListTile(
//             leading: Icon(Icons.flag, color: Colors.green),
//             title: Text('Low Priority'),
//           ),
//         ),
//       ],
//       child: Icon(
//         Icons.flag,
//         color: priority == Priority.high
//             ? Colors.red
//             : priority == Priority.normal
//             ? Colors.yellow
//             : Colors.green,
//       ),
//     );
//   }
// }


// flag

// print(
// '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
//
// print(listIndex);
// print(
// '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
// },
// ),
// ),
// ListView.builder(
// shrinkWrap: true,
// //physics: const NeverScrollableScrollPhysics(),
// itemCount: listNameControllers[listIndex]
// ['tasks']
//     .length,
// itemBuilder: (context, taskIndex) {




// return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// ListTile(
// title: Text(
// listNameControllers[listIndex]['tasks'][taskIndex]['title'],
// ),
// trailing: IconButton(
// icon: const Icon(Icons.delete),
// onPressed: () {
// api_services.deleteToDoList(
// listNameControllers[listIndex]['tasks'][taskIndex]['id'],
// accessToken);
// print(
// '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
//
// print(listIndex);
// print(
// '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
// },
// ),
// ),
// ],
// ),
// ),
// ]);
// ***************************************************************