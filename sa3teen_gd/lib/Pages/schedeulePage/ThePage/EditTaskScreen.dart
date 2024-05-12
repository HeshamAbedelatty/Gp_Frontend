import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/FinalSchedulePage.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdateTask;
  final Function(String, String, DateTime, TimeOfDay, TimeOfDay, int, Color) onSaveTask;

  const EditTaskScreen({Key? key, required this.task, required this.onUpdateTask, required this.onSaveTask}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late String _taskTitle;
  late String _description;
  late String _selectedDay;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  int _remindInterval = 15; // Default reminder interval in minutes
  late Color _taskColor;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  List<Color> _colors = [
    Color.fromARGB(218, 255, 219, 88),
    const Color.fromARGB(255, 232, 109, 101),
    const Color.fromARGB(255, 130, 174, 250),
    Color.fromARGB(255, 148, 244, 150),
    Color.fromARGB(255, 202, 130, 250)
  ];
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _startTime = widget.task.startTime;
    _endTime = widget.task.endTime;
    _startTimeController = TextEditingController(text: _formatTimeOfDay(_startTime));
    _endTimeController = TextEditingController(text: _formatTimeOfDay(_endTime));
    _selectedDay = DateFormat('EEEE').format(widget.task.day);
    _taskColor = widget.task.color;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
            Container(
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, true),
              decoration: InputDecoration(
                labelText: 'Start Time',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: const Icon(Icons.access_time),
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
                              color: _selectedColorIndex == entry.key ? Colors.black : Colors.transparent),
                        ),
                        child: _selectedColorIndex == entry.key ? const Icon(Icons.check, color: Colors.white) : null,
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
            // Perform update task operation
            final selectedDate = _getDateFromDay(_selectedDay);
            // if (selectedDate != null && _taskTitle.isNotEmpty) {
              final updatedTask = Task(
                title: _titleController.text,
                description: _descriptionController.text,
                day: widget.task.day,
                startTime: widget.task.startTime,
                endTime: widget.task.endTime,
                remindInterval: widget.task.remindInterval,
                color: _taskColor,
              );
              widget.onUpdateTask(updatedTask);
              print('editing');
              Navigator.of(context).pop();
            // } else {
              // print('Please select a day and enter a title');
            // }
          },
          child: Text('Save'),
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
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return DateFormat.Hm().format(dateTime);
  }
}

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/schedeulePage/ThePage/FinalSchedulePage.dart';
// import 'package:intl/intl.dart';

// class EditTaskScreen extends StatefulWidget {
//   final Task task;
//   final Function(Task) onUpdateTask;
//   final Function(String, String, DateTime, TimeOfDay, TimeOfDay, int, Color) onSaveTask;

//   const EditTaskScreen({Key? key, required this.task, required this.onUpdateTask,required this.onSaveTask}) : super(key: key);

//   @override
//   _EditTaskScreenState createState() => _EditTaskScreenState();
// }

// class _EditTaskScreenState extends State<EditTaskScreen> {
//   late String _taskTitle;
//   late String _description;
//   late String _selectedDay;
//   late TimeOfDay _startTime;
//   late TimeOfDay _endTime;
//   int _remindInterval = 15; // Default reminder interval in minutes
//   late Color _taskColor;

//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _startTimeController;
//   late TextEditingController _endTimeController;

//   List<Color> _colors = [
//     Color.fromARGB(218, 255, 219, 88),
//     const Color.fromARGB(255, 232, 109, 101),
//     const Color.fromARGB(255, 130, 174, 250),
//     Color.fromARGB(255, 148, 244, 150),
//     Color.fromARGB(255, 202, 130, 250)
//   ];
//   int _selectedColorIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.task.title);
//     _descriptionController = TextEditingController(text: widget.task.description);
//     _startTime = widget.task.startTime;
//     _endTime = widget.task.endTime;
//     _startTimeController = TextEditingController(text: _formatTimeOfDay(_startTime));
//     _endTimeController = TextEditingController(text: _formatTimeOfDay(_endTime));
//     _selectedDay = DateFormat('EEEE').format(widget.task.day);
//     _taskColor = widget.task.color;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Task'),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
//               child: TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     _description = value;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _startTimeController,
//               readOnly: true,
//               onTap: () => _selectTime(context, true),
//               decoration: InputDecoration(
//                 labelText: 'Start Time',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 suffixIcon: const Icon(Icons.access_time),
//               ),
//             ),
//             const SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               value: _selectedDay,
//               items: [
//                 'Monday',
//                 'Tuesday',
//                 'Wednesday',
//                 'Thursday',
//                 'Friday',
//                 'Saturday',
//                 'Sunday',
//               ].map((day) {
//                 return DropdownMenuItem<String>(
//                   value: day,
//                   child: Text(day),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedDay = value!;
//                 });
//               },
//               decoration: InputDecoration(labelText: 'Day'),
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
//                               color: _selectedColorIndex == entry.key ? Colors.black : Colors.transparent),
//                         ),
//                         child: _selectedColorIndex == entry.key ? const Icon(Icons.check, color: Colors.white) : null,
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
//             // Perform update task operation
//             final selectedDate = _getDateFromDay(_selectedDay);
//             if (selectedDate != null && _taskTitle.isNotEmpty) {
//               final updatedTask = Task(
//                 title: _taskTitle,
//                 description: _description,
//                 day: selectedDate,
//                 startTime: _startTime,
//                 endTime: _endTime,
//                 remindInterval: _remindInterval,
//                 color: _taskColor,
//               );
//               widget.onUpdateTask(updatedTask);
//               Navigator.of(context).pop();
//             } else {
//               print('Please select a day and enter a title');
//             }
//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
//   }

//   DateTime? _getDateFromDay(String day) {
//     final now = DateTime.now();
//     final weekday = now.weekday;
//     final daysToAdd = _getDaysToAdd(day);
//     final selectedDate = now.add(Duration(days: daysToAdd - weekday));
//     return selectedDate;
//   }

//   int _getDaysToAdd(String day) {
//     switch (day) {
//       case 'Monday':
//         return DateTime.monday;
//       case 'Tuesday':
//         return DateTime.tuesday;
//       case 'Wednesday':
//         return DateTime.wednesday;
//       case 'Thursday':
//         return DateTime.thursday;
//       case 'Friday':
//         return DateTime.friday;
//       case 'Saturday':
//         return DateTime.saturday;
//       case 'Sunday':
//         return DateTime.sunday;
//       default:
//         return 0;
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
//  void _saveTask() {
//     // Retrieve the edited values from the form fields
//     String editedTitle = _titleController.text;
//     String editedDescription = _descriptionController.text;

//     // Call onSaveTask with the edited values
//     widget.onSaveTask(
//       editedTitle,
//       editedDescription,
//       _selectedDay as DateTime,
//       _startTime,
//       _endTime,
//       _remindInterval,
//       _taskColor,
//     );

//     // Close the dialog
//     Navigator.of(context).pop();
//   }
//   String _formatTimeOfDay(TimeOfDay timeOfDay) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       timeOfDay.hour,
//       timeOfDay.minute,
//     );
//     return DateFormat.Hm().format(dateTime);
//   }
// }
