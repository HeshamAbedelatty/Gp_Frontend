// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

class ToDoListClass {
  String listName;
  List<Task> tasks;

  ToDoListClass({
    required this.listName,
    required this.tasks,
  });
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
      toDoLists
          .add(ToDoListClass(listName: listNameController.text, tasks: []));
      listNameControllers.add(
          TextEditingController()); // Add a new controller for the new list
      for (var list in toDoLists) {
        print(list.listName);
      }
      print("addNewToDoList");
      listNameController.clear();
      // toDoLists.add(ToDoListClass(listName: "", tasks: []));
    });
  }

  void addTask(int listIndex) {
    setState(() {
      var taskNameVar = taskNameController.text;
      var deadlineVar = dateController.text;

      toDoLists[listIndex].tasks.add(Task(
            taskName: taskNameVar,
            deadline: DateTime.parse(deadlineVar),
          ));
      for (var list in toDoLists) {
        for (var task in list.tasks) {
          print(list.listName);
          print(
            'Added Task: ${task.taskName} , Deadline: ${task.deadline} , check: ${task.isChecked}',
          );
        }
      }

      taskNameController.clear();
      dateController.clear();
    });
  }

  void deleteTask(int listIndex, int taskIndex) {
    setState(() {
      toDoLists[listIndex].tasks.removeAt(taskIndex);
    });
    for (var list in toDoLists) {
      for (var task in list.tasks) {
        print(list.listName);
        print(
          'Added Task: ${task.taskName} , Deadline: ${task.deadline}',
        );
      }
    }
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
    for (var list in toDoLists) {
      for (var task in list.tasks) {
        print(list.listName);
        print(
          'Added Task: ${task.taskName} , Deadline: ${task.deadline}',
        );
      }
    }
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
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3C8243),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Add List'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                controller: listNameControllers.isNotEmpty
                                    ? listNameControllers[toDoLists.length - 1]
                                    : TextEditingController(),
                                onChanged: (value) {
                                  setState(() {
                                    toDoLists[toDoLists.length - 1].listName =
                                        value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'List Name',
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
                                addNewToDoList();
                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add List'),
                ),
              ],
            ),
          ),
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: toDoLists.length,
                itemBuilder: (context, listIndex) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
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
                                  title: Text(
                                    toDoLists[listIndex].listName,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteToDoList(listIndex);
                                    },
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: toDoLists[listIndex].tasks.length,
                                  itemBuilder: (context, taskIndex) {
                                    return ListTile(
                                      leading: Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        value: toDoLists[listIndex]
                                            .tasks[taskIndex]
                                            .isChecked,
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
                                        toDoLists[listIndex]
                                            .tasks[taskIndex]
                                            .taskName,
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
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          TextField(
                                                            controller:
                                                                taskNameController,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Task Name'),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              final DateTime?
                                                                  pickedDate =
                                                                  await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        2101),
                                                              );
                                                              if (pickedDate !=
                                                                  null) {
                                                                final TimeOfDay?
                                                                    pickedTime =
                                                                    // ignore: use_build_context_synchronously
                                                                    await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      TimeOfDay
                                                                          .now(),
                                                                );
                                                                if (pickedTime !=
                                                                    null) {
                                                                  final DateTime
                                                                      selectedDateTime =
                                                                      DateTime(
                                                                    pickedDate
                                                                        .year,
                                                                    pickedDate
                                                                        .month,
                                                                    pickedDate
                                                                        .day,
                                                                    pickedTime
                                                                        .hour,
                                                                    pickedTime
                                                                        .minute,
                                                                  );
                                                                  setState(() {
                                                                    dateController
                                                                            .text =
                                                                        selectedDateTime
                                                                            .toString();
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            child:
                                                                IgnorePointer(
                                                              child: TextField(
                                                                controller:
                                                                    dateController,
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
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            editTask(listIndex,
                                                                taskIndex);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'edit'),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color?>(KPrimaryColour)),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Add Task',
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    TextField(
                                                      controller:
                                                          taskNameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Task Name'),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final DateTime?
                                                            pickedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(2101),
                                                        );
                                                        if (pickedDate !=
                                                            null) {
                                                          final TimeOfDay?
                                                              pickedTime =
                                                              // ignore: use_build_context_synchronously
                                                              await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now(),
                                                          );
                                                          if (pickedTime !=
                                                              null) {
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
                                                              dateController
                                                                      .text =
                                                                  selectedDateTime
                                                                      .toString();
                                                            });
                                                          }
                                                        }
                                                      },
                                                      child: IgnorePointer(
                                                        child: TextField(
                                                          controller:
                                                              dateController,
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
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ]);
                },
              ),
            ),
          ),
        ],
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