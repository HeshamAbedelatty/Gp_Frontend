import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

class ToDoListClass {
  String listName;
  List<Task> tasks;

  ToDoListClass({required this.listName, required this.tasks});
}

class Task {
  String taskName;
  DateTime deadline;
  bool isChecked;

  Task({
    required this.taskName,
    required this.deadline,
    this.isChecked = false,
  });
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDoListClass> toDoLists = [];
  List<TextEditingController> listNameControllers =
      []; // List of controllers for list names

  TextEditingController listNameController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // Add a new controller for editing tasks
  TextEditingController editTaskNameController = TextEditingController();
  TextEditingController editDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Add an initial empty to-do list
    addNewToDoList();
  }

  void addNewToDoList() {
    setState(() {
      toDoLists.add(ToDoListClass(listName: "", tasks: []));
      listNameControllers.add(
          TextEditingController()); // Add a new controller for the new list
      // toDoLists.add(ToDoListClass(listName: "", tasks: []));
    });
  }

  void addTask(int listIndex) {
    setState(() {
      toDoLists[listIndex].tasks.add(Task(
            taskName: taskNameController.text,
            deadline: DateTime.parse(dateController.text),
          ));
      taskNameController.clear();
      dateController.clear();
    });
  }

  void deleteTask(int listIndex, int taskIndex) {
    setState(() {
      toDoLists[listIndex].tasks.removeAt(taskIndex);
    });
  }

  void deleteToDoList(int index) {
    setState(() {
      toDoLists.removeAt(index);
    });
  }

  void editTask(int listIndex, int taskIndex) {
    setState(() {
      toDoLists[listIndex].tasks[taskIndex] = Task(
          taskName: taskNameController.text,
          deadline: DateTime.parse(dateController.text));
    });
  }

  Task? searchTask(String keyword) {
    print('Search Results:');
    for (var list in toDoLists) {
      for (var task in list.tasks) {
        if (task.taskName.toLowerCase().contains(keyword.toLowerCase())) {
          print('Task: ${task.taskName}, Date: ${task.deadline}');

          return task;
        } else {
          print('No tasks found matching the search term.');
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColour,
      body: Column(
        children: [
          const customAppBar(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       IconButton(
          //           onPressed: () {
          //             showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return AlertDialog(
          //                   title: const Text('search for Task'),
          //                   content: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: <Widget>[
          //                       TextField(
          //                         controller: taskNameController,
          //                         decoration: const InputDecoration(
          //                             labelText: 'Task Name'),
          //                       ),
          //                     ],
          //                   ),
          //                   actions: <Widget>[
          //                     TextButton(
          //                       onPressed: () {
          //                         Navigator.pop(context);
          //                       },
          //                       child: const Text('Cancel'),
          //                     ),
          //                     TextButton(
          //                       onPressed: () {
          //                         //             if (formKey.currentState!.validate()) {
          //                         //   formKey.currentState!.save();
          //                         //   addTask(taskNameController.text);
          //                         // } else {
          //                         //   autovalidateMode = AutovalidateMode.always;
          //                         //   setState(
          //                         //     () {},
          //                         //   );
          //                         // }
          //                         searchTask(taskNameController.text);

          //                         Navigator.pop(context);
          //                       },
          //                       child: const Text('search'),
          //                     ),
          //                   ],
          //                 );
          //               },
          //             );
          //           },
          //           icon: Icon(Icons.search)),
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoLists.length,
              itemBuilder: (context, listIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 18),
                              controller: listNameControllers[
                                  listIndex], // Use the corresponding controller,
                              onChanged: (value) {
                                setState(() {
                                  toDoLists[listIndex].listName = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'List Name',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteToDoList(listIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: toDoLists[listIndex].tasks.length,
                      itemBuilder: (context, taskIndex) {
                        return ListTile(
                          leading: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value:
                                toDoLists[listIndex].tasks[taskIndex].isChecked,
                            onChanged: (value) {
                              setState(() {
                                toDoLists[listIndex]
                                    .tasks[taskIndex]
                                    .isChecked = value!;
                              });
                            },
                            activeColor: KPrimaryColourGreen,
                          ),
                          title: Text(
                            toDoLists[listIndex].tasks[taskIndex].taskName,
                            style: TextStyle(
                              decoration: toDoLists[listIndex]
                                      .tasks[taskIndex]
                                      .isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: toDoLists[listIndex]
                                      .tasks[taskIndex]
                                      .isChecked
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          subtitle: Text(toDoLists[listIndex]
                              .tasks[taskIndex]
                              .deadline
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const PriorityIcon(),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Add Task',
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              TextField(
                                                controller: taskNameController,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Task Name'),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final DateTime? pickedDate =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101),
                                                  );
                                                  if (pickedDate != null) {
                                                    final TimeOfDay?
                                                        pickedTime =
                                                        // ignore: use_build_context_synchronously
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (pickedTime != null) {
                                                      final DateTime
                                                          selectedDateTime =
                                                          DateTime(
                                                        pickedDate.year,
                                                        pickedDate.month,
                                                        pickedDate.day,
                                                        pickedTime.hour,
                                                        pickedTime.minute,
                                                      );
                                                      setState(() {
                                                        dateController.text =
                                                            selectedDateTime
                                                                .toString();
                                                      });
                                                    }
                                                  }
                                                },
                                                child: IgnorePointer(
                                                  child: TextField(
                                                    controller: dateController,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Due Date & Time',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                editTask(listIndex, taskIndex);
                                                Navigator.pop(context);
                                              },
                                              child: const Text('edit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteTask(listIndex, taskIndex);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                KPrimaryColour)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Add Task',
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: taskNameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Task Name'),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null) {
                                          final TimeOfDay? pickedTime =
                                              // ignore: use_build_context_synchronously
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (pickedTime != null) {
                                            final DateTime selectedDateTime =
                                                DateTime(
                                              pickedDate.year,
                                              pickedDate.month,
                                              pickedDate.day,
                                              pickedTime.hour,
                                              pickedTime.minute,
                                            );
                                            setState(() {
                                              dateController.text =
                                                  selectedDateTime.toString();
                                            });
                                          }
                                        }
                                      },
                                      child: IgnorePointer(
                                        child: TextField(
                                          controller: dateController,
                                          decoration: const InputDecoration(
                                            labelText: 'Due Date & Time',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      addTask(listIndex);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColourGreen,
        onPressed: addNewToDoList,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: constant_identifier_names
enum Priority { High, Normal, Low }

class PriorityIcon extends StatefulWidget {
  const PriorityIcon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PriorityIconState createState() => _PriorityIconState();
}

class _PriorityIconState extends State<PriorityIcon> {
  Priority priority = Priority.Normal; // Default priority

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Priority>(
      onSelected: (Priority value) {
        setState(() {
          priority = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Priority>>[
        const PopupMenuItem(
          value: Priority.High,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.red),
            title: Text('High Priority'),
          ),
        ),
        const PopupMenuItem(
          value: Priority.Normal,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.yellow),
            title: Text('Normal Priority'),
          ),
        ),
        const PopupMenuItem(
          value: Priority.Low,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.green),
            title: Text('Low Priority'),
          ),
        ),
      ],
      child: Icon(
        Icons.flag,
        color: priority == Priority.High
            ? Colors.red
            : priority == Priority.Normal
                ? Colors.yellow
                : Colors.green,
      ),

      // Icon(Icons.keyboard_arrow_down),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ToDoListScreen(),
  ));
}

// leading: IconButton(
                                  //   icon: Icon(Icons.add),
                                  //   onPressed: () {
                                  //     showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return AlertDialog(
                                  //           title: const Text(
                                  //             'Add Task',
                                  //           ),
                                  //           content: Column(
                                  //             mainAxisSize: MainAxisSize.min,
                                  //             children: <Widget>[
                                  //               TextField(
                                  //                 // controller: listNameController,
                                  //                 controller: listNameControllers[
                                  //                     listIndex], // Use the corresponding controller,
                                  //                 onChanged: (value) {
                                  //                   setState(() {
                                  //                     toDoLists[listIndex]
                                  //                         .listName = value;
                                  //                   });
                                  //                 },
                                  //                 decoration:
                                  //                     const InputDecoration(
                                  //                         labelText:
                                  //                             'Task Name'),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           actions: <Widget>[
                                  //             TextButton(
                                  //               onPressed: () {
                                  //                 Navigator.pop(context);
                                  //               },
                                  //               child: const Text('Cancel'),
                                  //             ),
                                  //             TextButton(
                                  //               onPressed: () {
                                  //                 addNewToDoList;
                                  //                 Navigator.pop(context);
                                  //               },
                                  //               child: const Text('Add'),
                                  //             ),
                                  //           ],
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  // ),





// floatingActionButton: FloatingActionButton(
      //   backgroundColor: KPrimaryColourGreen,
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: const Text(
      //             'Add Task',
      //           ),
      //           content: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               TextField(
      //                 // controller: listNameController,
      //                 controller: listNameControllers[
      //                                         listIndex], // Use the corresponding controller,
      //                                     onChanged: (value) {
      //                                       setState(() {
      //                                         toDoLists[listIndex].listName = value;
      //                                       });
      //                                     },
      //                 decoration: const InputDecoration(labelText: 'Task Name'),
      //               ),
      //             ],
      //           ),
      //           actions: <Widget>[
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: const Text('Cancel'),
      //             ),
      //             TextButton(
      //               onPressed: () {
      //                 addNewToDoList;
      //                 Navigator.pop(context);
      //               },
      //               child: const Text('Add'),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   // addNewToDoList,
      //   child: const Icon(Icons.add),
      // ),











//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: KPrimaryColour,
//       body: Column(
//         children: [
//           const customAppBar(),
//        Expanded(
//          child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: toDoLists.length,
//           itemBuilder: (context, listIndex) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       TextFormField(
//                         controller: listNameController,
//                         onChanged: (value) {
//                           toDoLists[listIndex].listName = value;
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'List Name',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () {
//                           deleteToDoList(listIndex);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: toDoLists[listIndex].tasks.length,
//                   itemBuilder: (context, taskIndex) {
//                     return SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: ListTile(
//                         leading: Checkbox(
//                             materialTapTargetSize: MaterialTapTargetSize.padded,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                           value: toDoLists[listIndex].tasks[taskIndex].isChecked,
//                           onChanged: (value) {
//                             setState(() {
//                               toDoLists[listIndex].tasks[taskIndex].isChecked =
//                                   value!;
//                             });
//                           },
//                            activeColor: KPrimaryColourGreen,
//                         ),
//                         title: Text(
//                           toDoLists[listIndex].tasks[taskIndex].taskName,
//                           style: TextStyle(
//                             decoration: toDoLists[listIndex]
//                                     .tasks[taskIndex]
//                                     .isChecked
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                                 color: toDoLists[listIndex].tasks[taskIndex].isChecked
//                               ? Colors
//                                   .grey // Set the color to gray when isChecked is true
//                               : Colors
//                                   .black, 
//                           ),
//                         ),
//                         subtitle: Text(toDoLists[listIndex].tasks[taskIndex].deadline.toString()),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             deleteTask(listIndex, taskIndex);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                       title: const Text('Add Task'),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           TextField(
//                             controller: taskNameController,
//                             decoration:
//                                 const InputDecoration(labelText: 'Task Name'),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               final DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2101),
//                               );
//                               if (pickedDate != null) {
//                                 final TimeOfDay? pickedTime =
//                                     // ignore: use_build_context_synchronously
//                                     await showTimePicker(
//                                   context: context,
//                                   initialTime: TimeOfDay.now(),
//                                 );
//                                 if (pickedTime != null) {
//                                   final DateTime selectedDateTime = DateTime(
//                                     pickedDate.year,
//                                     pickedDate.month,
//                                     pickedDate.day,
//                                     pickedTime.hour,
//                                     pickedTime.minute,
//                                   );
//                                   setState(() {
//                                     dateController.text =
//                                         selectedDateTime.toString();
//                                   });
//                                 }
//                               }
//                             },
//                             child: IgnorePointer(
//                               child: TextField(
//                                 controller: dateController,
//                                 decoration: const InputDecoration(
//                                     labelText: 'Due Date & Time'),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Cancel'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             addTask(listIndex);
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Add'),
//                         ),
//                       ],
//                     );
//                         },
//                       );
//                     },
//                     child: const Text('Add Task'),
//                   ),
//                 ),
//               ],
//             );
//           },
//              ),
//        ),
//        FloatingActionButton(
//         backgroundColor: KPrimaryColourGreen,
//         onPressed: addNewToDoList,
//         child: const Icon(Icons.add),
//       ),
//    ] ));
//   }





















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

// class ToDoListClass {
//   String listName;
//   List<Task> tasks;

//   ToDoListClass({required this.listName, required this.tasks});
// }

// class Task {
//   final String taskName;
//   final DateTime deadline;
//   bool isChecked;
//   //final int color;
//   Task({
//     required this.taskName,
//     required this.deadline,
//     this.isChecked = false,
//     //required this.color,
//   });
// }

// class ToDoListScreen extends StatefulWidget {
//   const ToDoListScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ToDoListScreenState createState() => _ToDoListScreenState();
// }

// class _ToDoListScreenState extends State<ToDoListScreen> {
//     List<ToDoListClass> toDoLists = [];

//   //List<Task> tasks = [];

//   TextEditingController taskNameController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController colorController = TextEditingController();


//   @override
//   void initState() {
//     super.initState();
//     // Add an initial empty to-do list
//     addNewToDoList();
//   }

//   void addNewToDoList() {
//     setState(() {
//       toDoLists.add(ToDoListClass(listName: "", tasks: []));
//     });
//   }

//   void addTask(int listIndex) {
//     setState(() {
//       toDoLists[listIndex].tasks.add(Task(
//         taskName: taskNameController.text,
//         deadline: DateTime.parse(dateController.text),
//       ));
//       taskNameController.clear();
//       dateController.clear();
//     });
//   }

//   void deleteTask(int listIndex, int taskIndex) {
//     setState(() {
//       toDoLists[listIndex].tasks.removeAt(taskIndex);
//     });
//   }

//   void deleteToDoList(int index) {
//     setState(() {
//       toDoLists.removeAt(index);
//     });
//   }


//   // // Function to add task
//   // void addTask() {
//   //   setState(() {
//   //     tasks.add(Task(
//   //       taskName: taskNameController.text,
//   //       deadline: DateTime.parse(dateController.text),
//   //       // color: int.parse(colorController.text),
//   //     ));
//   //     for (Task user in tasks) {
//   //       // ignore: avoid_print
//   //       print('Task: ${user.taskName} ' ' date:${user.deadline}');
//   //     }
//   //     taskNameController.clear();
//   //     dateController.clear();

//   //     /// colorController.clear();
//   //   });
//   // }

//   // // Function to edit task
//   // void editTask(int index) {
//   //   setState(() {
//   //     tasks[index] = Task(
//   //       taskName: taskNameController.text,
//   //       deadline: DateTime.parse(dateController.text),
//   //       //  color: int.parse(colorController.text),
//   //     );
//   //     for (Task user in tasks) {
//   //       // ignore: avoid_print
//   //       print('Task: ${user.taskName} ' ' date:${user.deadline}');
//   //     }
//   //     taskNameController.clear();
//   //     dateController.clear();
//   //     colorController.clear();
//   //   });
//   // }

//   // // Function to delete task
//   // void deleteTask(int index) {
//   //   setState(() {
//   //     tasks.removeAt(index);
//   //   });
//   //   for (Task user in tasks) {
//   //     // ignore: avoid_print
//   //     print('Task: ${user.taskName}' ' date:${user.deadline}');
//   //   }
//   // }

//   //bool checked = false;
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return Scaffold(
//       backgroundColor: KPrimaryColour,
//       body: Column(
//         children: [
//           const customAppBar(),
//           Expanded(child: ListView.builder(
//         itemCount: toDoLists.length,
//         itemBuilder: (context, listIndex) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: listNameController,
//                         onChanged: (value) {
//                           toDoLists[listIndex].listName = value;
//                         },
//                         decoration: const InputDecoration(
//                           labelText: 'List Name',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () {
//                         deleteToDoList(listIndex);
//                       },
//                     ),
//                   ],
//                 ),
//               ),]);
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//               itemCount: toDoLists[listIndex].tasks.length,
//             // scrollDirection: Axis.horizontal,
//             itemBuilder: (context, listindex) {
//               return SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: ListTile(
//                     leading: Checkbox(
//                       materialTapTargetSize: MaterialTapTargetSize.padded,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       value: toDoLists[listIndex].tasks[taskIndex].isChecked,
//                       tristate: true,
//                       onChanged: (bool? value) {
//                         setState(() {
// toDoLists[listIndex].tasks[taskIndex].isChecked =
//                               value!;                        });
//                       },
//                       activeColor: KPrimaryColourGreen,
//                     ),
//                     title: Text(
//                       tasks[index].taskName,
//                       style: TextStyle(
//                         fontSize: 18,
//                         decoration: toDoLists[listIndex]
//                                 .tasks[taskIndex]
//                                 .isChecked
//                             ? TextDecoration.lineThrough
//                             : TextDecoration.none,
//                         color:toDoLists[listIndex]
//                                 .tasks[taskIndex].isChecked
//                             ? Colors
//                                 .grey // Set the color to gray when isChecked is true
//                             : Colors
//                                 .black, // Set the color to black when isChecked is false
//                       ),
//                     ),
//                     subtitle: Text(toDoLists[listIndex].tasks[taskIndex].deadline.toString()),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         priorityIcon(),
//                         IconButton(
//                             icon: const Icon(Icons.edit,
//                                 color: Colors.brown), // Edit icon
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: const Text('Edit Task'),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         TextField(
//                                           controller: taskNameController,
//                                           decoration: const InputDecoration(
//                                               labelText: 'Task Name'),
//                                         ),
//                                         InkWell(
                                         

//                                           onTap: () async {
//                                             final DateTime? pickedDate =
//                                                 await showDatePicker(
//                                               context: context,
//                                               initialDate: DateTime.now(),
//                                               firstDate: DateTime(2000),
//                                               lastDate: DateTime(2101),
//                                             );
//                                             if (pickedDate != null) {
//                                               final TimeOfDay? pickedTime =
//                                                   // ignore: use_build_context_synchronously
//                                                   await showTimePicker(
//                                                 context: context,
//                                                 initialTime: TimeOfDay.now(),
//                                               );
//                                               if (pickedTime != null) {
//                                                 final DateTime
//                                                     selectedDateTime =
//                                                     DateTime(
//                                                   pickedDate.year,
//                                                   pickedDate.month,
//                                                   pickedDate.day,
//                                                   pickedTime.hour,
//                                                   pickedTime.minute,
//                                                 );
//                                                 setState(() {
//                                                   dateController.text =
//                                                       selectedDateTime
//                                                           .toString();
//                                                 });
//                                               }
//                                             }
//                                           },
//                                           child: IgnorePointer(
//                                             child: TextField(
//                                               controller: dateController,
//                                               decoration:
//                                                   const InputDecoration(
//                                                       labelText:
//                                                           'Due Date & Time'),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: <Widget>[
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text('Cancel'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           //             if (formKey.currentState!.validate()) {
//                                           //   formKey.currentState!.save();
//                                           //   addTask(taskNameController.text);
//                                           // } else {
//                                           //   autovalidateMode = AutovalidateMode.always;
//                                           //   setState(
//                                           //     () {},
//                                           //   );
//                                           // }
//                                         //  editTask(index);

//                                           Navigator.pop(context);
//                                         },
//                                         child: const Text('edit'),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             } // Edit task function
//                             ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.brown,
//                           ), // Delete icon
//                           onPressed: () =>
//                               deleteTask(listIndex, taskIndex)), // Delete task function
//                         ),
//                       ],
//                     ),
//                   ),);
//             },
//           ),
//           FloatingActionButton(
//             hoverColor: KPrimaryColourGreen,
//             backgroundColor: KPrimaryColourGreen,
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text('Add Task'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         TextField(
//                           controller: taskNameController,
//                           decoration:
//                               const InputDecoration(labelText: 'Task Name'),
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             final DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               final TimeOfDay? pickedTime =
//                                   // ignore: use_build_context_synchronously
//                                   await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay.now(),
//                               );
//                               if (pickedTime != null) {
//                                 final DateTime selectedDateTime = DateTime(
//                                   pickedDate.year,
//                                   pickedDate.month,
//                                   pickedDate.day,
//                                   pickedTime.hour,
//                                   pickedTime.minute,
//                                 );
//                                 setState(() {
//                                   dateController.text =
//                                       selectedDateTime.toString();
//                                 });
//                               }
//                             }
//                           },
//                           child: IgnorePointer(
//                             child: TextField(
//                               controller: dateController,
//                               decoration: const InputDecoration(
//                                   labelText: 'Due Date & Time'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           addTask();

//                           Navigator.pop(context);
//                         },
//                         child: const Text('Add'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }


// enum Priority { High, Normal, Low }

// class priorityIcon extends StatefulWidget {
//   @override
//   _priorityIconState createState() => _priorityIconState();
// }

// class _priorityIconState extends State<priorityIcon> {
//   Priority priority = Priority.Normal; // Default priority

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Priority>(
//       focusColor: KPrimaryColour,
      
//       value: priority,
//       onChanged: (value) {
//         setState(() {
//           priority = value!;
//         });
//       },
//       items: const [
//         DropdownMenuItem(
//           value: Priority.High,
//           child: Row(
//             children: [
//               Icon(Icons.flag, color: Colors.red),
//               SizedBox(width: 8),
//               Text('High Priority'),
//             ],
//           ),
//         ),
//         DropdownMenuItem(
//           value: Priority.Normal,
//           child: Row(
//             children: [
//               Icon(Icons.flag, color: Colors.yellow),
//               SizedBox(width: 8),
//               Text('Normal Priority'),
//             ],
//           ),
//         ),
//         DropdownMenuItem(
//           value: Priority.Low,
//           child: Row(
//             children: [
//               Icon(Icons.flag, color: Colors.green),
//               SizedBox(width: 8),
//               Text('Low Priority'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

  
// }

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ToDoListScreen(),
//   ));
// }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }






















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/customAppBar.dart';

// class ToDoListClass {
//   final String taskName;
//   final DateTime deadline;
//   bool isChecked;
//   //final int color;
//   ToDoListClass({
//     required this.taskName,
//     required this.deadline,
//     this.isChecked = false,
//     //required this.color,
//   });
// }

// class ToDoListScreen extends StatefulWidget {
//   const ToDoListScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ToDoListScreenState createState() => _ToDoListScreenState();
// }

// class _ToDoListScreenState extends State<ToDoListScreen> {
//   List<Map<String, dynamic>> toDoLists = [];
//  // List<ToDoListClass> tasks = [];

//   TextEditingController listNameController = TextEditingController();

//   TextEditingController taskNameController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   //TextEditingController colorController = TextEditingController();

//   // Function to add task
//   void addTask(int listIndex) {
//     setState(() {
//       toDoLists[listIndex]['tasks'].add(ToDoListClass(
//         taskName: taskNameController.text,
//         deadline: DateTime.parse(dateController.text),
//         // color: int.parse(colorController.text),
//       ));
//       // for (ToDoListClass user in tasks) {
//       //   // ignore: avoid_print
//       //   print('Task: ${user.taskName} ' ' date:${user.deadline}');
//       // }
//       taskNameController.clear();
//       dateController.clear();

//       /// colorController.clear();
//     });
//   }

//   // Function to edit task
//   void editTask(int listIndex) {
//     setState(() {
      
//       // toDoLists[listIndex] = ToDoListClass(
//       //   taskName: taskNameController.text,
//       //   deadline: DateTime.parse(dateController.text),
//       //   //  color: int.parse(colorController.text),
//       // );
//       // for (ToDoListClass user in tasks) {
//       //   // ignore: avoid_print
//       //   print('Task: ${user.taskName} ' ' date:${user.deadline}');
//       // }
//       taskNameController.clear();
//       dateController.clear();
//       colorController.clear();
//     });
//   }

//   // Function to delete task
//   void deleteTask(int index) {
//     setState(() {
//     //  tasks.removeAt(index);
//     });
//     // for (ToDoListClass user in tasks) {
//     //   // ignore: avoid_print
//     //   print('Task: ${user.taskName}' ' date:${user.deadline}');
//     // }
//   }

//   //bool checked = false;
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return Scaffold(
//       backgroundColor: KPrimaryColour,
//       body: Column(
//         children: [
//           const customAppBar(),
//           //  Padding(
//           //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           //       child: Text(
//           //         toDoLists[index]['name'],
//           //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           Expanded(
//             child: ListView.builder(
//              // shrinkWrap: true,
//                 itemCount: toDoLists.length,
//               // scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: ListTile(
//                       leading: Checkbox(
//                         materialTapTargetSize: MaterialTapTargetSize.padded,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         value: tasks[index].isChecked,
//                         tristate: true,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             tasks[index].isChecked = value ?? false;
//                           });
//                         },
//                         activeColor: KPrimaryColourGreen,
//                       ),
//                       title: Text(toDoLists[index]['tasks'][taskIndex].taskName),,
//                      subtitle :                     subtitle: Text(toDoLists[index]['tasks'][taskIndex].deadline.toString()),

                      
//                       // subtitle: Text(tasks[index].deadline.toString()),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                               icon: const Icon(Icons.edit,
//                                   color: Colors.brown), // Edit icon
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: const Text('Edit Task'),
//                                       content: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           TextField(
//                                             controller: taskNameController,
//                                             decoration: const InputDecoration(
//                                                 labelText: 'Task Name'),
//                                           ),
//                                           InkWell(
//                                             onTap: () async {
//                                               final DateTime? pickedDate =
//                                                   await showDatePicker(
//                                                 context: context,
//                                                 initialDate: DateTime.now(),
//                                                 firstDate: DateTime(2000),
//                                                 lastDate: DateTime(2101),
//                                               );
//                                               if (pickedDate != null) {
//                                                 final TimeOfDay? pickedTime =
//                                                     // ignore: use_build_context_synchronously
//                                                     await showTimePicker(
//                                                   context: context,
//                                                   initialTime: TimeOfDay.now(),
//                                                 );
//                                                 if (pickedTime != null) {
//                                                   final DateTime
//                                                       selectedDateTime =
//                                                       DateTime(
//                                                     pickedDate.year,
//                                                     pickedDate.month,
//                                                     pickedDate.day,
//                                                     pickedTime.hour,
//                                                     pickedTime.minute,
//                                                   );
//                                                   setState(() {
//                                                     dateController.text =
//                                                         selectedDateTime
//                                                             .toString();
//                                                   });
//                                                 }
//                                               }
//                                             },
//                                             child: IgnorePointer(
//                                               child: TextField(
//                                                 controller: dateController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText:
//                                                             'Due Date & Time'),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text('Cancel'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             //             if (formKey.currentState!.validate()) {
//                                             //   formKey.currentState!.save();
//                                             //   addTask(taskNameController.text);
//                                             // } else {
//                                             //   autovalidateMode = AutovalidateMode.always;
//                                             //   setState(
//                                             //     () {},
//                                             //   );
//                                             // }
//                                             editTask(index);

//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text('edit'),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               } // Edit task function
//                               ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.brown,
//                             ), // Delete icon
//                             onPressed: () =>
//                                 deleteTask(index), // Delete task function
//                           ),
//                         ],
//                       ),
//                     ));
//               },
//             ),
//           ),
//           FloatingActionButton(
//             hoverColor: KPrimaryColourGreen,
//             backgroundColor: KPrimaryColourGreen,
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text('Add Task'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         TextField(
//                   controller: listNameController,
//                   decoration: const InputDecoration(labelText: 'List Name'),
//                 ),
//                         TextField(
//                           controller: taskNameController,
//                           decoration:
//                               const InputDecoration(labelText: 'Task Name'),
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             final DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               final TimeOfDay? pickedTime =
//                                   // ignore: use_build_context_synchronously
//                                   await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay.now(),
//                               );
//                               if (pickedTime != null) {
//                                 final DateTime selectedDateTime = DateTime(
//                                   pickedDate.year,
//                                   pickedDate.month,
//                                   pickedDate.day,
//                                   pickedTime.hour,
//                                   pickedTime.minute,
//                                 );
//                                 setState(() {
//                                   dateController.text =
//                                       selectedDateTime.toString();
//                                 });
//                               }
//                             }
//                           },
//                           child: IgnorePointer(
//                             child: TextField(
//                               controller: dateController,
//                               decoration: const InputDecoration(
//                                   labelText: 'Due Date & Time'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           addTask();

//                           Navigator.pop(context);
//                         },
//                         child: const Text('Add'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ToDoListScreen(),
//   ));
// }