import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/EditTaskScreen.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/addScheduleTask.dart';
import 'package:gp_screen/Pages/schedeulePage/Widgets%20copy/customAppBar.dart';

class Task {
  final String title;
  final String description;
  final DateTime day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int remindInterval;
  final Color color;

  Task({
    required this.title,
    required this.description,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.remindInterval,
    required this.color,
  });
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  late String _taskTitle;
  TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
  int _remindInterval = 15; // Default reminder interval in minutes
  Color _taskColor = Colors.yellow;

  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    // Calculate the starting date to be the previous Saturday
    DateTime startingDate =
        _currentDate.subtract(Duration(days: _currentDate.weekday - 6));

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const customAppBar(),
              const SizedBox(
                height: 9,
              ),
              SizedBox(
                height: 70, // Adjusted height for the row of day cards
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    7,
                    (index) =>
                        _buildDayCard(startingDate.add(Duration(days: index))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return _buildTaskCard(task);
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3C8243),
                ),
                onPressed: () {
                  _showAddTaskScreen(context);
                },
                child: const Text('Add lecture time'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(DateTime day) {
    String dayLabel = DateFormat('E').format(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = day;
        });
      },
      child: Container(
        width: 70,
        height: 35,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _selectedDate == day
              ? const Color(0xFF3C8243)
              : Color.fromARGB(255, 235, 232, 231),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            dayLabel,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _selectedDate == day ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTaskCard(Task task) {
  //   // Check if the task's date matches the day name of the selected date
  //   if (DateFormat('EEEE').format(task.day) ==
  //       DateFormat('EEEE').format(_selectedDate)) {
  //     return Padding(
  //       padding: const EdgeInsets.only(left: 8, right: 10),
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Column(
  //             children: [
  //               Card(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   side: const BorderSide(color: Colors.grey, width: 0.1),
  //                 ),
  //                 color: task.color,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(
  //                       bottom: 5, left: 8, right: 8, top: 5),
  //                   child: Text(
  //                     '${_formatTime(task.startTime)}',
  //                     style: const TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               ),
  //               // const SizedBox(height: 5),
  //               // End Time Card
  //               Card(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   side: const BorderSide(color: Colors.grey, width: 0.1),
  //                 ),
  //                 color: task.color,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(
  //                       bottom: 5, left: 8, right: 8, top: 5),
  //                   child: Text(
  //                     '${_formatTime(task.endTime)}',
  //                     style: const TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),

  //           // Task Title Card
  //           Expanded(
  //             child: Card(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20.0),
  //                 side: const BorderSide(color: Colors.grey, width: 0.1),
  //               ),
  //               color: task.color,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Expanded(
  //                   child: Row(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 23.0),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               task.title,
  //                               style: const TextStyle(
  //                                   color: Colors.white, fontSize: 18),
  //                             ),
  //                             const SizedBox(height: 2),
  //                             Text(
  //                               task.description,
  //                               style: const TextStyle(
  //                                   color: Colors.white, fontSize: 13),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       const Spacer(
  //                         flex: 1,
  //                       ),
  //                       IconButton(
  //                         icon: const Icon(Icons.edit, color: Colors.white),
  //                         onPressed: () {
  //                           // Handle edit action
  //                           _showEditTaskScreen(context, task);
  //                         },
  //                       ),
  //                       IconButton(
  //                         icon: const Icon(Icons.delete, color: Colors.white),
  //                         onPressed: () {
  //                           // Handle delete action
  //                           setState(() {
  //                             _tasks.remove(task);
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           // const SizedBox(height: 8),
  //           // Start Time Card
  //         ],
  //       ),
  //     );
  //   } else {
  //     // Return an empty container if the task's date does not match the selected day name
  //     return Container();
  //   }
  // }
  Widget _buildTaskCard(Task task) {
  // Check if the task's date matches the day name of the selected date
  if (DateFormat('EEEE').format(task.day) ==
      DateFormat('EEEE').format(_selectedDate)) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.grey, width: 0.1),
                ),
                color: task.color,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5, left: 8, right: 8, top: 5),
                  child: Text(
                    '${_formatTime(task.startTime)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // const SizedBox(height: 5),
              // End Time Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.grey, width: 0.1),
                ),
                color: task.color,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 5, left: 8, right: 8, top: 5),
                  child: Text(
                    '${_formatTime(task.endTime)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded( // Ensure Expanded is directly inside Row
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.grey, width: 0.1),
              ),
              color: task.color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row( // Ensure Row is here
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 23.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            task.description,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit action
                        _showEditTaskScreen(context, task);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        // Handle delete action
                        setState(() {
                          _tasks.remove(task);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 8),
          // Start Time Card
        ],
      ),
    );
  } else {
    // Return an empty container if the task's date does not match the selected day name
    return Container();
  }
}


  void _showAddTaskScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskScreen(
          onAddTask: _addTask,
        );
      },
    );
  }

  void _addTask(String title, String description, DateTime date,
      TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
    setState(() {
      // Find the index of the task to be edited
      int index = _tasks.indexWhere((task) =>
          task.day == date &&
          task.startTime == startTime &&
          task.endTime == endTime);

      if (index != -1) {
        // Update the task at the found index with the new values
        _tasks[index] = Task(
          title: title,
          description: description,
          day: date,
          startTime: startTime,
          endTime: endTime,
          remindInterval: remindInterval,
          color: color,
        );
      } else {
        // Add a new task if not found
        _tasks.add(Task(
          title: title,
          description: description,
          day: date,
          startTime: startTime,
          endTime: endTime,
          remindInterval: remindInterval,
          color: color,
        ));
      }
    });
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final time = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.jm().format(time);
  }

  void _showEditTaskScreen(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTaskScreen(
          task: task,
          onUpdateTask: _updateTask,
          onSaveTask: _saveTask,
        );
      },
    );
  }

  // void _updateTask(Task updatedTask) {
  //   setState(() {
  //     // Find the index of the task to be updated
  //     final index = _tasks.indexWhere((task) =>
  //         task.day == updatedTask.day &&
  //         task.startTime == updatedTask.startTime);

  //     // Replace the old task with the updated one
  //     if (index != -1) {
  //       _tasks[index] = updatedTask;
  //     }
  //   });
  // }
  void _updateTask(Task updatedTask) {
  setState(() {
    // Find the index of the task to be updated
    final index = _tasks.indexWhere((task) =>
        task.day == updatedTask.day &&
        task.startTime == updatedTask.startTime);

    // Replace the old task with the updated one
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  });
}


  void _saveTask(String title, String description, DateTime date,
      TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
    // Perform update task operation
    setState(() {
      // Find the index of the task to be edited
      int index = _tasks.indexWhere((task) =>
          task.day == date && task.startTime == startTime && task.endTime == endTime);

      if (index != -1) {
        // Update the task at the found index with the new values
        _tasks[index] = Task(
          title: title,
          description: description,
          day: date,
          startTime: startTime,
          endTime: endTime,
          remindInterval: remindInterval,
          color: color,
        );
      } else {
        // Add a new task if not found
        _tasks.add(Task(
          title: title,
          description: description,
          day: date,
          startTime: startTime,
          endTime: endTime,
          remindInterval: remindInterval,
          color: color,
        ));
      }
    });
    Navigator.of(context).pop();
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SchedulePage(),
  ));
}



////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/schedeulePage/ThePage/EditTaskScreen.dart';
// import 'package:gp_screen/Pages/schedeulePage/Widgets%20copy/customAppBar.dart';
// import 'package:intl/intl.dart';
// import 'addScheduleTask.dart';

// class Task {
//   final String title;
//   final String description;
//   final DateTime day;
//   final TimeOfDay startTime;
//   final TimeOfDay endTime;
//   final int remindInterval;
//   final Color color;

//   Task({
//     required this.title,
//     required this.description,
//     required this.day,
//     required this.startTime,
//     required this.endTime,
//     required this.remindInterval,
//     required this.color,
//   });
// }

// class SchedulePage extends StatefulWidget {
//   @override
//   _SchedulePageState createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> {
//   DateTime _currentDate = DateTime.now();
//   DateTime _selectedDate = DateTime.now();
//   late String _taskTitle;
//   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
//   int _remindInterval = 15; // Default reminder interval in minutes
//   Color _taskColor = Colors.yellow;

//   List<Task> _tasks = [];

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the starting date to be the previous Saturday
//     DateTime startingDate =
//         _currentDate.subtract(Duration(days: _currentDate.weekday - 6));

//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const customAppBar(),
//               const SizedBox(
//                 height: 9,
//               ),
//               SizedBox(
//                 height: 70, // Adjusted height for the row of day cards
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: List.generate(
//                     7,
//                     (index) =>
//                         _buildDayCard(startingDate.add(Duration(days: index))),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _tasks.length,
//                   itemBuilder: (context, index) {
//                     final task = _tasks[index];
//                     return _buildTaskCard(task);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF3C8243),
//                 ),
//                 onPressed: () {
//                   _showAddTaskScreen(context);
//                 },
//                 child: const Text('Add lecture time'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayCard(DateTime day) {
//     String dayLabel = DateFormat('E').format(day);
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedDate = day;
//         });
//       },
//       child: Container(
//         width: 70,
//         height: 35,
//         margin: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: _selectedDate == day
//               ? const Color(0xFF3C8243)
//               : Color.fromARGB(255, 235, 232, 231),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             dayLabel,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: _selectedDate == day ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildTaskCard(Task task) {
//   //   // Check if the task's date matches the day name of the selected date
//   //   if (DateFormat('EEEE').format(task.day) ==
//   //       DateFormat('EEEE').format(_selectedDate)) {
//   //     return Padding(
//   //       padding: const EdgeInsets.only(left: 8, right: 10),
//   //       child: Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Column(
//   //             children: [
//   //               Card(
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(20.0),
//   //                   side: const BorderSide(color: Colors.grey, width: 0.1),
//   //                 ),
//   //                 color: task.color,
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.only(
//   //                       bottom: 5, left: 8, right: 8, top: 5),
//   //                   child: Text(
//   //                     '${_formatTime(task.startTime)}',
//   //                     style: const TextStyle(color: Colors.white),
//   //                   ),
//   //                 ),
//   //               ),
//   //               // const SizedBox(height: 5),
//   //               // End Time Card
//   //               Card(
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(20.0),
//   //                   side: const BorderSide(color: Colors.grey, width: 0.1),
//   //                 ),
//   //                 color: task.color,
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.only(
//   //                       bottom: 5, left: 8, right: 8, top: 5),
//   //                   child: Text(
//   //                     '${_formatTime(task.endTime)}',
//   //                     style: const TextStyle(color: Colors.white),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),

//   //           // Task Title Card
//   //           Expanded(
//   //             child: Card(
//   //               shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(20.0),
//   //                 side: const BorderSide(color: Colors.grey, width: 0.1),
//   //               ),
//   //               color: task.color,
//   //               child: Padding(
//   //                 padding: const EdgeInsets.all(8.0),
//   //                 child: Expanded(
//   //                   child: Row(
//   //                     children: [
//   //                       Padding(
//   //                         padding: const EdgeInsets.only(left: 23.0),
//   //                         child: Column(
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             Text(
//   //                               task.title,
//   //                               style: const TextStyle(
//   //                                   color: Colors.white, fontSize: 18),
//   //                             ),
//   //                             const SizedBox(height: 2),
//   //                             Text(
//   //                               task.description,
//   //                               style: const TextStyle(
//   //                                   color: Colors.white, fontSize: 13),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                       const Spacer(
//   //                         flex: 1,
//   //                       ),
//   //                       IconButton(
//   //                         icon: const Icon(Icons.edit, color: Colors.white),
//   //                         onPressed: () {
//   //                           _showEditTaskScreen(context, task);

//   //                           // Handle edit action
//   //                         },
//   //                       ),
//   //                       IconButton(
//   //                         icon: const Icon(Icons.delete, color: Colors.white),
//   //                         onPressed: () {
//   //                           // Handle delete action
//   //                           setState(() {
//   //                             _tasks.remove(task);
//   //                           });
//   //                         },
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //           // const SizedBox(height: 8),
//   //           // Start Time Card
//   //         ],
//   //       ),
//   //     );
//   //   } else {
//   //     // Return an empty container if the task's date does not match the selected day name
//   //     return Container();
//   //   }
//   // }
//   Widget _buildTaskCard(Task task) {
//   // Check if the task's date matches the day name of the selected date
//   if (DateFormat('EEEE').format(task.day) ==
//       DateFormat('EEEE').format(_selectedDate)) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   side: const BorderSide(color: Colors.grey, width: 0.1),
//                 ),
//                 color: task.color,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       bottom: 5, left: 8, right: 8, top: 5),
//                   child: Text(
//                     '${_formatTime(task.startTime)}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               // const SizedBox(height: 5),
//               // End Time Card
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   side: const BorderSide(color: Colors.grey, width: 0.1),
//                 ),
//                 color: task.color,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       bottom: 5, left: 8, right: 8, top: 5),
//                   child: Text(
//                     '${_formatTime(task.endTime)}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Task Title Card
//           Expanded(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//                 side: const BorderSide(color: Colors.grey, width: 0.1),
//               ),
//               color: task.color,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Expanded(
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 23.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               task.title,
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 18),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               task.description,
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(
//                         flex: 1,
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.white),
//                         onPressed: () {
//                           // Handle edit action
//                           _showEditTaskScreen(context, task);
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.white),
//                         onPressed: () {
//                           // Handle delete action
//                           setState(() {
//                             _tasks.remove(task);
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // const SizedBox(height: 8),
//           // Start Time Card
//         ],
//       ),
//     );
//   } else {
//     // Return an empty container if the task's date does not match the selected day name
//     return Container();
//   }
// }


//   void _showAddTaskScreen(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AddTaskScreen(
//           onAddTask: _addTask,
//         );
//       },
//     );
//   }

//   // void _addTask(String title, String description, DateTime date,
//   //     TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
//   //   setState(() {
//   //     _tasks.add(Task(
//   //       title: title,
//   //       description: description,
//   //       day: date,
//   //       startTime: startTime,
//   //       endTime: endTime,
//   //       remindInterval: remindInterval,
//   //       color: color,
//   //     ));
//   //   });

//   //   // Perform any additional logic here (e.g., saving to a database)
//   // }
//   void _addTask(String title, String description, DateTime date,
//       TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
//     setState(() {
//       // Find the index of the task to be edited
//       int index = _tasks.indexWhere((task) => task.day == date && task.startTime == startTime && task.endTime == endTime);
      
//       if (index != -1) {
//         // Update the task at the found index with the new values
//         _tasks[index] = Task(
//           title: title,
//           description: description,
//           day: date,
//           startTime: startTime,
//           endTime: endTime,
//           remindInterval: remindInterval,
//           color: color,
//         );
//       } else {
//         // Add a new task if not found
//         _tasks.add(Task(
//           title: title,
//           description: description,
//           day: date,
//           startTime: startTime,
//           endTime: endTime,
//           remindInterval: remindInterval,
//           color: color,
//         ));
//       }
//     });
// }


//   String _formatTime(TimeOfDay timeOfDay) {
//     final time = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
//     return DateFormat.jm().format(time);
//   }

//   void _showEditTaskScreen(BuildContext context, Task task) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return EditTaskScreen(
//           task: task,
//           onUpdateTask: _updateTask,
//           onSaveTask: _saveTask,
//         );
//       },
//     );
//   }

//   void _updateTask(Task updatedTask) {
//     setState(() {
//       // Find the index of the task to be updated
//       final index = _tasks.indexWhere((task) =>
//           task.day == updatedTask.day &&
//           task.startTime == updatedTask.startTime);

//       // Replace the old task with the updated one
//       if (index != -1) {
//         _tasks[index] = updatedTask;
//       }
//     });
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SchedulePage(),
//   ));
// }



//    // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     IconButton(
//               //       icon: const Icon(Icons.arrow_back),
//               //       onPressed: () {
//               //         setState(() {
//               //           _currentDate = _currentDate.subtract(Duration(days: 7));
//               //         });
//               //       },
//               //     ),
//               //     Text(
//               //       DateFormat('MMM d, yyyy').format(startingDate),
//               //       style: const TextStyle(
//               //           fontSize: 18, fontWeight: FontWeight.bold),
//               //     ),
//               //     IconButton(
//               //       icon: const Icon(Icons.arrow_forward),
//               //       onPressed: () {
//               //         setState(() {
//               //           _currentDate = _currentDate.add(Duration(days: 7));
//               //         });
//               //       },
//               //     ),
//               //   ],
//               // ),
//               // SizedBox(
//               //   height: 70, // Adjusted height for the row of day cards
//               //   child: ListView(
//               //     scrollDirection: Axis.horizontal,
//               //     children: List.generate(
//               //       7, // Assuming you want to display 7 days (a week)
//               //       (index) =>
//               //           _buildDayCard(startingDate.add(Duration(days: index))),
//               //     ),
//               //   ),
//               // ),



//       // ListView(
//                 //   scrollDirection: Axis.horizontal,
//                 //   children: [
//                 //      _buildDayCard('Saturday'),
//                 //     _buildDayCard('Sunday'),
//                 //     _buildDayCard('Monday'),
//                 //     _buildDayCard('Tuesday'),
//                 //     _buildDayCard('Wednesday'),
//                 //     _buildDayCard('Thursday'),
//                 //     _buildDayCard('Friday'),

//                 //   ],
//                 // ),



// // Widget _buildTaskCard(Task task) {
// //   // Check if the task's date matches the day name of the selected date
// //   if (DateFormat('E').format(task.date) == DateFormat('E').format(_selectedDate)) {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 8, right: 10),
// //       child: GestureDetector(
// //         onTap: () {
// //           // Handle tapping on a task (if needed)
// //         },
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Column(
// //               children: [
// //                 Card(
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20.0),
// //                     side: const BorderSide(color: Colors.grey, width: 0.1),
// //                   ),
// //                   color: task.color,
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(
// //                         bottom: 5, left: 8, right: 8, top: 5),
// //                     child: Text(
// //                       '${_formatTime(task.startTime)}',
// //                       style: const TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //                 // const SizedBox(height: 5),
// //                 // End Time Card
// //                 Card(
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20.0),
// //                     side: const BorderSide(color: Colors.grey, width: 0.1),
// //                   ),
// //                   color: task.color,
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(
// //                         bottom: 5, left: 8, right: 8, top: 5),
// //                     child: Text(
// //                       '${_formatTime(task.endTime)}',
// //                       style: const TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),

// //             // Task Title Card
// //             Expanded(
// //               child: Card(
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20.0),
// //                   side: const BorderSide(color: Colors.grey, width: 0.1),
// //                 ),
// //                 color: task.color,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Row(
// //                     children: [
// //                       Expanded(
// //                         child: Padding(
// //                           padding: const EdgeInsets.only(left: 23.0),
// //                           child: Text(
// //                             task.title,
// //                             style: const TextStyle(color: Colors.white),
// //                           ),
// //                         ),
// //                       ),
// //                       IconButton(
// //                         icon: const Icon(Icons.edit, color: Colors.white),
// //                         onPressed: () {
// //                           // Handle edit action
// //                         },
// //                       ),
// //                       IconButton(
// //                         icon: const Icon(Icons.delete, color: Colors.white),
// //                         onPressed: () {
// //                           // Handle delete action
// //                           setState(() {
// //                             _tasks.remove(task);
// //                           });
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             // const SizedBox(height: 8),
// //             // Start Time Card
// //           ],
// //         ),
// //       ),
// //     );
// //   } else {
// //     // Return an empty container if the task's date does not match the selected day name
// //     return Container();
// //   }
// // }


//   // Widget _buildDayCard(DateTime day) {
//   //   // Logic to determine the day's label
//   //   String dayLabel = DateFormat('E').format(day);

//   //   return GestureDetector(
//   //     onTap: () {
//   //       setState(() {
//   //         _selectedDate = day; // Update the selected date
//   //       });
//   //       // You can add navigation or any other functionality here
//   //     },
//   //     child: Container(
//   //       width: 100, // Adjust the width according to your preference
//   //       height: 35, // Adjusted height
//   //       margin: const EdgeInsets.all(8),
//   //       decoration: BoxDecoration(
//   //         color: _selectedDate != null &&
//   //                 _selectedDate.year == day.year &&
//   //                 _selectedDate.month == day.month &&
//   //                 _selectedDate.day == day.day
//   //             ? const Color(0xFF3C8243) // Change color if selected
//   //             : Color.fromARGB(255, 235, 232, 231),
//   //         borderRadius: BorderRadius.circular(8),
//   //       ),
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         children: [
//   //           Text(
//   //             dayLabel,
//   //             style: TextStyle(
//   //               fontWeight: FontWeight.bold,
//   //               fontSize: 16,
//   //               color: _selectedDate != null &&
//   //                       _selectedDate.year == day.year &&
//   //                       _selectedDate.month == day.month &&
//   //                       _selectedDate.day == day.day
//   //                   ? Colors.white // Change text color if selected
//   //                   : Colors.black,
//   //             ),
//   //           ),
//   //           Text(
//   //             DateFormat('d').format(day),
//   //             style: TextStyle(
//   //               fontSize: 14,
//   //               color: _selectedDate != null &&
//   //                       _selectedDate.year == day.year &&
//   //                       _selectedDate.month == day.month &&
//   //                       _selectedDate.day == day.day
//   //                   ? Colors.white // Change text color if selected
//   //                   : Colors.black,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// // Widget _buildDayCard(String dayName) {
// //   return GestureDetector(
// //     onTap: () {
// //       setState(() {
// //         _selectedDay = dayName;
// //       });
// //     },
// //     child: Container(
// //       width: 100, // Adjust the width according to your preference
// //       height: 35, // Adjusted height
// //       margin: const EdgeInsets.all(8),
// //       decoration: BoxDecoration(
// //         color: _selectedDay == dayName
// //             ? const Color(0xFF3C8243) // Change color if selected
// //             : const Color.fromARGB(255, 235, 232, 231),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             dayName,
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 16,
// //               color: _selectedDay == dayName
// //                   ? Colors.white // Change text color if selected
// //                   : Colors.black,
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }







//   // Widget _buildTaskCard(Task task) {
//   //   // Check if the task date matches the selected date
//   //   if (task.date.year == _selectedDate.year &&
//   //       task.date.month == _selectedDate.month &&
//   //       task.date.day == _selectedDate.day) {
//   //     return Padding(
//   //       padding: const EdgeInsets.only(left: 8, right: 10),
//   //       child: Card(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(25.0),
//   //           side: const BorderSide(color: Colors.grey, width: 0.1),
//   //         ),
//   //         color: task.color,
//   //         child: ListTile(
//   //           title: Text(task.title),
//   //           subtitle: Text(
//   //               '${DateFormat('MMM d, yyyy').format(task.date)} | ${_formatTime(task.startTime)} - ${_formatTime(task.endTime)}'),
//   //           trailing: Row(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               IconButton(
//   //                 icon: const Icon(Icons.edit, color: Colors.white),
//   //                 onPressed: () {
//   //                   // Handle edit action
//   //                 },
//   //               ),
//   //               IconButton(
//   //                 icon: const Icon(Icons.delete, color: Colors.white),
//   //                 onPressed: () {
//   //                   // Handle delete action
//   //                   setState(() {
//   //                     _tasks.remove(task);
//   //                   });
//   //                 },
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );
//   //   } else {
//   //     // Return an empty container if the task does not match the selected date
//   //     return Container();
//   //   }
//   // }
// //   Widget _buildTaskCard(Task task) {
// //   // Check if the task date matches the selected date
// //   if (task.date.year == _selectedDate.year &&
// //       task.date.month == _selectedDate.month &&
// //       task.date.day == _selectedDate.day) {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 8, right: 10),
// //       child: Card(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(25.0),
// //           side: const BorderSide(color: Colors.grey, width: 0.1),
// //         ),
// //         color: task.color,
// //         child: ListTile(
// //           title: Text(task.title),
// //           subtitle: Text(
// //               '${DateFormat('MMM d, yyyy').format(task.date)} | ${_formatTime(task.startTime)} - ${_formatTime(task.endTime)}'),
// //           trailing: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               IconButton(
// //                 icon: const Icon(Icons.edit, color: Colors.white),
// //                 onPressed: () {
// //                   // Handle edit action
// //                 },
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.delete, color: Colors.white),
// //                 onPressed: () {
// //                   // Handle delete action
// //                   setState(() {
// //                     _tasks.remove(task);
// //                   });
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   } else {
// //     // Return an empty container if the task does not match the selected date
// //     return Container();
// //   }
// // }
// // Widget _buildTaskCard(Task task) {
// //   // Check if the task's date matches the day name of the selected date
// //   if (DateFormat('EEEE').format(task.date) == DateFormat('EEEE').format(_selectedDate)) {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 8, right: 10),
// //       child: Card(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(25.0),
// //           side: const BorderSide(color: Colors.grey, width: 0.1),
// //         ),
// //         color: task.color,
// //         child: ListTile(
// //           title: Text(task.title),
// //           subtitle: Text(
// //               '${DateFormat('MMM d, yyyy').format(task.date)} | ${_formatTime(task.startTime)} - ${_formatTime(task.endTime)}'),
// //           trailing: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               IconButton(
// //                 icon: const Icon(Icons.edit, color: Colors.white),
// //                 onPressed: () {
// //                   // Handle edit action
// //                 },
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.delete, color: Colors.white),
// //                 onPressed: () {
// //                   // Handle delete action
// //                   setState(() {
// //                     _tasks.remove(task);
// //                   });
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   } else {
// //     // Return an empty container if the task's date does not match the selected day name
// //     return Container();
// //   }
// // }
//   // Widget _buildTaskCard(Task task) {
//   //   // Check if the task's date matches the day name of the selected date
//   //   if (DateFormat('EEEE').format(task.date) ==
//   //       DateFormat('EEEE').format(_selectedDate)) {
//   //     return Padding(
//   //       padding: const EdgeInsets.only(left: 8, right: 10),
//   //       child: Card(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(25.0),
//   //           side: const BorderSide(color: Colors.grey, width: 0.1),
//   //         ),
//   //         // color: task.color,
//   //         child: Row(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Column(
//   //               children: [
//   //                 Card(
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(25.0),
//   //                     side: const BorderSide(color: Colors.grey, width: 0.1),
//   //                   ),
//   //                   color: task.color,
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.only(
//   //                         bottom: 5, left: 8, right: 8, top: 5),
//   //                     child: Text(
//   //                       '${_formatTime(task.startTime)}',
//   //                       style: const TextStyle(color: Colors.white),
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 // const SizedBox(height: 5),
//   //                 // End Time Card
//   //                 Card(
//   //                   shape: RoundedRectangleBorder(
//   //                     borderRadius: BorderRadius.circular(25.0),
//   //                     side: const BorderSide(color: Colors.grey, width: 0.1),
//   //                   ),
//   //                   color: task.color,
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.only(
//   //                         bottom: 5, left: 8, right: 8, top: 5),
//   //                     child: Text(
//   //                       '${_formatTime(task.endTime)}',
//   //                       style: const TextStyle(color: Colors.white),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),

//   //             // Task Title Card
//   //             Card(
//   //               shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(25.0),
//   //                 side: const BorderSide(color: Colors.grey, width: 0.1),
//   //               ),
//   //               color: task.color,
//   //               child: Padding(
//   //                 padding: const EdgeInsets.all(8.0),
//   //                 child: Text(
//   //                   task.title,
//   //                   style: const TextStyle(color: Colors.white),
//   //                 ),
//   //               ),
//   //             ),
//   //             // const SizedBox(height: 8),
//   //             // Start Time Card
//   //           ],
//   //         ),
//   //       ),
//   //     );
//   //   } else {
//   //     // Return an empty container if the task's date does not match the selected day name
//   //     return Container();
//   //   }
//   // }




// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'addTask.dart';

// // class SchedulePage extends StatefulWidget {
// //   @override
// //   _SchedulePageState createState() => _SchedulePageState();
// // }

// // class _SchedulePageState extends State<SchedulePage> {
// //   DateTime _currentDate = DateTime.now();
// //   DateTime _selectedDate= DateTime.now();
// //   late String _taskTitle;
// //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// //   int _remindInterval = 15; // Default reminder interval in minutes
// //   Color _taskColor = Colors.yellow;

// //   @override
// //   Widget build(BuildContext context) {
// //     // Calculate the starting date to be the previous Saturday
// //     DateTime startingDate = _currentDate.subtract(Duration(days: _currentDate.weekday - 6));

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Schedule'),
// //       ),
// //       body: Stack(
// //         children: [
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   IconButton(
// //                     icon: Icon(Icons.arrow_back),
// //                     onPressed: () {
// //                       setState(() {
// //                         _currentDate = _currentDate.subtract(Duration(days: 7));
// //                       });
// //                     },
// //                   ),
// //                   Text(
// //                     DateFormat('MMM d, yyyy').format(startingDate),
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   IconButton(
// //                     icon: Icon(Icons.arrow_forward),
// //                     onPressed: () {
// //                       setState(() {
// //                         _currentDate = _currentDate.add(Duration(days: 7));
// //                       });
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: 70, // Adjusted height for the row of day cards
// //                 child: ListView(
// //                   scrollDirection: Axis.horizontal,
// //                   children: List.generate(
// //                     7, // Assuming you want to display 7 days (a week)
// //                     (index) => _buildDayCard(startingDate.add(Duration(days: index))),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Align(
// //             alignment: Alignment.bottomRight,
// //             child: Padding(
// //               padding: EdgeInsets.all(16.0),
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   _showAddTaskScreen(context);
// //                 },
// //                 child: Text('Add Work'),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildDayCard(DateTime day) {
// //     // Logic to determine the day's label
// //     String dayLabel = DateFormat('E').format(day);

// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           _selectedDate = day; // Update the selected date
// //         });
// //         // You can add navigation or any other functionality here
// //       },
// //       child: Container(
// //         width: 100, // Adjust the width according to your preference
// //         height: 35, // Adjusted height
// //         margin: EdgeInsets.all(8),
// //         decoration: BoxDecoration(
// //           color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
// //               ? Colors.blueAccent // Change color if selected
// //               : Colors.blueGrey[100],
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               dayLabel,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 16,
// //                 color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
// //                     ? Colors.white // Change text color if selected
// //                     : Colors.black,
// //               ),
// //             ),
// //             Text(
// //               DateFormat('d').format(day),
// //               style: TextStyle(
// //                 fontSize: 14,
// //                 color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
// //                     ? Colors.white // Change text color if selected
// //                     : Colors.black,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showAddTaskScreen(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AddTaskScreen(
// //           onAddTask: _addTask,
// //         );
// //       },
// //     );
// //   }

// //   void _addTask(String title, DateTime date, TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
// //     setState(() {
// //       _taskTitle = title;
// //       _selectedDate = date;
// //       _startTime = startTime;
// //       _endTime = endTime;
// //       _remindInterval = remindInterval;
// //       _taskColor = color;
// //     });

// //     // Perform any additional logic here (e.g., saving to a database)
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: SchedulePage(),
// //   ));
// // }
