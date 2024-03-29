import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

class ToDoListClass {
  final String taskName;
  final DateTime deadline;
  bool isChecked;
  //final int color;
  ToDoListClass({
    required this.taskName,
    required this.deadline,
    this.isChecked = false,
    //required this.color,
  });
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        deadline: DateTime.parse(dateController.text),
        // color: int.parse(colorController.text),
      ));
      for (ToDoListClass user in tasks) {
        // ignore: avoid_print
        print('Task: ${user.taskName} ' ' date:${user.deadline}');
      }
      taskNameController.clear();
      dateController.clear();

      /// colorController.clear();
    });
  }

  // Function to edit task
  void editTask(int index) {
    setState(() {
      tasks[index] = ToDoListClass(
        taskName: taskNameController.text,
        deadline: DateTime.parse(dateController.text),
        //  color: int.parse(colorController.text),
      );
      for (ToDoListClass user in tasks) {
        // ignore: avoid_print
        print('Task: ${user.taskName} ' ' date:${user.deadline}');
      }
      taskNameController.clear();
      dateController.clear();
      colorController.clear();
    });
  }

  void searchTask(String searchTerm) {
    List<ToDoListClass> searchResults = tasks
        .where((task) =>
            task.taskName.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    if (searchResults.isNotEmpty) {
      print('Search Results:');
      for (ToDoListClass task in searchResults) {
        print('Task: ${task.taskName}, Date: ${task.deadline}');
      }
    } else {
      print('No tasks found matching the search term.');
    }
  }

  // Function to delete task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    for (ToDoListClass user in tasks) {
      // ignore: avoid_print
      print('Task: ${user.taskName}' ' date:${user.deadline}');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
      body: Column(
        children: [
          const customAppBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('search for Task'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: taskNameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Task Name'),
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
                                  //             if (formKey.currentState!.validate()) {
                                  //   formKey.currentState!.save();
                                  //   addTask(taskNameController.text);
                                  // } else {
                                  //   autovalidateMode = AutovalidateMode.always;
                                  //   setState(
                                  //     () {},
                                  //   );
                                  // }
                                  searchTask(taskNameController.text);

                                  Navigator.pop(context);
                                },
                                child: const Text('search'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
           
              children: [
                Text("ToDoList:",style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: tasks[index].isChecked,
                      tristate: true,
                      onChanged: (bool? value) {
                        setState(() {
                          tasks[index].isChecked = value ?? false;
                        });
                      },
                      activeColor: kprimaryColourGreen,
                    ),
                    title: Text(
                      tasks[index].taskName,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: tasks[index].isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: tasks[index].isChecked
                            ? Colors
                                .grey // Set the color to gray when isChecked is true
                            : Colors
                                .black, // Set the color to black when isChecked is false
                      ),
                    ),
                    subtitle: Text(tasks[index].deadline.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PriorityIcon(),
                        IconButton(
                            icon: const Icon(Icons.edit,
                               ), // Edit icon
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit Task'),
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
                                                final DateTime
                                                    selectedDateTime = DateTime(
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
                                              decoration: const InputDecoration(
                                                  labelText: 'Due Date & Time'),
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
                                          //             if (formKey.currentState!.validate()) {
                                          //   formKey.currentState!.save();
                                          //   addTask(taskNameController.text);
                                          // } else {
                                          //   autovalidateMode = AutovalidateMode.always;
                                          //   setState(
                                          //     () {},
                                          //   );
                                          // }
                                          editTask(index);

                                          Navigator.pop(context);
                                        },
                                        child: const Text('edit'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } // Edit task function
                            ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            
                          ), // Delete icon
                          onPressed: () =>
                              deleteTask(index), // Delete task function
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            hoverColor: kprimaryColourGreen,
            backgroundColor: kprimaryColourGreen,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: taskNameController,
                          decoration:
                              const InputDecoration(labelText: 'Task Name'),
                        ),
                        InkWell(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
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
                                final DateTime selectedDateTime = DateTime(
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
                                  labelText: 'Due Date & Time'),
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
                          addTask();

                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
enum Priority { High, Normal, Low }

class PriorityIcon extends StatefulWidget {
  @override
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
        PopupMenuItem(
          value: Priority.High,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.red),
            title: Text('High Priority'),
          ),
        ),
        PopupMenuItem(
          value: Priority.Normal,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.yellow),
            title: Text('Normal Priority'),
          ),
        ),
        PopupMenuItem(
          value: Priority.Low,
          child: ListTile(
            leading: Icon(Icons.flag, color: Colors.green),
            title: Text('Low Priority'),
          ),
        ),
      ],
      child:  Icon(
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
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
