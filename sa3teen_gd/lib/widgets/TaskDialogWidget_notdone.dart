// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

class TaskDialog extends StatefulWidget {
  final String title;
  final String actionButtonText;
  final Function onPressedAction;
 final TextEditingController controller1;
  final TextEditingController controller2;

  TaskDialog({
    Key? key,
    required this.title,
    required this.actionButtonText,
    required this.onPressedAction,
    required this.controller1,
    required this.controller2

  }) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: widget.controller1,
            decoration: const InputDecoration(
              labelText: 'Task Name',
            ),
          ),
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final DateTime selectedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  setState(() {
                    widget.controller2.text = selectedDateTime.toString();
                    print(selectedDateTime.toString());
                  });
                }
              }
            },
            child: IgnorePointer(
              child: TextFormField(
                controller: widget.controller2,
                decoration: const InputDecoration(
                  labelText: 'Due Date & Time',
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
          child: const Text('Cancel', style: TextStyle(color: kprimaryColourGreen)),
        ),
        TextButton(
          onPressed: widget.onPressedAction as void Function()?,
          child: Text(widget.actionButtonText,
              style: const TextStyle(color: kprimaryColourGreen)),
        ),
      ],
    );
  }
}
// For the first showDialog
// TaskDialog(
//   context: context,
//   builder: (context) => TaskDialog(
//     title: 'Edit Task',
//     actionButtonText: 'Edit',
//     onPressedAction: () {
//       editTask(listIndex, taskIndex);
//       Navigator.pop(context);
//     },
//   ),
// );