import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/schedeulePage/Widgets%20copy/customAppBar.dart';
import 'package:intl/intl.dart';
import 'addScheduleTask.dart';

class Task {
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int remindInterval;
  final Color color;

  Task({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remindInterval,
    required this.color, required String id, required taskName, DateTime? deadline,
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
      // appBar: AppBar(
      //   title: Text('Schedule'),
      // ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const customAppBar(title: 'Schedule',),
              const SizedBox(
                height: 9,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        _currentDate = _currentDate.subtract(Duration(days: 7));
                      });
                    },
                  ),
                  Text(
                    DateFormat('MMM d, yyyy').format(startingDate),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        _currentDate = _currentDate.add(Duration(days: 7));
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 70, // Adjusted height for the row of day cards
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    7, // Assuming you want to display 7 days (a week)
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
                child: const Text('Add Work'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(DateTime day) {
    // Logic to determine the day's label
    String dayLabel = DateFormat('E').format(day);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = day; // Update the selected date
        });
        // You can add navigation or any other functionality here
      },
      child: Container(
        width: 100, // Adjust the width according to your preference
        height: 35, // Adjusted height
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _selectedDate != null &&
                  _selectedDate.year == day.year &&
                  _selectedDate.month == day.month &&
                  _selectedDate.day == day.day
              ? const Color(0xFF3C8243) // Change color if selected
              : const Color.fromARGB(255, 162, 112, 94),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _selectedDate != null &&
                        _selectedDate.year == day.year &&
                        _selectedDate.month == day.month &&
                        _selectedDate.day == day.day
                    ? Colors.white // Change text color if selected
                    : Colors.black,
              ),
            ),
            Text(
              DateFormat('d').format(day),
              style: TextStyle(
                fontSize: 14,
                color: _selectedDate != null &&
                        _selectedDate.year == day.year &&
                        _selectedDate.month == day.month &&
                        _selectedDate.day == day.day
                    ? Colors.white // Change text color if selected
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTaskCard(Task task) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8,right: 10),
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(25.0),
  //       side: BorderSide(color: Colors.grey, width: 0.1),),
  //       color: task.color,
  //       child: ListTile(
  //         title: Text(task.title),
  //         subtitle: Text('${DateFormat('MMM d, yyyy').format(task.date)} | ${_formatTime(task.startTime)} - ${_formatTime(task.endTime)}'),
  //         trailing: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             IconButton(
  //               icon: Icon(Icons.edit, color: Colors.white),
  //               onPressed: () {
  //                 // Handle edit action
  //               },
  //             ),
  //             IconButton(
  //               icon: Icon(Icons.delete, color: Colors.white),
  //               onPressed: () {
  //                 // Handle delete action
  //                 setState(() {
  //                   _tasks.remove(task);
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTaskCard(Task task) {
    // Check if the task date matches the selected date
    if (task.date.year == _selectedDate.year &&
        task.date.month == _selectedDate.month &&
        task.date.day == _selectedDate.day) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: const BorderSide(color: Colors.grey, width: 0.1),
          ),
          color: task.color,
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(
                '${DateFormat('MMM d, yyyy').format(task.date)} | ${_formatTime(task.startTime)} - ${_formatTime(task.endTime)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Handle edit action
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
      );
    } else {
      // Return an empty container if the task does not match the selected date
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

  void _addTask(String title, DateTime date, TimeOfDay startTime,
      TimeOfDay endTime, int remindInterval, Color color) {
    setState(() {
      _tasks.add(Task(
        title: title,
        date: date,
        startTime: startTime,
        endTime: endTime,
        remindInterval: remindInterval,
        color: color, id: '', taskName: null,
      ));
    });

    // Perform any additional logic here (e.g., saving to a database)
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final time = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.jm().format(time);
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SchedulePage(),
  ));
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'addTask.dart';

// class SchedulePage extends StatefulWidget {
//   @override
//   _SchedulePageState createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> {
//   DateTime _currentDate = DateTime.now();
//   DateTime _selectedDate= DateTime.now();
//   late String _taskTitle;
//   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
//   int _remindInterval = 15; // Default reminder interval in minutes
//   Color _taskColor = Colors.yellow;

//   @override
//   Widget build(BuildContext context) {
//     // Calculate the starting date to be the previous Saturday
//     DateTime startingDate = _currentDate.subtract(Duration(days: _currentDate.weekday - 6));

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule'),
//       ),
//       body: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       setState(() {
//                         _currentDate = _currentDate.subtract(Duration(days: 7));
//                       });
//                     },
//                   ),
//                   Text(
//                     DateFormat('MMM d, yyyy').format(startingDate),
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.arrow_forward),
//                     onPressed: () {
//                       setState(() {
//                         _currentDate = _currentDate.add(Duration(days: 7));
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 70, // Adjusted height for the row of day cards
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: List.generate(
//                     7, // Assuming you want to display 7 days (a week)
//                     (index) => _buildDayCard(startingDate.add(Duration(days: index))),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () {
//                   _showAddTaskScreen(context);
//                 },
//                 child: Text('Add Work'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayCard(DateTime day) {
//     // Logic to determine the day's label
//     String dayLabel = DateFormat('E').format(day);

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedDate = day; // Update the selected date
//         });
//         // You can add navigation or any other functionality here
//       },
//       child: Container(
//         width: 100, // Adjust the width according to your preference
//         height: 35, // Adjusted height
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
//               ? Colors.blueAccent // Change color if selected
//               : Colors.blueGrey[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               dayLabel,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
//                     ? Colors.white // Change text color if selected
//                     : Colors.black,
//               ),
//             ),
//             Text(
//               DateFormat('d').format(day),
//               style: TextStyle(
//                 fontSize: 14,
//                 color: _selectedDate != null && _selectedDate.year == day.year && _selectedDate.month == day.month && _selectedDate.day == day.day
//                     ? Colors.white // Change text color if selected
//                     : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

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

//   void _addTask(String title, DateTime date, TimeOfDay startTime, TimeOfDay endTime, int remindInterval, Color color) {
//     setState(() {
//       _taskTitle = title;
//       _selectedDate = date;
//       _startTime = startTime;
//       _endTime = endTime;
//       _remindInterval = remindInterval;
//       _taskColor = color;
//     });

//     // Perform any additional logic here (e.g., saving to a database)
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: SchedulePage(),
//   ));
// }
