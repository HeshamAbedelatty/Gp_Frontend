import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AddTaskScreen extends StatefulWidget {
  final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

  const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String _taskTitle;
  late String _selectedDay;
  TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
  int _remindInterval = 15; // Default reminder interval in minutes
  Color _taskColor = Color.fromARGB(218, 255, 219, 88);

  late TextEditingController _titleController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  List<Color> _colors = [
    Color.fromARGB(218, 255, 219, 88),
    const Color.fromARGB(255, 232, 109, 101),
    const Color.fromARGB(255, 130, 174, 250)
  ];
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _selectedDay = DateFormat('EEEE').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (value) {
                  setState(() {
                    _taskTitle = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDay,
              items: [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday',
              ].map((day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDay = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Day'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, true),
              decoration: InputDecoration(
                labelText: 'Start Time',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _endTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, false),
              decoration: InputDecoration(
                labelText: 'End Time',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: _remindInterval,
              items: [5, 10, 15, 30, 60].map((interval) {
                return DropdownMenuItem<int>(
                  value: interval,
                  child: Text('$interval minutes'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _remindInterval = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Reminder Interval'),
            ),
            const SizedBox(height: 10),
            Row(
              children: _colors
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColorIndex = entry.key;
                          _taskColor = entry.value;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: entry.value,
                          border: Border.all(
                              color: _selectedColorIndex == entry.key
                                  ? Colors.black
                                  : Colors.transparent),
                        ),
                        child: _selectedColorIndex == entry.key
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF3C8243)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3C8243),
          ),
          onPressed: () {
            // Perform add task operation
            final selectedDate = _getDateFromDay(_selectedDay);
            if (selectedDate != null && _taskTitle != null) {
              widget.onAddTask(
                _taskTitle,
                selectedDate,
                _startTime,
                _endTime,
                _remindInterval,
                _taskColor,
              );
              Navigator.of(context).pop();
            } else {
              print('Please select a day and enter a title');
            }
          },
          child: Text('Add'),
        ),
      ],
    );
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

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.Hm().format(dateTime);
  }
}

// class AddTaskScreen extends StatefulWidget {
//   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

//   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   late String _taskTitle;
//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
//   int _remindInterval = 15; // Default reminder interval in minutes
//   Color _taskColor = Color.fromARGB(218, 255, 219, 88);

//   late TextEditingController _titleController;
//   late TextEditingController _dateController;
//   late TextEditingController _startTimeController;
//   late TextEditingController _endTimeController;

//   List<Color> _colors = [
//     Color.fromARGB(218, 255, 219, 88),
//     const Color.fromARGB(255, 232, 109, 101),
//     const Color.fromARGB(255, 130, 174, 250)
//   ];
//   int _selectedColorIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController();
//     _dateController = TextEditingController(
//         text: DateFormat('MM/dd/yyyy').format(_selectedDate));
//     _startTimeController = TextEditingController();
//     _endTimeController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Task'),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _taskTitle = value;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               // decoration: BoxDecoration(
//               //   borderRadius: BorderRadius.circular(10),
//               //   border: Border.all(color: Colors.grey),
//               // ),
//               child: TextFormField(
//                 controller: _dateController,
//                 readOnly: true,
//                 onTap: () => _selectDate(context),
//                 decoration: InputDecoration(
//                   labelText: 'Date',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                   suffixIcon: const Icon(Icons.calendar_today),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _startTimeController,
//               readOnly: true,
//               onTap: () => _selectTime(context, true),
//               decoration: InputDecoration(
//                 labelText: 'Start Time',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: const Icon(Icons.access_time),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _endTimeController,
//               readOnly: true,
//               onTap: () => _selectTime(context, false),
//               decoration: InputDecoration(
//                 labelText: 'End Time',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: const Icon(Icons.access_time),
//               ),
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<int>(
//               value: _remindInterval,
//               items: [5, 10, 15, 30, 60].map((interval) {
//                 return DropdownMenuItem<int>(
//                   value: interval,
//                   child: Text('$interval minutes'),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _remindInterval = value!;
//                 });
//               },
//               decoration: const InputDecoration(labelText: 'Reminder Interval'),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: _colors
//                   .asMap()
//                   .entries
//                   .map(
//                     (entry) => GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedColorIndex = entry.key;
//                           _taskColor = entry.value;
//                         });
//                       },
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         margin: EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: entry.value,
//                           border: Border.all(
//                               color: _selectedColorIndex == entry.key
//                                   ? Colors.black
//                                   : Colors.transparent),
//                         ),
//                         child: _selectedColorIndex == entry.key
//                             ? const Icon(Icons.check, color: Colors.white)
//                             : null,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text(
//             'Cancel',
//             style: TextStyle(color: Color(0xFF3C8243)),
//           ),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF3C8243),
//           ),
//           onPressed: () {
//             // Perform add task operation
//             if (_selectedDate != null && _taskTitle != null) {
//               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime,
//                   _remindInterval, _taskColor);
//               Navigator.of(context).pop();
//             } else {
//               print('Please select a date and enter a title');
//             }
//           },
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: isStartTime ? _startTime : _endTime,
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartTime) {
//           _startTime = picked;
//           _startTimeController.text = _formatTimeOfDay(_startTime);
//         } else {
//           _endTime = picked;
//           _endTimeController.text = _formatTimeOfDay(_endTime);
//         }
//       });
//     }
//   }

//   String _formatTimeOfDay(TimeOfDay timeOfDay) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//         now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//     return DateFormat.Hm().format(dateTime);
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AddTaskScreen extends StatefulWidget {
//   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

//   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }

// class _AddTaskScreenState extends State<AddTaskScreen> {
//   late String _taskTitle;
//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
//   int _remindInterval = 15; // Default reminder interval in minutes
//   Color _taskColor = Colors.yellow;

//   late TextEditingController _titleController;
//   late TextEditingController _dateController;
//   late TextEditingController _startTimeController;
//   late TextEditingController _endTimeController;

//   List<Color> _colors = [Colors.yellow, Colors.red, Colors.blueAccent];
//   int _selectedColorIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController();
//     _dateController = TextEditingController(
//         text: DateFormat('MM/dd/yyyy').format(_selectedDate));
//     _startTimeController = TextEditingController();
//     _endTimeController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add Task'),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _taskTitle = value;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: TextFormField(
//                 controller: _dateController,
//                 readOnly: true,
//                 onTap: () => _selectDate(context),
//                 decoration: InputDecoration(
//                   labelText: 'Date',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _startTimeController,
//               readOnly: true,
//               onTap: () => _selectTime(context, true),
//               decoration: InputDecoration(
//                 labelText: 'Start Time',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: Icon(Icons.access_time),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _endTimeController,
//               readOnly: true,
//               onTap: () => _selectTime(context, false),
//               decoration: InputDecoration(
//                 labelText: 'End Time',
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: Icon(Icons.access_time),
//               ),
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<int>(
//               value: _remindInterval,
//               items: [15, 30, 45, 60].map((interval) {
//                 return DropdownMenuItem<int>(
//                   value: interval,
//                   child: Text('$interval minutes'),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _remindInterval = value!;
//                 });
//               },
//               decoration: InputDecoration(labelText: 'Reminder Interval'),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: _colors
//                   .asMap()
//                   .entries
//                   .map(
//                     (entry) => GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _selectedColorIndex = entry.key;
//                           _taskColor = entry.value;
//                         });
//                       },
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         margin: EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: entry.value,
//                           border: Border.all(
//                               color: _selectedColorIndex == entry.key
//                                   ? Colors.black
//                                   : Colors.transparent),
//                         ),
//                         child: _selectedColorIndex == entry.key
//                             ? Icon(Icons.check, color: Colors.white)
//                             : null,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Perform add task operation
//             if (_selectedDate != null && _taskTitle != null) {
//               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime,
//                   _remindInterval, _taskColor);
//               Navigator.of(context).pop();
//             } else {
//               print('Please select a date and enter a title');
//             }
//           },
//           child: Text('Add'),
//         ),
//       ],
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: isStartTime ? _startTime : _endTime,
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartTime) {
//           _startTime = picked;
//           _startTimeController.text = _formatTimeOfDay(_startTime);
//         } else {
//           _endTime = picked;
//           _endTimeController.text = _formatTimeOfDay(_endTime);
//         }
//       });
//     }
//   }

//   String _formatTimeOfDay(TimeOfDay timeOfDay) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//         now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//     return DateFormat.Hm().format(dateTime);
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // class AddTaskScreen extends StatefulWidget {
// //   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

// //   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

// //   @override
// //   _AddTaskScreenState createState() => _AddTaskScreenState();
// // }

// // class _AddTaskScreenState extends State<AddTaskScreen> {
// //   late String _taskTitle;
// //   DateTime _selectedDate = DateTime.now();
// //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// //   int _remindInterval = 15; // Default reminder interval in minutes
// //   Color _taskColor = Colors.yellow;

// //   late TextEditingController _dateController;
// //   late TextEditingController _startTimeController;
// //   late TextEditingController _endTimeController;

// //   List<Color> _colors = [Colors.yellow, Colors.red, Colors.blueAccent];
// //   int _selectedColorIndex = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _dateController = TextEditingController(text: DateFormat('MM/dd/yyyy').format(_selectedDate));
// //     _startTimeController = TextEditingController();
// //     _endTimeController = TextEditingController();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: Text('Add Task'),
// //       content: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 border: Border.all(color: Colors.grey),
// //               ),
// //               child: TextFormField(
// //                 controller: _dateController,
// //                 readOnly: true,
// //                 onTap: () => _selectDate(context),
// //                 decoration: InputDecoration(
// //                   labelText: 'Date',
// //                   border: InputBorder.none,
// //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
// //                   suffixIcon: Icon(Icons.calendar_today),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             TextFormField(
// //               controller: _startTimeController,
// //               readOnly: true,
// //               onTap: () => _selectTime(context, true),
// //               decoration: InputDecoration(
// //                 labelText: 'Start Time',
// //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// //                 suffixIcon: Icon(Icons.access_time),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             TextFormField(
// //               controller: _endTimeController,
// //               readOnly: true,
// //               onTap: () => _selectTime(context, false),
// //               decoration: InputDecoration(
// //                 labelText: 'End Time',
// //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// //                 suffixIcon: Icon(Icons.access_time),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             DropdownButtonFormField<int>(
// //               value: _remindInterval,
// //               items: [15, 30, 45, 60].map((interval) {
// //                 return DropdownMenuItem<int>(
// //                   value: interval,
// //                   child: Text('$interval minutes'),
// //                 );
// //               }).toList(),
// //               onChanged: (value) {
// //                 setState(() {
// //                   _remindInterval = value!;
// //                 });
// //               },
// //               decoration: InputDecoration(labelText: 'Reminder Interval'),
// //             ),
// //             SizedBox(height: 10),
// //             Row(
// //               children: _colors
// //                   .asMap()
// //                   .entries
// //                   .map(
// //                     (entry) => GestureDetector(
// //                       onTap: () {
// //                         setState(() {
// //                           _selectedColorIndex = entry.key;
// //                           _taskColor = entry.value;
// //                         });
// //                       },
// //                       child: Container(
// //                         width: 40,
// //                         height: 40,
// //                         margin: EdgeInsets.symmetric(horizontal: 5),
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: entry.value,
// //                           border: Border.all(color: _selectedColorIndex == entry.key ? Colors.black : Colors.transparent),
// //                         ),
// //                         child: _selectedColorIndex == entry.key ? Icon(Icons.check, color: Colors.white) : null,
// //                       ),
// //                     ),
// //                   )
// //                   .toList(),
// //             ),
// //           ],
// //         ),
// //       ),
// //       actions: <Widget>[
// //         TextButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           child: Text('Cancel'),
// //         ),
// //         ElevatedButton(
// //           onPressed: () {
// //             // Perform add task operation
// //             if (_selectedDate != null && _taskTitle != null) {
// //               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime, _remindInterval, _taskColor);
// //               Navigator.of(context).pop();
// //             } else {
// //               print('Please select a date and enter a title');
// //             }
// //           },
// //           child: Text('Add'),
// //         ),
// //       ],
// //     );
// //   }

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate,
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //     );
// //     if (picked != null && picked != _selectedDate) {
// //       setState(() {
// //         _selectedDate = picked;
// //         _dateController.text = DateFormat('MM/dd/yyyy').format(_selectedDate);
// //       });
// //     }
// //   }

// //   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
// //     final TimeOfDay? picked = await showTimePicker(
// //       context: context,
// //       initialTime: isStartTime ? _startTime : _endTime,
// //     );
// //     if (picked != null) {
// //       setState(() {
// //         if (isStartTime) {
// //           _startTime = picked;
// //           _startTimeController.text = _formatTimeOfDay(_startTime);
// //         } else {
// //           _endTime = picked;
// //           _endTimeController.text = _formatTimeOfDay(_endTime);
// //         }
// //       });
// //     }
// //   }

// //   String _formatTimeOfDay(TimeOfDay timeOfDay) {
// //     final now = DateTime.now();
// //     final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
// //     return DateFormat.Hm().format(dateTime);
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';

// // // class AddTaskScreen extends StatefulWidget {
// // //   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

// // //   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

// // //   @override
// // //   _AddTaskScreenState createState() => _AddTaskScreenState();
// // // }

// // // class _AddTaskScreenState extends State<AddTaskScreen> {
// // //   late String _taskTitle;
// // //   DateTime _selectedDate = DateTime.now();
// // //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// // //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// // //   int _remindInterval = 15; // Default reminder interval in minutes
// // //   Color _taskColor = Colors.yellow;

// // //   late TextEditingController _startTimeController;
// // //   late TextEditingController _endTimeController;

// // //   List<Color> _colors = [Colors.yellow, Colors.red, Colors.blueAccent];
// // //   int _selectedColorIndex = 0;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _startTimeController = TextEditingController();
// // //     _endTimeController = TextEditingController();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AlertDialog(
// // //       title: Text('Add Task'),
// // //       content: SingleChildScrollView(
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Container(
// // //               decoration: BoxDecoration(
// // //                 borderRadius: BorderRadius.circular(10),
// // //                 border: Border.all(color: Colors.grey),
// // //               ),
// // //               child: TextFormField(
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Title',
// // //                   border: InputBorder.none,
// // //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
// // //                 ),
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     _taskTitle = value;
// // //                   });
// // //                 },
// // //               ),
// // //             ),
// // //             SizedBox(height: 10),
// // //             TextFormField(
// // //               controller: _startTimeController,
// // //               readOnly: true,
// // //               onTap: () => _selectTime(context, true),
// // //               decoration: InputDecoration(
// // //                 labelText: 'Start Time',
// // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // //                 suffixIcon: Icon(Icons.access_time),
// // //               ),
// // //             ),
// // //             SizedBox(height: 10),
// // //             TextFormField(
// // //               controller: _endTimeController,
// // //               readOnly: true,
// // //               onTap: () => _selectTime(context, false),
// // //               decoration: InputDecoration(
// // //                 labelText: 'End Time',
// // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // //                 suffixIcon: Icon(Icons.access_time),
// // //               ),
// // //             ),
// // //             SizedBox(height: 10),
// // //             DropdownButtonFormField<int>(
// // //               value: _remindInterval,
// // //               items: [15, 30, 45, 60].map((interval) {
// // //                 return DropdownMenuItem<int>(
// // //                   value: interval,
// // //                   child: Text('$interval minutes'),
// // //                 );
// // //               }).toList(),
// // //               onChanged: (value) {
// // //                 setState(() {
// // //                   _remindInterval = value!;
// // //                 });
// // //               },
// // //               decoration: InputDecoration(labelText: 'Reminder Interval'),
// // //             ),
// // //             SizedBox(height: 10),
// // //             Row(
// // //               children: _colors
// // //                   .asMap()
// // //                   .entries
// // //                   .map(
// // //                     (entry) => GestureDetector(
// // //                       onTap: () {
// // //                         setState(() {
// // //                           _selectedColorIndex = entry.key;
// // //                           _taskColor = entry.value;
// // //                         });
// // //                       },
// // //                       child: Container(
// // //                         width: 40,
// // //                         height: 40,
// // //                         margin: EdgeInsets.symmetric(horizontal: 5),
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           color: entry.value,
// // //                           border: Border.all(color: _selectedColorIndex == entry.key ? Colors.black : Colors.transparent),
// // //                         ),
// // //                         child: _selectedColorIndex == entry.key ? Icon(Icons.check, color: Colors.white) : null,
// // //                       ),
// // //                     ),
// // //                   )
// // //                   .toList(),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       actions: <Widget>[
// // //         TextButton(
// // //           onPressed: () {
// // //             Navigator.of(context).pop();
// // //           },
// // //           child: Text('Cancel'),
// // //         ),
// // //         ElevatedButton(
// // //           onPressed: () {
// // //             // Perform add task operation
// // //             if (_selectedDate != null && _taskTitle != null) {
// // //               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime, _remindInterval, _taskColor);
// // //               Navigator.of(context).pop();
// // //             } else {
// // //               print('Please select a date and enter a title');
// // //             }
// // //           },
// // //           child: Text('Add'),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
// // //     final TimeOfDay? picked = await showTimePicker(
// // //       context: context,
// // //       initialTime: isStartTime ? _startTime : _endTime,
// // //     );
// // //     if (picked != null) {
// // //       setState(() {
// // //         if (isStartTime) {
// // //           _startTime = picked;
// // //           _startTimeController.text = _formatTimeOfDay(_startTime);
// // //         } else {
// // //           _endTime = picked;
// // //           _endTimeController.text = _formatTimeOfDay(_endTime);
// // //         }
// // //       });
// // //     }
// // //   }

// // //   String _formatTimeOfDay(TimeOfDay timeOfDay) {
// // //     final now = DateTime.now();
// // //     final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
// // //     return DateFormat.Hm().format(dateTime);
// // //   }
// // // }


// // // // import 'package:flutter/material.dart';
// // // // import 'package:intl/intl.dart';

// // // // class AddTaskScreen extends StatefulWidget {
// // // //   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

// // // //   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

// // // //   @override
// // // //   _AddTaskScreenState createState() => _AddTaskScreenState();
// // // // }

// // // // class _AddTaskScreenState extends State<AddTaskScreen> {
// // // //   late String _taskTitle;
// // // //   DateTime _selectedDate= DateTime.now();
// // // //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// // // //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// // // //   int _remindInterval = 15; // Default reminder interval in minutes
// // // //   Color _taskColor = Colors.yellow;

// // // //   late TextEditingController _startTimeController;
// // // //   late TextEditingController _endTimeController;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _startTimeController = TextEditingController();
// // // //     _endTimeController = TextEditingController();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return AlertDialog(
// // // //       title: Text('Add Task'),
// // // //       content: SingleChildScrollView(
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Container(
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(10),
// // // //                 border: Border.all(color: Colors.grey),
// // // //               ),
// // // //               child: TextFormField(
// // // //                 decoration: InputDecoration(
// // // //                   labelText: 'Title',
// // // //                   border: InputBorder.none,
// // // //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
// // // //                 ),
// // // //                 onChanged: (value) {
// // // //                   setState(() {
// // // //                     _taskTitle = value;
// // // //                   });
// // // //                 },
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             TextFormField(
// // // //               controller: _startTimeController,
// // // //               readOnly: true,
// // // //               onTap: () => _selectTime(context, true),
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'Start Time',
// // // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // // //                 suffixIcon: Icon(Icons.access_time),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             TextFormField(
// // // //               controller: _endTimeController,
// // // //               readOnly: true,
// // // //               onTap: () => _selectTime(context, false),
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'End Time',
// // // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // // //                 suffixIcon: Icon(Icons.access_time),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             DropdownButtonFormField<int>(
// // // //               value: _remindInterval,
// // // //               items: [15, 30, 45, 60].map((interval) {
// // // //                 return DropdownMenuItem<int>(
// // // //                   value: interval,
// // // //                   child: Text('$interval minutes'),
// // // //                 );
// // // //               }).toList(),
// // // //               onChanged: (value) {
// // // //                 setState(() {
// // // //                   _remindInterval = value!;
// // // //                 });
// // // //               },
// // // //               decoration: InputDecoration(labelText: 'Reminder Interval'),
// // // //             ),
// // // //             SizedBox(height: 10),
// // // //             DropdownButtonFormField<Color>(
// // // //               value: _taskColor,
// // // //               items: [
// // // //                 DropdownMenuItem<Color>(
// // // //                   value: Colors.yellow,
// // // //                   child: Text('Yellow'),
// // // //                 ),
// // // //                 DropdownMenuItem<Color>(
// // // //                   value: Colors.red,
// // // //                   child: Text('Red'),
// // // //                 ),
// // // //                 DropdownMenuItem<Color>(
// // // //                   value: Colors.blueAccent,
// // // //                   child: Text('Blue'),
// // // //                 ),
// // // //               ],
// // // //               onChanged: (value) {
// // // //                 setState(() {
// // // //                   _taskColor = value!;
// // // //                 });
// // // //               },
// // // //               decoration: InputDecoration(labelText: 'Task Color'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //       actions: <Widget>[
// // // //         TextButton(
// // // //           onPressed: () {
// // // //             Navigator.of(context).pop();
// // // //           },
// // // //           child: Text('Cancel'),
// // // //         ),
// // // //         ElevatedButton(
// // // //           onPressed: () {
// // // //             // Perform add task operation
// // // //             if (_selectedDate != null && _taskTitle != null) {
// // // //               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime, _remindInterval, _taskColor);
// // // //               Navigator.of(context).pop();
// // // //             } else {
// // // //               print('Please select a date and enter a title');
// // // //             }
// // // //           },
// // // //           child: Text('Add'),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
// // // //     final TimeOfDay? picked = await showTimePicker(
// // // //       context: context,
// // // //       initialTime: isStartTime ? _startTime : _endTime,
// // // //     );
// // // //     if (picked != null) {
// // // //       setState(() {
// // // //         if (isStartTime) {
// // // //           _startTime = picked;
// // // //           _startTimeController.text = _formatTimeOfDay(_startTime);
// // // //         } else {
// // // //           _endTime = picked;
// // // //           _endTimeController.text = _formatTimeOfDay(_endTime);
// // // //         }
// // // //       });
// // // //     }
// // // //   }

// // // //   String _formatTimeOfDay(TimeOfDay timeOfDay) {
// // // //     final now = DateTime.now();
// // // //     final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
// // // //     return DateFormat.Hm().format(dateTime);
// // // //   }
// // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:intl/intl.dart';

// // // // // class AddTaskScreen extends StatefulWidget {
// // // // //   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

// // // // //   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

// // // // //   @override
// // // // //   _AddTaskScreenState createState() => _AddTaskScreenState();
// // // // // }

// // // // // class _AddTaskScreenState extends State<AddTaskScreen> {
// // // // //   late String _taskTitle;
// // // // //   DateTime _selectedDate= DateTime.now();
// // // // //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// // // // //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// // // // //   int _remindInterval = 15; // Default reminder interval in minutes
// // // // //   Color _taskColor = Colors.yellow;

// // // // //   late TextEditingController _startTimeController;
// // // // //   late TextEditingController _endTimeController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _startTimeController = TextEditingController();
// // // // //     _endTimeController = TextEditingController();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return AlertDialog(
// // // // //       title: Text('Add Task'),
// // // // //       content: SingleChildScrollView(
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Container(
// // // // //               decoration: BoxDecoration(
// // // // //                 borderRadius: BorderRadius.circular(10),
// // // // //                 border: Border.all(color: Colors.grey),
// // // // //               ),
// // // // //               child: TextFormField(
// // // // //                 decoration: InputDecoration(
// // // // //                   labelText: 'Title',
// // // // //                   border: InputBorder.none,
// // // // //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
// // // // //                 ),
// // // // //                 onChanged: (value) {
// // // // //                   setState(() {
// // // // //                     _taskTitle = value;
// // // // //                   });
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             TextFormField(
// // // // //               controller: _startTimeController,
// // // // //               readOnly: true,
// // // // //               onTap: () => _selectTime(context, true),
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Start Time',
// // // // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // // // //                 prefixIcon: Icon(Icons.access_time),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             TextFormField(
// // // // //               controller: _endTimeController,
// // // // //               readOnly: true,
// // // // //               onTap: () => _selectTime(context, false),
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'End Time',
// // // // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// // // // //                 prefixIcon: Icon(Icons.access_time),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             DropdownButtonFormField<int>(
// // // // //               value: _remindInterval,
// // // // //               items: [15, 30, 45, 60].map((interval) {
// // // // //                 return DropdownMenuItem<int>(
// // // // //                   value: interval,
// // // // //                   child: Text('$interval minutes'),
// // // // //                 );
// // // // //               }).toList(),
// // // // //               onChanged: (value) {
// // // // //                 setState(() {
// // // // //                   _remindInterval = value!;
// // // // //                 });
// // // // //               },
// // // // //               decoration: InputDecoration(labelText: 'Reminder Interval'),
// // // // //             ),
// // // // //             SizedBox(height: 10),
// // // // //             DropdownButtonFormField<Color>(
// // // // //               value: _taskColor,
// // // // //               items: [
// // // // //                 DropdownMenuItem<Color>(
// // // // //                   value: Colors.yellow,
// // // // //                   child: Text('Yellow'),
// // // // //                 ),
// // // // //                 DropdownMenuItem<Color>(
// // // // //                   value: Colors.red,
// // // // //                   child: Text('Red'),
// // // // //                 ),
// // // // //                 DropdownMenuItem<Color>(
// // // // //                   value: Colors.blueAccent,
// // // // //                   child: Text('Blue'),
// // // // //                 ),
// // // // //               ],
// // // // //               onChanged: (value) {
// // // // //                 setState(() {
// // // // //                   _taskColor = value!;
// // // // //                 });
// // // // //               },
// // // // //               decoration: InputDecoration(labelText: 'Task Color'),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //       actions: <Widget>[
// // // // //         TextButton(
// // // // //           onPressed: () {
// // // // //             Navigator.of(context).pop();
// // // // //           },
// // // // //           child: Text('Cancel'),
// // // // //         ),
// // // // //         ElevatedButton(
// // // // //           onPressed: () {
// // // // //             // Perform add task operation
// // // // //             if (_selectedDate != null && _taskTitle != null) {
// // // // //               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime, _remindInterval, _taskColor);
// // // // //               Navigator.of(context).pop();
// // // // //             } else {
// // // // //               print('Please select a date and enter a title');
// // // // //             }
// // // // //           },
// // // // //           child: Text('Add'),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }

// // // // //   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
// // // // //     final TimeOfDay? picked = await showTimePicker(
// // // // //       context: context,
// // // // //       initialTime: isStartTime ? _startTime : _endTime,
// // // // //     );
// // // // //     if (picked != null) {
// // // // //       setState(() {
// // // // //         if (isStartTime) {
// // // // //           _startTime = picked;
// // // // //           _startTimeController.text = _formatTimeOfDay(_startTime);
// // // // //         } else {
// // // // //           _endTime = picked;
// // // // //           _endTimeController.text = _formatTimeOfDay(_endTime);
// // // // //         }
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   String _formatTimeOfDay(TimeOfDay timeOfDay) {
// // // // //     final now = DateTime.now();
// // // // //     final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
// // // // //     return DateFormat.Hm().format(dateTime);
// // // // //   }
// // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:intl/intl.dart';

// // // // // // class AddTaskScreen extends StatefulWidget {
// // // // // //   final Function(String, DateTime, TimeOfDay, TimeOfDay, int, Color) onAddTask;

// // // // // //   const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

// // // // // //   @override
// // // // // //   _AddTaskScreenState createState() => _AddTaskScreenState();
// // // // // // }

// // // // // // class _AddTaskScreenState extends State<AddTaskScreen> {
// // // // // //   late String _taskTitle;
// // // // // //   DateTime _selectedDate= DateTime.now();
// // // // // //   TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
// // // // // //   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0);
// // // // // //   int _remindInterval = 15; // Default reminder interval in minutes
// // // // // //   Color _taskColor = Colors.yellow;

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return AlertDialog(
// // // // // //       title: Text('Add Task'),
// // // // // //       content: SingleChildScrollView(
// // // // // //         child: Column(
// // // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //           children: [
// // // // // //             Container(
// // // // // //               decoration: BoxDecoration(
// // // // // //                 borderRadius: BorderRadius.circular(10),
// // // // // //                 border: Border.all(color: Colors.grey),
// // // // // //               ),
// // // // // //               child: TextFormField(
// // // // // //                 decoration: InputDecoration(
// // // // // //                   labelText: 'Title',
// // // // // //                   border: InputBorder.none,
// // // // // //                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
// // // // // //                 ),
// // // // // //                 onChanged: (value) {
// // // // // //                   setState(() {
// // // // // //                     _taskTitle = value;
// // // // // //                   });
// // // // // //                 },
// // // // // //               ),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             Text('Start Time: ${_formatTimeOfDay(_startTime)}'),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: () => _selectStartTime(context),
// // // // // //               child: Text('Select Start Time'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             Text('End Time: ${_formatTimeOfDay(_endTime)}'),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: () => _selectEndTime(context),
// // // // // //               child: Text('Select End Time'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             DropdownButtonFormField<int>(
// // // // // //               value: _remindInterval,
// // // // // //               items: [15, 30, 45, 60].map((interval) {
// // // // // //                 return DropdownMenuItem<int>(
// // // // // //                   value: interval,
// // // // // //                   child: Text('$interval minutes'),
// // // // // //                 );
// // // // // //               }).toList(),
// // // // // //               onChanged: (value) {
// // // // // //                 setState(() {
// // // // // //                   _remindInterval = value!;
// // // // // //                 });
// // // // // //               },
// // // // // //               decoration: InputDecoration(labelText: 'Reminder Interval'),
// // // // // //             ),
// // // // // //             SizedBox(height: 10),
// // // // // //             DropdownButtonFormField<Color>(
// // // // // //               value: _taskColor,
// // // // // //               items: [
// // // // // //                 DropdownMenuItem<Color>(
// // // // // //                   value: Colors.yellow,
// // // // // //                   child: Text('Yellow'),
// // // // // //                 ),
// // // // // //                 DropdownMenuItem<Color>(
// // // // // //                   value: Colors.red,
// // // // // //                   child: Text('Red'),
// // // // // //                 ),
// // // // // //                 DropdownMenuItem<Color>(
// // // // // //                   value: Colors.blueAccent,
// // // // // //                   child: Text('Blue'),
// // // // // //                 ),
// // // // // //               ],
// // // // // //               onChanged: (value) {
// // // // // //                 setState(() {
// // // // // //                   _taskColor = value!;
// // // // // //                 });
// // // // // //               },
// // // // // //               decoration: InputDecoration(labelText: 'Task Color'),
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //       actions: <Widget>[
// // // // // //         TextButton(
// // // // // //           onPressed: () {
// // // // // //             Navigator.of(context).pop();
// // // // // //           },
// // // // // //           child: Text('Cancel'),
// // // // // //         ),
// // // // // //         ElevatedButton(
// // // // // //           onPressed: () {
// // // // // //             // Perform add task operation
// // // // // //             if (_selectedDate != null && _taskTitle != null) {
// // // // // //               widget.onAddTask(_taskTitle, _selectedDate, _startTime, _endTime, _remindInterval, _taskColor);
// // // // // //               Navigator.of(context).pop();
// // // // // //             } else {
// // // // // //               print('Please select a date and enter a title');
// // // // // //             }
// // // // // //           },
// // // // // //           child: Text('Add'),
// // // // // //         ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   String _formatTimeOfDay(TimeOfDay timeOfDay) {
// // // // // //     final now = DateTime.now();
// // // // // //     final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
// // // // // //     return DateFormat.Hm().format(dateTime);
// // // // // //   }

// // // // // //   Future<void> _selectStartTime(BuildContext context) async {
// // // // // //     final TimeOfDay? picked = await showTimePicker(
// // // // // //       context: context,
// // // // // //       initialTime: _startTime,
// // // // // //     );
// // // // // //     if (picked != null && picked != _startTime) {
// // // // // //       setState(() {
// // // // // //         _startTime = picked;
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   Future<void> _selectEndTime(BuildContext context) async {
// // // // // //     final TimeOfDay? picked = await showTimePicker(
// // // // // //       context: context,
// // // // // //       initialTime: _endTime,
// // // // // //     );
// // // // // //     if (picked != null && picked != _endTime) {
// // // // // //       setState(() {
// // // // // //         _endTime = picked;
// // // // // //       });
// // // // // //     }
// // // // // //   }
// // // // // // }
