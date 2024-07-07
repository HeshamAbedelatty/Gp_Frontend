// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../app_state.dart';
//
//
// class ToDoListScreen extends StatefulWidget {
//   @override
//   _ToDoListScreenState createState() => _ToDoListScreenState();
// }
//
// class _ToDoListScreenState extends State<ToDoListScreen> {
//   TextEditingController _searchController = TextEditingController();
//   late DateTime _selectedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ToDoListProvider>().fetchTasks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ToDoListProvider(),
//       child: Consumer<ToDoListProvider>(
//         builder: (context, provider, child) {
//           return Scaffold(
//             backgroundColor: Colors.grey[200],
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               title: Text(
//                 'To-Do List',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     showSearch(
//                       context: context,
//                       delegate: CustomSearchDelegate(provider),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             body: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Filter by date:',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             final selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2023),
//                               lastDate: DateTime(2025),
//                             );
//                             if (selectedDate != null) {
//                               setState(() {
//                                 _selectedDate = selectedDate;
//                               });
//                               provider.filterTasksByDate(_selectedDate);
//                             }
//                           },
//                           child: Text(
//                             _selectedDate == null
//                                 ? 'Select date'
//                                 : _selectedDate.toString().split(' ')[0],
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: provider.filteredTasks.length,
//                       itemBuilder: (context, index) {
//                         final task = provider.filteredTasks[index];
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: ListTile(
//                               leading: Checkbox(
//                                 value: task.completed,
//                                 onChanged: (value) {
//                                   provider.toggleTaskCompletion(task);
//                                 },
//                               ),
//                               title: Text(
//                                 task.title,
//                                 style: TextStyle(
//                                   decoration: task.completed
//                                       ? TextDecoration.lineThrough
//                                       : TextDecoration.none,
//                                   color: task.completed
//                                       ? Colors.grey
//                                       : Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 final newTask = Task(title: 'New Task', completed: false);
//                 provider.addTask(newTask);
//                 // You can also save the new task to the backend
//                 // context.read<ToDoListProvider>().saveTask(newTask);
//               },
//               backgroundColor: Colors.blue,
//               child: Icon(Icons.add),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CustomSearchDelegate extends SearchDelegate<Task> {
//   final ToDoListProvider _provider;
//
//   CustomSearchDelegate(this._provider);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           _provider.searchTasks('');
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     _provider.searchTasks(query);
//     return ListView.builder(
//       itemCount: _provider.searchedTasks.length,
//       itemBuilder: (context, index) {
//         final task = _provider.searchedTasks[index];
//         return ListTile(
//           title: Text(task.title),
//           onTap: () {
//             close(context, task);
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     _provider.searchTasks(query);
//     return ListView.builder(
//       itemCount: _provider.searchedTasks.length,
//       itemBuilder: (context, index) {
//         final task = _provider.searchedTasks[index];
//         return ListTile(
//           title: Text(task.title),
//           onTap: () {
//             close(context, task);
//           },
//         );
//       },
//     );
//   }
// }