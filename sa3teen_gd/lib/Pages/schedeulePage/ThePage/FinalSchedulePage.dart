import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/EditTaskScreen.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/addScheduleTask.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

import '../../../Services/API_services.dart';

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
  Api_services api_services = Api_services();
  List<Map<String, dynamic>> listSchedule = [];
  List<Task> _tasks = [];
  int selecteditem = 0;
  void initState() {
    super.initState();
    _fetchToDoList();
  }
  String colorToHex(Color color) {
    return '#${color.alpha.toRadixString(16).padLeft(2, '0')}${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }
  Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString; // Add FF for the alpha value if not present
    }
    return Color(int.parse(hexString, radix: 16));
  }
  String getDayName(DateTime dateTime) {
    return DateFormat.EEEE().format(dateTime);
  }
  Future<void> _fetchToDoList() async {
    List<Map<String, dynamic>> _tasks = await api_services.listSchedule(accessToken);
    setState(() {
      listSchedule = _tasks;
      print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      print(listSchedule[selecteditem]['day']);

      print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    });
  }

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
              const CustomAppBar(
                title: 'Schedule',
              ),
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

                  itemCount: listSchedule.length,
                  itemBuilder: (context, index) {
                    selecteditem = index;
                    return _buildTaskCard(

                        listSchedule[index] );
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
                child: const Text(
                  'Add lecture time',
                  style: TextStyle(color: Colors.white),
                ),
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

  Widget _buildTaskCard(listSchedule) {

    // Check if the task's date matches the day name of the selected date
    if ((listSchedule['day']) ==
       getDayName(_selectedDate)) {
      print('888888888888888888888888888888888888888888888888888888888');
      print(listSchedule['day']);
      print('888888888888888888888888888888888888888888888888888888888');
      print(listSchedule['day']);

      print('888888888888888888888888888888888888888888888888888888888');

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
                  color:hexToColor (listSchedule['color']),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 8, right: 8, top: 5),
                    child: Text(
                      '${(listSchedule['start_time'])}',
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
                  color: hexToColor (listSchedule['color']),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 8, right: 8, top: 5),
                    child: Text(
                      '${(listSchedule['end_time'])}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // Ensure Expanded is directly inside Row
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.grey, width: 0.1),
                ),
                color:hexToColor (listSchedule['color']),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // Ensure Row is here
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listSchedule['title'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              listSchedule['description'],
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
                          // Api_services.UpdateSlot(
                          //     listSchedule['id'],
                          //     listSchedule['title'],
                          //     listSchedule['day'],
                          //     listSchedule['start_time'],
                          //     listSchedule['end_time'],
                          //     listSchedule['description'],
                          //     listSchedule['reminder_time'],
                          //
                          //
                          //     listSchedule['color'],accessToken);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          //
                          // print('111111111111111111111111111111111111111111111');
                          // api_services.DeleteSlot(listSchedule['id'], accessToken);
                          // print(listSchedule['id']);
                          // print('111111111111111111111111111111111111111111111');
                          setState(() {

                          api_services.DeleteSlot(listSchedule['id'], accessToken);
                          print('2222222222222222222222222222222222222222222');
                          print(listSchedule['id']);
                          print('2222222222222222222222222222222222222222222');

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
    Navigator.of(context).pop();
  }
}
