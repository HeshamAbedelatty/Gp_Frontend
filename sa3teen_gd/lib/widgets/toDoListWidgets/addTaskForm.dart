import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/customTaskButton.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/customTextFeild.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? taskName, date, color;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          CustomTextFeild(
            hint: 'Enter task title',
            onSaved: (value) {
              taskName = value;
            },
          ), //azn dyh l 7aga ali htt5zn fy l data base ha5odha mn l user we 25znha fy l taskname li hwa asln mwgod fy class li fy lbayanat bta3ty
          const SizedBox(height: 16.0),
          CustomTextFeild(
            hint: 'Enter due date',
            onSaved: (value) {
              taskName = value;
            },
          ),
          const SizedBox(height: 16.0),
          CustomTextFeild(
            hint: 'Enter color',
            onSaved: (value) {
              color = value;
            },
          ),

          const SizedBox(height: 16.0),
          CustomTaskButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
              } else {
                autovalidateMode = AutovalidateMode.always;
                setState(
                  () {},
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
