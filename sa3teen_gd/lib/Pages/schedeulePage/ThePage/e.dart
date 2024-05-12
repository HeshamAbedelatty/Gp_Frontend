//edit from chatgpt working but not complete 
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class EditTaskScreen extends StatefulWidget {
//   final Task task;
//   final Function(Task) onUpdateTask;
//   final Function(String, String, DateTime, TimeOfDay, TimeOfDay, int, Color) onSaveTask;

//   const EditTaskScreen({
//     Key? key,
//     required this.task,
//     required this.onUpdateTask,
//     required this.onSaveTask,
//   }) : super(key: key);

//   @override
//   _EditTaskScreenState createState() => _EditTaskScreenState();
// }

// class _EditTaskScreenState extends State<EditTaskScreen> {
//   late String _taskTitle;
//   late String _description;
//   late TimeOfDay _startTime;
//   late TimeOfDay _endTime;
//   late Color _taskColor;

//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.task.title);
//     _descriptionController = TextEditingController(text: widget.task.description);
//     _startTime = widget.task.startTime;
//     _endTime = widget.task.endTime;
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
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//               onChanged: (value) {
//                 setState(() {
//                   _taskTitle = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//               onChanged: (value) {
//                 setState(() {
//                   _description = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Text('Start Time: ${_formatTime(_startTime)}'),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _selectTime(context, true),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Text('End Time: ${_formatTime(_endTime)}'),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () => _selectTime(context, false),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             // Color selection can be added here
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
//             // Call the update method and pass the updated task
//             final updatedTask = Task(
//               title: _titleController.text,
//               description: _descriptionController.text,
//               day: widget.task.day,
//               startTime: _startTime,
//               endTime: _endTime,
//               remindInterval: widget.task.remindInterval,
//               color: _taskColor,
//             );
//             widget.onUpdateTask(updatedTask);
//             Navigator.of(context).pop();
//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
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
//         } else {
//           _endTime = picked;
//         }
//       });
//     }
//   }

//   String _formatTime(TimeOfDay timeOfDay) {
//     final time = DateTime(1, 1, 1, timeOfDay.hour, timeOfDay.minute);
//     return DateFormat.jm().format(time);
//   }
// }
