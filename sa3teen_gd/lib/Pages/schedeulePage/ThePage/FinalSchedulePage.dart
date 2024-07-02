import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/EditTaskScreen.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/addScheduleTask.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

import '../../../Services/API_services.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int remindInterval;
  final Color color;

  Task({
     this.id,
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
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  int _remindInterval = 15; // Default reminder interval in minutes
  Color _taskColor = Colors.yellow;
  Api_services api_services = Api_services();
  List<Map<String, dynamic>> listSchedule = [];
  List<Task> _tasks = [];



  List<Color> _colors = [
    const Color.fromARGB(218, 255, 219, 88),
    const Color.fromARGB(255, 232, 109, 101),
    const Color.fromARGB(255, 130, 174, 250),
    const Color.fromARGB(255, 148, 244, 150),
    const Color.fromARGB(255, 202, 130, 250)
  ];

  int _selectedColorIndex = 0;



  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late String _taskTitleedit;
  late String _description;
  late String _selectedDay;
  late TimeOfDay _startTimeedit;
  late TimeOfDay _endTimeedit;


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
    List<Map<String, dynamic>> _tasks =
        await api_services.listSchedule(accessToken);
    setState(() {
      listSchedule = _tasks;
      print(
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
      print(listSchedule[selecteditem]['day']);

      print(
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
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
                    return _buildTaskCard(listSchedule[index]);
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
              : const Color.fromARGB(255, 235, 232, 231),
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
    if ((listSchedule['day']) == getDayName(_selectedDate)) {
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
                  color: hexToColor(listSchedule['color']),
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
                  color: hexToColor(listSchedule['color']),
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
                color: hexToColor(listSchedule['color']),
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
                        onPressed: () async {
                          print(listSchedule['id']);
                          print(listSchedule['title']);
                          print(listSchedule['day']);
                          print(listSchedule['start_time']);
                          print(listSchedule['end_time']);
                          print(listSchedule['description']);
                          print(listSchedule['reminder_time']);
                          print(listSchedule['color']);



                          // await api_services.UpdateSlot(
                          //   listSchedule[selecteditem]['id'] as int, // Assuming Task has an id field
                          //   _titleController.text,
                          //   _selectedDay,
                          //   _formatTimeOfDay(_startTime),
                          //   _formatTimeOfDay(_endTime),
                          //   _descriptionController.text,
                          //   _remindInterval,
                          //   colorToHex(_taskColor), // Convert color to string
                          //   accessToken, // Pass the accessToken
                          // );




                          // AlertDialog(
                          //   title: const Text('Edit Slot'),
                          //   content: SingleChildScrollView(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           child: TextFormField(
                          //             controller: _titleController,
                          //             decoration: InputDecoration(
                          //               labelText: 'Title',
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.circular(10)),
                          //               contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          //             ),
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 _taskTitle = value;
                          //               });
                          //             },
                          //           ),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         Container(
                          //           child: TextFormField(
                          //             controller: _descriptionController,
                          //             decoration: InputDecoration(
                          //               labelText: 'Description',
                          //               border: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.circular(10)),
                          //               contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          //             ),
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 _description = value;
                          //               });
                          //             },
                          //           ),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         TextFormField(
                          //           controller: _startTimeController,
                          //           readOnly: true,
                          //           onTap: () => _selectTime(context, true),
                          //           decoration: InputDecoration(
                          //             labelText: 'Start Time',
                          //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          //             suffixIcon: const Icon(Icons.access_time),
                          //           ),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         TextFormField(
                          //           controller: _endTimeController,
                          //           readOnly: true,
                          //           onTap: () => _selectTime(context, false),
                          //           decoration: InputDecoration(
                          //             labelText: 'End Time',
                          //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          //             suffixIcon: const Icon(Icons.access_time),
                          //           ),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         DropdownButtonFormField<String>(
                          //           value: _selectedDay,
                          //           items: [
                          //             'Sunday',
                          //             'Monday',
                          //             'Tuesday',
                          //             'Wednesday',
                          //             'Thursday',
                          //             'Friday',
                          //             'Saturday',
                          //           ].map((day) {
                          //             return DropdownMenuItem<String>(
                          //               value: day,
                          //               child: Text(day),
                          //             );
                          //           }).toList(),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               _selectedDay = value!;
                          //             });
                          //           },
                          //           decoration: const InputDecoration(labelText: 'Day'),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         DropdownButtonFormField<int>(
                          //           value: _remindInterval,
                          //           items: [5, 10, 15, 30, 60].map((interval) {
                          //             return DropdownMenuItem<int>(
                          //               value: interval,
                          //               child: Text('$interval minutes'),
                          //             );
                          //           }).toList(),
                          //           onChanged: (value) {
                          //             setState(() {
                          //               _remindInterval = value!;
                          //             });
                          //           },
                          //           decoration: const InputDecoration(labelText: 'Reminder Interval'),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         Row(
                          //           children: _colors
                          //               .asMap()
                          //               .entries
                          //               .map(
                          //                 (entry) => GestureDetector(
                          //               onTap: () {
                          //                 setState(() {
                          //                   _selectedColorIndex = entry.key;
                          //                   _taskColor = entry.value;
                          //                 });
                          //               },
                          //               child: Container(
                          //                 width: 40,
                          //                 height: 40,
                          //                 margin: const EdgeInsets.symmetric(horizontal: 5),
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: entry.value,
                          //                   border: Border.all(
                          //                       color: _selectedColorIndex == entry.key
                          //                           ? Colors.black
                          //                           : Colors.transparent),
                          //                 ),
                          //                 child: _selectedColorIndex == entry.key
                          //                     ? const Icon(Icons.check, color: Colors.white)
                          //                     : null,
                          //               ),
                          //             ),
                          //           )
                          //               .toList(),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   actions: <Widget>[
                          //     TextButton(
                          //       onPressed: () {
                          //         Navigator.of(context).pop();
                          //       },
                          //       child: const Text(
                          //         'Cancel',
                          //         style: TextStyle(color: Color(0xFF3C8243)),
                          //       ),
                          //     ),
                          //     ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: const Color(0xFF3C8243),
                          //       ),
                          //       onPressed: () async {
                          //         final selectedDate = _getDateFromDay(_selectedDay);
                          //         if (selectedDate != null && _titleController.text.isNotEmpty) {
                          //           print('Selected Date: $selectedDate');
                          //           print('Title: ${_titleController.text}');
                          //           print('Description: ${_descriptionController.text}');
                          //           print('Day: $_selectedDay');
                          //           print('Start Time: ${_formatTimeOfDay(_startTime)}');
                          //           print('End Time: ${_formatTimeOfDay(_endTime)}');
                          //           print('Remind Interval: $_remindInterval');
                          //           print('Color: ${colorToHex(_taskColor)}');
                          //           print('Access Token: $accessToken');
                          //
                          //           try {
                          //             await api_services.UpdateSlot(
                          //               listSchedule[selecteditem]['id'] as int, // Assuming Task has an id field
                          //               _titleController.text,
                          //               _selectedDay,
                          //               _formatTimeOfDay(_startTime),
                          //               _formatTimeOfDay(_endTime),
                          //               _descriptionController.text,
                          //               _remindInterval,
                          //               colorToHex(_taskColor), // Convert color to string
                          //               accessToken, // Pass the accessToken
                          //             );
                          //
                          //             // Print to verify the updated state before navigation
                          //             print('Task updated successfully');
                          //             Navigator.of(context).pop();
                          //           } catch (e) {
                          //             print('Error updating task: $e');
                          //           }
                          //         } else {
                          //           print('Please select a day and enter a title');
                          //         }
                          //       },
                          //       child: const Text(
                          //         'Save',
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //     ),
                          //   ],
                          // );




                           _showEditTaskScreen(context, listSchedule);
                          // Api_services.UpdateSlot(
                          //     listSchedule['id'],
                          //     ,
                          //     listSchedule['day'],
                          //     listSchedule['start_time'],
                          //     listSchedule['end_time'],
                          //     listSchedule['description'],
                          //     listSchedule['reminder_time'],
                          //     listSchedule['color'],
                          //     accessToken);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          //
                          // print('111111111111111111111111111111111111111111111');
                          // api_services.DeleteSlot(listSchedule['id'], accessToken);
                          // print(listSchedule['id']);

                          setState(() {
                            api_services.DeleteSlot(
                                listSchedule['id'], accessToken);
                            print(
                                '2222222222222222222222222222222222222222222');
                            print(listSchedule['id']);
                            print(
                                '2222222222222222222222222222222222222222222');
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
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          _startTimeController.text = _formatTimeOfDay(_startTime);
        } else {
          _endTime = picked;
          _endTimeController.text = _formatTimeOfDay(_endTime);
        }
      });
    }
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

  void _showEditTaskScreen(
      BuildContext context, Map<String, dynamic> listSchedule) {
    // Create a new Task object from the listSchedule data
    final task = Task(
      id: listSchedule['id'] as int,
      title: listSchedule['title'] as String,
      description: listSchedule['description'] as String,
      day: _parseDayOfWeek(
          listSchedule['day'] ), // Parse the day of the week
      startTime: TimeOfDay(
        hour: int.parse(listSchedule['start_time'].split(':')[0]),
        minute: int.parse(listSchedule['start_time'].split(':')[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(listSchedule['end_time'].split(':')[0]),
        minute: int.parse(listSchedule['end_time'].split(':')[1]),
      ),
      remindInterval: listSchedule['reminder_time'] as int,
      color: Color(
          int.parse(listSchedule['color'].replaceAll('#', ''), radix: 16)),
    );

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

  DateTime _parseDayOfWeek(String dayOfWeek) {
    final now = DateTime.now();
    final weekdays = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];
    final index = weekdays.indexOf(dayOfWeek);
    if (index == -1) {
      throw ArgumentError('Invalid day of the week: ${dayOfWeek}');
    }
    return DateTime(now.year, now.month, now.day + (index - now.weekday));
  }

  // void _updateTask(Task updatedTask) {
  //   setState(() {
  //     Api_services.UpdateSlot(
  //         _tasks.indexOf(updatedTask),
  //         updatedTask.title,
  //         getDayName(updatedTask.day),
  //         updatedTask.startTime as String,
  //         updatedTask.endTime as String,
  //         updatedTask.description,
  //         updatedTask.remindInterval,
  //
  //
  //         updatedTask.color as String,
  //         accessToken);
  //     // Find the index of the task to be updated
  //     final index = _tasks.indexWhere((task) =>
  //         task.day == updatedTask.day &&
  //         task.startTime == updatedTask.startTime);
  //
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
      print(
          '88888888888888888888888888888888888888888888888888888888777777777777777777776666666666666');

      print(listSchedule[selecteditem]['id']);

      print(_tasks.indexOf(updatedTask));
      print(updatedTask.title);
      print(getDayName(updatedTask.day));
      print(_formatTimeOfDay(updatedTask.startTime));
      print(_formatTimeOfDay(updatedTask.endTime));
      print(updatedTask.description);
      print(updatedTask.remindInterval);
      print(colorToHex(updatedTask.color));
      print(accessToken);
      print(
          '888888888888888888888888888888888888888888888887777777777777777777776666666666666666666  ');
      // Update the task in the API
      // the time didnot change
      // the day shown in the list didnot change
      // Api_services.UpdateSlot(
      //   listSchedule[selecteditem]['id'],
      //   updatedTask.title,
      //   getDayName(_parseDayOfWeek(updatedTask.day.toString())),
      //   _formatTimeOfDay(updatedTask.startTime),
      //   _formatTimeOfDay(updatedTask.endTime),
      //   updatedTask.description,
      //   updatedTask.remindInterval,
      //   colorToHex(updatedTask.color),
      //   accessToken,
      // );
    });
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }
  DateTime? _getDateFromDay(String day) {
    final now = DateTime.now();
    final weekday = now.weekday;
    final daysToAdd = _getDaysToAdd(day);
    final selectedDate = now.add(Duration(days: daysToAdd - weekday));
    return selectedDate;
  }



  int _getDaysToAdd(String day) {
    switch (day) {
      case 'Monday':
        return DateTime.monday;
      case 'Tuesday':
        return DateTime.tuesday;
      case 'Wednesday':
        return DateTime.wednesday;
      case 'Thursday':
        return DateTime.thursday;
      case 'Friday':
        return DateTime.friday;
      case 'Saturday':
        return DateTime.saturday;
      case 'Sunday':
        return DateTime.sunday;
      default:
        return 0;
    }
  }
  void _saveTask(String title, String description, DateTime date,
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
}
