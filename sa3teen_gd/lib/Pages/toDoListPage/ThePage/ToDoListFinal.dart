import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/toDoListPage/Widgets/Priority.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

// class ToDoListClass {
//   String listName;
//   List<Task> tasks;
//
//   ToDoListClass({
//     required this.listName,
//     required this.tasks,
//   });
// }
// flags
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
  Api_services api_services = Api_services();

  // Api_services.listAllToDoList(accessToken);

  List<Map<String, dynamic>> listNameControllers = [];
  @override
  void initState() {
    super.initState();
    _fetchToDoList();
  }

  Future<void> _fetchToDoList() async {
    List<Map<String, dynamic>> toDoList =
        await api_services.listAllToDoList(accessToken);
    listNameControllers = toDoList;
    setState(() {
      toDoList = toDoList;
    });
  }
  void _showDeleteConfirmationDialog(BuildContext context, int id, String accessToken) {

  }
  // List of controllers for list names

  TextEditingController listNameController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  TextEditingController editTaskNameController = TextEditingController();
  TextEditingController editDateController = TextEditingController();
  @override






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
      body: Column(
        children: [
          const CustomAppBar(
            title: 'ToDoList',
          ),
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            child: Padding(
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
                                  controller: listNameController,


                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel',
                                    style:
                                        TextStyle(color: kprimaryColourGreen)),
                              ),


                              TextButton(
                                onPressed: () async {
                                  // Call the createToDoList method from api_services
                                  bool success = await Api_services.createToDoList(
                                      listNameController.text, accessToken);

                                  // Check if the operation was successful
                                  if (success) {
                                    // Update the list of to-do lists
                                    _fetchToDoList();
                                  } else {
                                    // Handle failure scenario if needed
                                  }

                                  // Close the current screen or dialog
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'add to do',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0, // Increase the font size
                                    fontWeight: FontWeight.bold, // Make the text bold
                                  ),
                                ),
                              )

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
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listNameControllers.length,
                itemBuilder: (context, listIndex) {
                  var listItem = listNameControllers[listIndex];
                  var tasks = listItem['tasks'] as List<dynamic>;
                  int todolistindex= listItem['id'];

                  // Ensure this is a list

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(listItem['title'] ?? ''),
                              trailing:
                              // IconButton(
                              //   icon: const Icon(Icons.delete),
                              //   onPressed: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: Text('Delete To-Do List'),
                              //           content: Text('Do you want to delete this to-do list?'),
                              //           actions: <Widget>[
                              //             TextButton(
                              //               onPressed: () {
                              //                 Navigator.of(context).pop();
                              //               },
                              //               child: Text('No'),
                              //             ),
                              //             TextButton(
                              //               onPressed: () {
                              //                 api_services.deleteToDoList(listItem['id']as int, accessToken);
                              //                 _fetchToDoList();
                              //                 Navigator.pop(context);
                              //
                              //               },
                              //               child: Text('Yes'),
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //
                              //   },
                              // ),






                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Do you want to delete this item?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context); // Close the dialog
                                            },
                                            child: const Text('Cancel', style: TextStyle(color: kprimaryColourGreen)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Perform the deletion
                                              api_services.deleteToDoList(listItem['id'] as int, accessToken)
                                                  .then((_) {
                                                // After deletion, fetch updated todo list
                                                _fetchToDoList();
                                                Navigator.pop(context); // Close the dialog
                                              })
                                                  .catchError((error) {
                                                // Handle error if necessary
                                                print('Error deleting item: $error');
                                              });
                                            },
                                            child: const Text('Delete', style: TextStyle(color: kprimaryColourGreen)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),


                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: tasks.length,
                              itemBuilder: (context, taskIndex) {
                                var taskItem =
                                    tasks[taskIndex] as Map<String, dynamic>;
                                int todotaskindex= taskItem['id'];

                                return ListTile(
                                  leading: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    value: taskItem['status'] ?? false,
                                    onChanged: (value) {
                                      setState(() {

                                        taskItem['status'] =
                                            taskItem['status'] == true
                                                ? false
                                                : true;

                                        Api_services.updateTaskStatus(
                                            listItem['id'],
                                            taskItem['id'],
                                            taskItem['status'],

                                            accessToken);
                                      });
                                      // Navigator.pop(context);
                                      // _fetchToDoList();
                                    },
                                    activeColor: kprimaryColourGreen,
                                  ),
                                  title: Text(
                                    taskItem['title'] ?? '',
                                    style: TextStyle(
                                      decoration: taskItem['status'] == true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      color: taskItem['status'] == true
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(taskItem['due_date'] ?? ''),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       PriorityIcon(priorityValue:taskItem['priority'],listIndex: todolistindex,taskIndex: todotaskindex  ),
                                      IconButton(

                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Add Task'),
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
                                                    child: const Text('Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                kprimaryColourGreen)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {

                                                      Api_services.updateTask(
                                                          listItem['id'],
                                                          taskItem['id'],
                                                          taskNameController.text.isEmpty
                                                              ? listNameControllers[listIndex]['tasks'][taskIndex]['title']
                                                              : taskNameController.text,
                                                          dateController.text.isEmpty
                                                              ? listNameControllers[listIndex]['tasks'][taskIndex]['due_date']
                                                              : dateController.text,
                                                          accessToken
                                                      );
                                                      Navigator.pop(context);
                                                      _fetchToDoList();



                                                    },
                                                    child: const Text('edit',
                                                        style: TextStyle(
                                                            color:
                                                                kprimaryColourGreen)),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Do you want to delete this item?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                kprimaryColourGreen)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      api_services.deleteTask(
                                                          listItem['id'].toString(),
                                                          taskItem['id'].toString(),
                                                          accessToken
                                                      );

                                                      Navigator.pop(context);
                                                      _fetchToDoList();
                                                    },
                                                    child: const Text('delete',
                                                        style: TextStyle(
                                                            color:
                                                                kprimaryColourGreen)),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color?>(
                                                kprimaryColourWhite)),
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
                                                  controller:
                                                      taskNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Task Name'),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      final TimeOfDay?
                                                          pickedTime =
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
                                                child: const Text('Cancel',
                                                    style: TextStyle(
                                                        color:
                                                            kprimaryColourGreen)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Api_services.createTask(
                                                    listItem['id'],
                                                    taskNameController.text,
                                                    'Medium',
                                                    false,
                                                    dateController.text,
                                                    accessToken,
                                                  );
                                                  _fetchToDoList();
                                                  Navigator.pop(context);

                                                },
                                                child: const Text('add',
                                                    style: TextStyle(
                                                        color:
                                                            kprimaryColourGreen)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Add Task',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
