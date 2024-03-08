// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/customAppBar.dart';

// class ToDoListClass {
//   final String taskName;
//   final DateTime deadline;
//   bool isChecked;
//   //final int color;
//   ToDoListClass({
//     required this.taskName,
//     required this.deadline,
//     this.isChecked = false,
//     //required this.color,
//   });
// }

// class ToDoListScreen extends StatefulWidget {
//   const ToDoListScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ToDoListScreenState createState() => _ToDoListScreenState();
// }

// class _ToDoListScreenState extends State<ToDoListScreen> {
//   List<Map<String, dynamic>> toDoLists = [];
//  // List<ToDoListClass> tasks = [];

//   TextEditingController listNameController = TextEditingController();

//   TextEditingController taskNameController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   //TextEditingController colorController = TextEditingController();

//   // Function to add task
//   void addTask(int listIndex) {
//     setState(() {
//       toDoLists[listIndex]['tasks'].add(ToDoListClass(
//         taskName: taskNameController.text,
//         deadline: DateTime.parse(dateController.text),
//         // color: int.parse(colorController.text),
//       ));
//       // for (ToDoListClass user in tasks) {
//       //   // ignore: avoid_print
//       //   print('Task: ${user.taskName} ' ' date:${user.deadline}');
//       // }
//       taskNameController.clear();
//       dateController.clear();

//       /// colorController.clear();
//     });
//   }

//   // Function to edit task
//   void editTask(int listIndex) {
//     setState(() {
      
//       // toDoLists[listIndex] = ToDoListClass(
//       //   taskName: taskNameController.text,
//       //   deadline: DateTime.parse(dateController.text),
//       //   //  color: int.parse(colorController.text),
//       // );
//       // for (ToDoListClass user in tasks) {
//       //   // ignore: avoid_print
//       //   print('Task: ${user.taskName} ' ' date:${user.deadline}');
//       // }
//       taskNameController.clear();
//       dateController.clear();
//       colorController.clear();
//     });
//   }

//   // Function to delete task
//   void deleteTask(int index) {
//     setState(() {
//     //  tasks.removeAt(index);
//     });
//     // for (ToDoListClass user in tasks) {
//     //   // ignore: avoid_print
//     //   print('Task: ${user.taskName}' ' date:${user.deadline}');
//     // }
//   }

//   //bool checked = false;
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return Scaffold(
//       backgroundColor: KPrimaryColour,
//       body: Column(
//         children: [
//           const customAppBar(),
//           //  Padding(
//           //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           //       child: Text(
//           //         toDoLists[index]['name'],
//           //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           //       ),
//           //     ),
//           Expanded(
//             child: ListView.builder(
//              // shrinkWrap: true,
//                 itemCount: toDoLists.length,
//               // scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: ListTile(
//                       leading: Checkbox(
//                         materialTapTargetSize: MaterialTapTargetSize.padded,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         value: tasks[index].isChecked,
//                         tristate: true,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             tasks[index].isChecked = value ?? false;
//                           });
//                         },
//                         activeColor: KPrimaryColourGreen,
//                       ),
//                       title: Text(toDoLists[index]['tasks'][taskIndex].taskName),,
//                      subtitle :                     subtitle: Text(toDoLists[index]['tasks'][taskIndex].deadline.toString()),

                      
//                       // subtitle: Text(tasks[index].deadline.toString()),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                               icon: const Icon(Icons.edit,
//                                   color: Colors.brown), // Edit icon
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       title: const Text('Edit Task'),
//                                       content: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           TextField(
//                                             controller: taskNameController,
//                                             decoration: const InputDecoration(
//                                                 labelText: 'Task Name'),
//                                           ),
//                                           InkWell(
//                                             onTap: () async {
//                                               final DateTime? pickedDate =
//                                                   await showDatePicker(
//                                                 context: context,
//                                                 initialDate: DateTime.now(),
//                                                 firstDate: DateTime(2000),
//                                                 lastDate: DateTime(2101),
//                                               );
//                                               if (pickedDate != null) {
//                                                 final TimeOfDay? pickedTime =
//                                                     // ignore: use_build_context_synchronously
//                                                     await showTimePicker(
//                                                   context: context,
//                                                   initialTime: TimeOfDay.now(),
//                                                 );
//                                                 if (pickedTime != null) {
//                                                   final DateTime
//                                                       selectedDateTime =
//                                                       DateTime(
//                                                     pickedDate.year,
//                                                     pickedDate.month,
//                                                     pickedDate.day,
//                                                     pickedTime.hour,
//                                                     pickedTime.minute,
//                                                   );
//                                                   setState(() {
//                                                     dateController.text =
//                                                         selectedDateTime
//                                                             .toString();
//                                                   });
//                                                 }
//                                               }
//                                             },
//                                             child: IgnorePointer(
//                                               child: TextField(
//                                                 controller: dateController,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         labelText:
//                                                             'Due Date & Time'),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text('Cancel'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             //             if (formKey.currentState!.validate()) {
//                                             //   formKey.currentState!.save();
//                                             //   addTask(taskNameController.text);
//                                             // } else {
//                                             //   autovalidateMode = AutovalidateMode.always;
//                                             //   setState(
//                                             //     () {},
//                                             //   );
//                                             // }
//                                             editTask(index);

//                                             Navigator.pop(context);
//                                           },
//                                           child: const Text('edit'),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               } // Edit task function
//                               ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.brown,
//                             ), // Delete icon
//                             onPressed: () =>
//                                 deleteTask(index), // Delete task function
//                           ),
//                         ],
//                       ),
//                     ));
//               },
//             ),
//           ),
//           FloatingActionButton(
//             hoverColor: KPrimaryColourGreen,
//             backgroundColor: KPrimaryColourGreen,
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text('Add Task'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         TextField(
//                   controller: listNameController,
//                   decoration: const InputDecoration(labelText: 'List Name'),
//                 ),
//                         TextField(
//                           controller: taskNameController,
//                           decoration:
//                               const InputDecoration(labelText: 'Task Name'),
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             final DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               final TimeOfDay? pickedTime =
//                                   // ignore: use_build_context_synchronously
//                                   await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay.now(),
//                               );
//                               if (pickedTime != null) {
//                                 final DateTime selectedDateTime = DateTime(
//                                   pickedDate.year,
//                                   pickedDate.month,
//                                   pickedDate.day,
//                                   pickedTime.hour,
//                                   pickedTime.minute,
//                                 );
//                                 setState(() {
//                                   dateController.text =
//                                       selectedDateTime.toString();
//                                 });
//                               }
//                             }
//                           },
//                           child: IgnorePointer(
//                             child: TextField(
//                               controller: dateController,
//                               decoration: const InputDecoration(
//                                   labelText: 'Due Date & Time'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           addTask();

//                           Navigator.pop(context);
//                         },
//                         child: const Text('Add'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: const Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ToDoListScreen(),
//   ));
// }


