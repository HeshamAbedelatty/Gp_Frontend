import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Services/API_services.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String, String, DateTime, TimeOfDay, TimeOfDay, int, Color)
      onAddTask;

  const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String _taskTitle;
  late String _description;
  late String _selectedDay;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  int _remindInterval = 15; // Default reminder interval in minutes
  Color _taskColor = const Color.fromARGB(218, 255, 219, 88);

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  Api_services api_services = Api_services();
  final List<Color> _colors = [
    const Color.fromARGB(218, 255, 219, 88),
    const Color.fromARGB(255, 232, 109, 101),
    const Color.fromARGB(255, 130, 174, 250),
    const Color.fromARGB(255, 148, 244, 150),
    const Color.fromARGB(255, 202, 130, 250)
  ];

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
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _selectedDay = DateFormat('EEEE').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Slot'),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                  labelText: 'description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
              decoration: const InputDecoration(labelText: 'Day'),
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
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                _description,
                selectedDate,
                _startTime,
                _endTime,
                _remindInterval,
                _taskColor,
              );
              Api_services.addSchedule(
                  _taskTitle,
                  _selectedDay,
                  _startTime,
                  _endTime,
                  _description,
                  _remindInterval,
                  // _taskColor as String,
                  colorToHex(_taskColor),
                  accessToken);
              Navigator.of(context).pop();
            } else {
              print('Please select a day and enter a title');
            }
          },
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
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
