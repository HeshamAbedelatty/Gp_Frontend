// import 'package:flutter/material.dart';
// // [
// // ('Low', 'Low'),
// // ('Medium', 'Medium'),
// // ('High', 'High'),
// // ]
// class PriorityIcon extends StatefulWidget {
//   final String priorityValue;
//   const PriorityIcon({super.key, required this.priorityValue});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _PriorityIconState createState() => _PriorityIconState();
// }
//
// class _PriorityIconState extends State<PriorityIcon> {
//   late Priority priority;
//
//   @override
//   void initState() {
//     super.initState();
//     _setPriority(widget.priorityValue);
//   }
//
//   void _setPriority(String priorityValue) {
//     switch (priorityValue) {
//       case 'High':
//         priority = Priority.high;
//         break;
//       case 'Medium':
//         priority = Priority.normal;
//         break;
//       case 'Low':
//         priority = Priority.low;
//         break;
//       default:
//         priority = Priority.normal;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<Priority>(
//       onSelected: (Priority value) {
//         setState(() {
//           priority = value;
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
//             title: Text('Medium Priority'),
//
//           ),
//         ),
//         const PopupMenuItem(
//           value: Priority.low,
//           child: ListTile(
//             leading: Icon(Icons.flag, color: Colors.green),
//             title: Text('Low Priority'),
//
//           ),
//         ),
//       ],
//       child: IconButton(
//         onPressed: null, // Set to null because PopupMenuButton handles tap itself
//         icon: Icon(
//           Icons.flag,
//           color: priority == Priority.high
//               ? Colors.red
//               : priority == Priority.normal
//               ? Colors.yellow
//               : Colors.green,
//         ),
//       ),
//     );
//
//   }
// }
//
// enum Priority { high, normal, low }















import 'package:flutter/material.dart';
import 'package:gp_screen/Services/API_services.dart'; // Adjust the import path as needed

class PriorityIcon extends StatefulWidget {
  final String priorityValue;
 final int listIndex ;
 final int taskIndex ;
  const PriorityIcon({Key? key, required this.priorityValue, required this.listIndex, required this.taskIndex}) : super(key: key);

  @override
  _PriorityIconState createState() => _PriorityIconState();

}

class _PriorityIconState extends State<PriorityIcon> {
  late Priority priority;
  Api_services api_services = Api_services();


  @override
  void initState() {
    super.initState();
    _setPriority(widget.priorityValue);

  }

  void _setPriority(String priorityValue) {
    switch (priorityValue) {
      case 'High':
        priority = Priority.high;
        break;
      case 'Medium':
        priority = Priority.normal;
        break;
      case 'Low':
        priority = Priority.low;
        break;
      default:
        priority = Priority.normal;
    }
  }

  // Method to determine priority based on color (to be implemented)
  Priority _determinePriorityByColor() {
    // Implement logic to determine Priority based on color here
    return Priority.high; // Example implementation
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Priority>(
      onSelected: (Priority value) {
        setState(() {
          priority = value;
          // Call API service to update task priority here
          // ely na2s eny ageep el list w el task mn el parent widget
          Api_services.updateTaskPriority(
            widget.listIndex,
            widget.taskIndex,
            _convertPriorityToString(value), // Convert Priority to string if needed
            accessToken,
          );
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
            title: Text('Medium Priority'),
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
      child: IconButton(
        onPressed: null, // Set to null because PopupMenuButton handles tap itself
        icon: Icon(
          Icons.flag,
          color: priority == Priority.high
              ? Colors.red
              : priority == Priority.normal
              ? Colors.yellow
              : Colors.green,
        ),
      ),
    );
  }
}

// Define your Priority enum
enum Priority { high, normal, low }

// Convert Priority enum to String if needed
String _convertPriorityToString(Priority priority) {
  switch (priority) {
    case Priority.high:
      return 'High';
    case Priority.normal:
      return 'Medium';
    case Priority.low:
      return 'Low';
    default:
      return 'Medium';
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

//
// flag
//
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
//
//
//
//
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