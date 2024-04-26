// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/toDoListPage/Widgets/Priority.dart';
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
  Priority priority;

  Task({
    required this.taskName,
    required this.deadline,
    this.isChecked = false,
    this.priority = Priority.normal, // Default priority
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
      var priorityVar = Priority.normal; // Default priority

      toDoLists[listIndex].tasks.add(Task(
            taskName: taskNameVar,
            deadline: DateTime.parse(deadlineVar),
            priority: priorityVar,
          ));
      for (var list in toDoLists) {
        for (var task in list.tasks) {
          print(list.listName);
          print(
            'Added Task: ${task.taskName} , Deadline: ${task.deadline} , check: ${task.isChecked} ,priority: ${task.priority}',
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
          'Added Task: ${task.taskName} , Deadline: ${task.deadline},priority: ${task.priority}',
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
      // priority:
      // toDoLists[listIndex]
      //     .tasks[taskIndex]
      //     .priority; // Maintain existing priority
    });
    for (var list in toDoLists) {
      for (var task in list.tasks) {
        print(list.listName);
        print(
          'Added Task: ${task.taskName} , Deadline: ${task.deadline},priority: ${task.priority}',
        );
      }
    }
  }

  Task? searchTask(String keyword) {
    print('Search Results:');
    for (var list in toDoLists) {
      for (var task in list.tasks) {
        if (task.taskName.toLowerCase().contains(keyword.toLowerCase())) {
          print(
              'Task: ${task.taskName}, Date: ${task.deadline},priority: ${task.priority}');

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
      backgroundColor: kprimaryColourWhite,
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
                              child: const Text('Cancel',style: TextStyle(color: kprimaryColourGreen)),
                            ),
                            TextButton(
                              onPressed: () {
                                addNewToDoList();
                                Navigator.pop(context);
                              },
                              child: const Text('Add',style: TextStyle(color: kprimaryColourGreen)),
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
                                        activeColor: kprimaryColourGreen,
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
                                          PriorityIcon(
                                              task: toDoLists[listIndex]
                                                  .tasks[taskIndex]),
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
                                                              'Cancel',style: TextStyle(color: kprimaryColourGreen)),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            editTask(listIndex,
                                                                taskIndex);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'edit',style: TextStyle(color: kprimaryColourGreen)),
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
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'you want to delete this item ?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Cancel',style: TextStyle(color: kprimaryColourGreen)),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          deleteTask(listIndex,
                                                              taskIndex);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'delete',style: TextStyle(color: kprimaryColourGreen)),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
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
                                                        Color?>(
                                                    kprimaryColourWhite)),
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
                                                    child: const Text('Cancel',style: TextStyle(color: kprimaryColourGreen)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      addTask(listIndex);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Add',style: TextStyle(color: kprimaryColourGreen)),
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ToDoListScreen(),
  ));
}
