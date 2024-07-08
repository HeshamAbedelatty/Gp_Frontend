import 'package:flutter/material.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditTask {
  final int? id;
  final String title;
  final String description;
  final DateTime day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final int remindInterval;
  Color? color;

  EditTask({
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

class EditTaskScreen extends StatefulWidget {
  final EditTask task;

  EditTaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final Api_services api_services = Api_services();

  final List<Color> _colors = [
    Color.fromARGB(218, 255, 219, 88),
    Color.fromARGB(255, 232, 109, 101),
    Color.fromARGB(255, 130, 174, 250),
    Color.fromARGB(255, 148, 244, 150),
    Color.fromARGB(255, 202, 130, 250)
  ];

  String colorToHex(Color color) {
    return '#${color.alpha.toRadixString(16).padLeft(2, '0')}${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
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

  Future<void> _selectTime(
      BuildContext context,
      bool isStartTime,
      TextEditingController timeController,
      TimeOfDay initialTime,
      void Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      onTimeSelected(picked);
      timeController.text = _formatTimeOfDay(picked);
    }
  }

  late TextEditingController _titleController;
 late TextEditingController _descriptionController;
 late TextEditingController _startTimeController;

 late TextEditingController _endTimeController;

  initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);

    _startTimeController = TextEditingController(
        text: widget.task.startTime == null
            ? ""
            : _formatTimeOfDay(widget.task.startTime!));

    _endTimeController = TextEditingController(
        text: widget.task.endTime == null
            ? ""
            : _formatTimeOfDay(widget.task.endTime!));
    _selectedDay=DateFormat('EEEE').format(widget.task.day);
    _remindInterval = widget.task.remindInterval;
    _taskColor = widget.task.color;
    _selectedColorIndex  =widget.task.color == null ? 0 : _colors.indexOf(widget.task.color!);

  }
  late String _selectedDay;
  late int _remindInterval;
  late Color? _taskColor;
  late  int _selectedColorIndex;
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(widget.task.id != null ? 'Edit Slot' : 'Add Slot'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, true, _startTimeController,
                  widget.task.startTime ?? TimeOfDay.now(), (picked) {
                setState(() {
                  widget.task.startTime = picked;
                });
              }),
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
              onTap: () => _selectTime(context, false, _endTimeController,
                  widget.task.endTime ?? TimeOfDay.now(), (picked) {
                setState(() {
                  widget.task.endTime = picked;
                });
              }),
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
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday'
              ]
                  .map((day) =>
                      DropdownMenuItem<String>(value: day, child: Text(day)))
                  .toList(),
              onChanged: (valueDay) {
                setState(() {
                  _selectedDay = valueDay!;
                });
              },
              decoration: InputDecoration(labelText: 'Day'),
            ),
            SizedBox(height: 10,),
            DropdownButtonFormField<int>(
              value: _remindInterval,
              items: [5, 10, 15, 30, 60].map((interval) =>
                  DropdownMenuItem<int>(value: interval, child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                child: Text('$interval minutes', style: TextStyle(fontSize: 16.0)),
              ))).toList(),
              onChanged: (value) {
                setState(() {
                  _remindInterval = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Reminder Interval',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              style: TextStyle(fontSize: 16.0),
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
                          widget.task.color = entry.value;
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
          onPressed: () async {
            final selectedDate = _getDateFromDay(_selectedDay);
            print(selectedDate);
            print(_titleController.text);
            if (selectedDate != null && _titleController.text.isNotEmpty) {
              if (widget.task.id != null) {
                await Provider.of<Api_services>(context, listen: false)
                    .UpdateSlot(
                  widget.task.id as int,
                  _titleController.text,
                  _selectedDay,
                  _formatTimeOfDay(widget.task.startTime!),
                  _formatTimeOfDay(widget.task.endTime!),
                  _descriptionController.text,
                  _remindInterval,
                  colorToHex(_taskColor!),
                  accesstokenfinal,
                ).then((value) => Navigator.of(context).pop());
              } else if (widget.task.id == null &&
                  widget.task.startTime != null &&
                  widget.task.endTime != null &&
                  _taskColor != null) {
                await Provider.of<Api_services>(context, listen: false)
                    .addSchedule(
                  _titleController.text,
                  _selectedDay,
                  widget.task.startTime!,
                  widget.task.endTime!,
                  _descriptionController.text,
                  _remindInterval,
                  colorToHex(_taskColor!),
                  accesstokenfinal,
                ).then((value) => Navigator.of(context).pop());
              }
            } else {
              print('Please select a day and enter a title');
            }
          },
          child: Text(
            'Save',
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
        throw ArgumentError('Invalid day: $day');
    }
  }
}
