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

  //bool checked = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: KPrimaryColour,
      body: Column(
        children: [
          const customAppBar(),
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
                      activeColor: KPrimaryColourGreen,
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
                        priorityIcon(),
                        IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.brown), // Edit icon
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
                            color: Colors.brown,
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
            hoverColor: KPrimaryColourGreen,
            backgroundColor: KPrimaryColourGreen,
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

class priorityIcon extends StatefulWidget {
  @override
  _priorityIconState createState() => _priorityIconState();
}

class _priorityIconState extends State<priorityIcon> {
  Priority priority = Priority.Normal; // Default priority

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Priority>(
      focusColor: KPrimaryColour,
      value: priority,
      onChanged: (value) {
        setState(() {
          priority = value!;
        });
      },
      items: const [
        DropdownMenuItem(
          value: Priority.High,
          child: Row(
            children: [
              Icon(Icons.flag, color: Colors.red),
              SizedBox(width: 8),
              Text('High Priority'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: Priority.Normal,
          child: Row(
            children: [
              Icon(Icons.flag, color: Colors.yellow),
              SizedBox(width: 8),
              Text('Normal Priority'),
            ],
          ),
        ),
        DropdownMenuItem(
          value: Priority.Low,
          child: Row(
            children: [
              Icon(Icons.flag, color: Colors.green),
              SizedBox(width: 8),
              Text('Low Priority'),
            ],
          ),
        ),
      ],
    );
  }
}

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
