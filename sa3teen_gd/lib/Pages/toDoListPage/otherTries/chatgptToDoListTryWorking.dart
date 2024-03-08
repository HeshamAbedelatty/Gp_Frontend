import 'package:flutter/material.dart';

class ToDoListClass {
  final String taskName;
  final String date;
  final int color;
  ToDoListClass({
    required this.taskName,
    required this.date,
    required this.color,
  });
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDoListClass> tasks = [];

  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  // Function to add task
  void addTask() {
    setState(() {
      tasks.add(ToDoListClass(
        taskName: taskNameController.text,
        date: dateController.text,
        color: int.parse(colorController.text),
      ));
      taskNameController.clear();
      dateController.clear();
      colorController.clear();
    });
  }

  // // Function to edit task
  // void editTask(int index) {
  //   setState(() {
  //     tasks[index] = ToDoListClass(
  //       taskName: taskNameController.text,
  //       date: dateController.text,
  //       color: int.parse(colorController.text),
  //     );
  //     taskNameController.clear();
  //     dateController.clear();
  //     colorController.clear();
  //   });
  // }

  // Function to delete task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].taskName),
            subtitle: Text(tasks[index].date),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(labelText: 'Task Name'),
                    ),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(labelText: 'Due Date'),
                    ),
                    TextField(
                      controller: colorController,
                      decoration: InputDecoration(labelText: 'Color'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addTask();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ToDoListScreen(),
  ));
}

















// //////////////////////////////////////////
// ///import 'package:flutter/material.dart';

// class ToDoListClass {
//   final String taskName;
//   final String date;
//   final int color;
//   ToDoListClass({
//     required this.taskName,
//     required this.date,
//     required this.color,
//   });
// }

// class ToDoListScreen extends StatefulWidget {
//   @override
//   _ToDoListScreenState createState() => _ToDoListScreenState();
// }

// class _ToDoListScreenState extends State<ToDoListScreen> {
//   List<ToDoListClass> tasks = [];

//   TextEditingController taskNameController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController colorController = TextEditingController();

//   // Function to add task
//   void addTask() {
//     setState(() {
//       tasks.add(ToDoListClass(
//         taskName: taskNameController.text,
//         date: dateController.text,
//         color: int.parse(colorController.text),
//       ));
//       taskNameController.clear();
//       dateController.clear();
//       colorController.clear();
//     });
//   }

//   // // Function to edit task
//   // void editTask(int index) {
//   //   setState(() {
//   //     tasks[index] = ToDoListClass(
//   //       taskName: taskNameController.text,
//   //       date: dateController.text,
//   //       color: int.parse(colorController.text),
//   //     );
//   //     taskNameController.clear();
//   //     dateController.clear();
//   //     colorController.clear();
//   //   });
//   // }

//   // Function to delete task
//   void deleteTask(int index) {
//     setState(() {
//       tasks.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To Do List'),
//       ),
//       body: ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(tasks[index].taskName),
//             subtitle: Text(tasks[index].date),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => deleteTask(index),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text('Add Task'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     TextField(
//                       controller: taskNameController,
//                       decoration: InputDecoration(labelText: 'Task Name'),
//                     ),
//                     TextField(
//                       controller: dateController,
//                       decoration: InputDecoration(labelText: 'Due Date'),
//                     ),
//                     TextField(
//                       controller: colorController,
//                       decoration: InputDecoration(labelText: 'Color'),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       addTask();
//                       Navigator.pop(context);
//                     },
//                     child: Text('Add'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ToDoListScreen(),
//   ));
// }
