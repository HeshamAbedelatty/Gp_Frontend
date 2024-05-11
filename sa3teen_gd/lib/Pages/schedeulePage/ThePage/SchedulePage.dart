// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SchedulePage extends StatefulWidget {
//   @override
//   _SchedulePageState createState() => _SchedulePageState();
// }

// class _SchedulePageState extends State<SchedulePage> {
//   DateTime _currentDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   setState(() {
//                     _currentDate = _currentDate.subtract(Duration(days: 7));
//                   });
//                 },
//               ),
//               Text(
//                 DateFormat('MMM d, yyyy').format(_currentDate),
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward),
//                 onPressed: () {
//                   setState(() {
//                     _currentDate = _currentDate.add(Duration(days: 7));
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 60, // Fixed height for the row of day cards
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: List.generate(
//                 7, // Assuming you want to display 7 days (a week)
//                 (index) => _buildDayCard(index),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayCard(int dayIndex) {
//     DateTime day = _currentDate.subtract(Duration(days: _currentDate.weekday - 1)).add(Duration(days: dayIndex));

//     // Logic to determine the day's label based on the index (e.g., Monday, Tuesday, etc.)
//     String dayLabel = _getDayLabel(dayIndex);

//     return GestureDetector(
//       onTap: () {
//         // Navigate to a detailed view for the selected day
//         // You can implement this navigation based on your app's navigation setup
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => DayDetailPage(dayIndex)));
//       },
//       child: Container(
//         width: 100, // Adjust the width according to your preference
//         height: 35, // Adjusted height
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.blueGrey[100],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               dayLabel,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             Text(
//               DateFormat('d').format(day),
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getDayLabel(int index) {
//     // Logic to determine the day's label based on the index
//     // You can customize this based on your preference
//     // For simplicity, let's assume Sunday is the first day of the week
//     List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//     return daysOfWeek[index];
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: SchedulePage(),
//   ));
// }

// // import 'package:flutter/material.dart';

// // class SchedulePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Schedule'),
// //       ),
// //       body: Container(
// //         height: 60, // Fixed height for the row of day cards
// //         child: ListView(
// //           scrollDirection: Axis.horizontal,
// //           children: List.generate(
// //             7, // Assuming you want to display 7 days (a week)
// //             (index) => _buildDayCard(index),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDayCard(int dayIndex) {
// //     // Logic to determine the day's label based on the index (e.g., Monday, Tuesday, etc.)
// //     String dayLabel = _getDayLabel(dayIndex);

// //     return GestureDetector(
// //       onTap: () {
// //         // Navigate to a detailed view for the selected day
// //         // You can implement this navigation based on your app's navigation setup
// //         // Navigator.push(context, MaterialPageRoute(builder: (context) => DayDetailPage(dayIndex)));
// //       },
// //       child: Container(
// //         width: 100, // Adjust the width according to your preference
// //         height: 40, // Adjusted height
// //         margin: EdgeInsets.all(8),
// //         decoration: BoxDecoration(
// //           color: Colors.blueGrey[100],
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Center(
// //           child: Text(
// //             dayLabel,
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               fontSize: 16,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   String _getDayLabel(int index) {
// //     // Logic to determine the day's label based on the index
// //     // You can customize this based on your preference
// //     // For simplicity, let's assume Sunday is the first day of the week
// //     List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
// //     return daysOfWeek[index];
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: SchedulePage(),
// //   ));
// // }


// // // import 'package:flutter/material.dart';

// // // class SchedulePage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Schedule'),
// // //       ),
// // //       body: Container(
// // //         padding: EdgeInsets.only(top: 20.0), // Add padding to the top
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //           children: List.generate(7, (index) {
// // //             final currentDate = DateTime.now();
// // //             final weekDay = (currentDate.weekday + index) % 7; // Adjust for the current day of the week
// // //             final dayDate = currentDate.add(Duration(days: index));

// // //             return GestureDetector(
// // //               onTap: () {
// // //                 // Handle tap on a specific day
// // //                 // You can navigate to a detail page or show a bottom sheet to add/edit schedule
// // //                 // You can pass the index to identify which day was tapped
// // //               },
// // //               child: Container(
// // //                 margin: EdgeInsets.all(5.0),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.blueGrey[200],
// // //                   borderRadius: BorderRadius.circular(10.0),
// // //                 ),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     Text(
// // //                       // Display the day name
// // //                       getDayOfWeek(weekDay),
// // //                       style: TextStyle(fontSize: 16.0),
// // //                     ),
// // //                     Text(
// // //                       // Display the day date
// // //                       '${dayDate.day}/${dayDate.month}',
// // //                       style: TextStyle(fontSize: 14.0),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           }),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   String getDayOfWeek(int weekDay) {
// // //     // Calculate the day of the week based on index
// // //     // Adjust this logic based on your requirement
// // //     switch (weekDay) {
// // //       case 1:
// // //         return 'Mon';
// // //       case 2:
// // //         return 'Tue';
// // //       case 3:
// // //         return 'Wed';
// // //       case 4:
// // //         return 'Thu';
// // //       case 5:
// // //         return 'Fri';
// // //       case 6:
// // //         return 'Sat';
// // //       case 0:
// // //         return 'Sun';
// // //       default:
// // //         return '';
// // //     }
// // //   }
// // // }

// // // void main() {
// // //   runApp(MaterialApp(
// // //     home: SchedulePage(),
// // //   ));
// // // }

// // // // import 'package:flutter/material.dart';

// // // // class SchedulePage extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Schedule'),
// // // //       ),
// // // //       body: Row(
// // // //         children: List.generate(7, (index) {
// // // //           final currentDate = DateTime.now();
// // // //           final weekDay = (currentDate.weekday + index) % 7; // Adjust for the current day of the week
// // // //           final dayDate = currentDate.add(Duration(days: index));

// // // //           return Expanded(
// // // //             child: GestureDetector(
// // // //               onTap: () {
// // // //                 // Handle tap on a specific day
// // // //                 // You can navigate to a detail page or show a bottom sheet to add/edit schedule
// // // //                 // You can pass the index to identify which day was tapped
// // // //               },
// // // //               child: Container(
// // // //                 margin: EdgeInsets.all(5.0),
// // // //                 decoration: BoxDecoration(
// // // //                   color: Colors.blueGrey[200],
// // // //                   borderRadius: BorderRadius.circular(10.0),
// // // //                 ),
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     Text(
// // // //                       // Display the day name
// // // //                       getDayOfWeek(weekDay),
// // // //                       style: TextStyle(fontSize: 16.0),
// // // //                     ),
// // // //                     Text(
// // // //                       // Display the day date
// // // //                       '${dayDate.day}/${dayDate.month}',
// // // //                       style: TextStyle(fontSize: 14.0),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           );
// // // //         }),
// // // //       ),
// // // //     );
// // // //   }

// // // //   String getDayOfWeek(int weekDay) {
// // // //     // Calculate the day of the week based on index
// // // //     // Adjust this logic based on your requirement
// // // //     switch (weekDay) {
// // // //       case 1:
// // // //         return 'Mon';
// // // //       case 2:
// // // //         return 'Tue';
// // // //       case 3:
// // // //         return 'Wed';
// // // //       case 4:
// // // //         return 'Thu';
// // // //       case 5:
// // // //         return 'Fri';
// // // //       case 6:
// // // //         return 'Sat';
// // // //       case 0:
// // // //         return 'Sun';
// // // //       default:
// // // //         return '';
// // // //     }
// // // //   }
// // // // }

// // // // void main() {
// // // //   runApp(MaterialApp(
// // // //     home: SchedulePage(),
// // // //   ));
// // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:table_calendar/table_calendar.dart';

// // // // // class SchedulePage extends StatefulWidget {
// // // // //   @override
// // // // //   _SchedulePageState createState() => _SchedulePageState();
// // // // // }

// // // // // class _SchedulePageState extends State<SchedulePage> {
// // // // //   late CalendarController _calendarController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _calendarController = CalendarController();
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _calendarController.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Schedule'),
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         child: TableCalendar(
// // // // //           calendarController: _calendarController,
// // // // //           availableCalendarFormats: {
// // // // //             CalendarFormat.week: 'Week', // Display mode: week view
// // // // //           },
// // // // //           startingDayOfWeek: StartingDayOfWeek.monday, // Start week from Monday
// // // // //           headerStyle: HeaderStyle(
// // // // //             formatButtonVisible: false, // Hide format button
// // // // //           ),
// // // // //           daysOfWeekStyle: DaysOfWeekStyle(
// // // // //             weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // //             weekendStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           calendarStyle: CalendarStyle(
// // // // //             todayStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // //             selectedStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // //           ),
// // // // //           builders: CalendarBuilders(
// // // // //             // Define a custom day builder
// // // // //             dayBuilder: (context, date, events) {
// // // // //               return Container(
// // // // //                 alignment: Alignment.center,
// // // // //                 margin: EdgeInsets.all(5.0),
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: _isToday(date) ? Colors.blueAccent : Colors.transparent,
// // // // //                   borderRadius: BorderRadius.circular(10.0),
// // // // //                 ),
// // // // //                 child: Column(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       '${date.day}', // Display day number
// // // // //                       style: TextStyle(fontSize: 16.0),
// // // // //                     ),
// // // // //                     Text(
// // // // //                       _getDayOfWeek(date), // Display day name
// // // // //                       style: TextStyle(fontSize: 14.0),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               );
// // // // //             },
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // Function to check if a date is today
// // // // //   bool _isToday(DateTime date) {
// // // // //     final now = DateTime.now();
// // // // //     return date.year == now.year && date.month == now.month && date.day == now.day;
// // // // //   }

// // // // //   // Function to get the name of the day
// // // // //   String _getDayOfWeek(DateTime date) {
// // // // //     switch (date.weekday) {
// // // // //       case 1:
// // // // //         return 'Mon';
// // // // //       case 2:
// // // // //         return 'Tue';
// // // // //       case 3:
// // // // //         return 'Wed';
// // // // //       case 4:
// // // // //         return 'Thu';
// // // // //       case 5:
// // // // //         return 'Fri';
// // // // //       case 6:
// // // // //         return 'Sat';
// // // // //       case 7:
// // // // //         return 'Sun';
// // // // //       default:
// // // // //         return '';
// // // // //     }
// // // // //   }
// // // // // }

// // // // // void main() {
// // // // //   runApp(MaterialApp(
// // // // //     home: SchedulePage(),
// // // // //   ));
// // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:table_calendar/table_calendar.dart';

// // // // // // class SchedulePage extends StatefulWidget {
// // // // // //   @override
// // // // // //   _SchedulePageState createState() => _SchedulePageState();
// // // // // // }

// // // // // // class _SchedulePageState extends State<SchedulePage> {
// // // // // //   CalendarController _calendarController;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _calendarController = CalendarController();
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _calendarController.dispose();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Schedule'),
// // // // // //       ),
// // // // // //       body: SingleChildScrollView(
// // // // // //         child: TableCalendar(
// // // // // //           calendarController: _calendarController,
// // // // // //           availableCalendarFormats: {
// // // // // //             CalendarFormat.week: 'Week', // Display mode: week view
// // // // // //           },
// // // // // //           startingDayOfWeek: StartingDayOfWeek.monday, // Start week from Monday
// // // // // //           headerStyle: HeaderStyle(
// // // // // //             formatButtonVisible: false, // Hide format button
// // // // // //           ),
// // // // // //           daysOfWeekStyle: DaysOfWeekStyle(
// // // // // //             weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // // //             weekendStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // // //           ),
// // // // // //           calendarStyle: CalendarStyle(
// // // // // //             todayStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // // //             selectedStyle: TextStyle(fontWeight: FontWeight.bold),
// // // // // //           ),
// // // // // //           builders: CalendarBuilders(
// // // // // //             // Define a custom day builder
// // // // // //             dayBuilder: (context, date, events) {
// // // // // //               return Container(
// // // // // //                 alignment: Alignment.center,
// // // // // //                 margin: EdgeInsets.all(5.0),
// // // // // //                 decoration: BoxDecoration(
// // // // // //                   color: _isToday(date) ? Colors.blueAccent : Colors.transparent,
// // // // // //                   borderRadius: BorderRadius.circular(10.0),
// // // // // //                 ),
// // // // // //                 child: Column(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                   children: [
// // // // // //                     Text(
// // // // // //                       '${date.day}', // Display day number
// // // // // //                       style: TextStyle(fontSize: 16.0),
// // // // // //                     ),
// // // // // //                     Text(
// // // // // //                       _getDayOfWeek(date), // Display day name
// // // // // //                       style: TextStyle(fontSize: 14.0),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               );
// // // // // //             },
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   // Function to check if a date is today
// // // // // //   bool _isToday(DateTime date) {
// // // // // //     final now = DateTime.now();
// // // // // //     return date.year == now.year && date.month == now.month && date.day == now.day;
// // // // // //   }

// // // // // //   // Function to get the name of the day
// // // // // //   String _getDayOfWeek(DateTime date) {
// // // // // //     switch (date.weekday) {
// // // // // //       case 1:
// // // // // //         return 'Mon';
// // // // // //       case 2:
// // // // // //         return 'Tue';
// // // // // //       case 3:
// // // // // //         return 'Wed';
// // // // // //       case 4:
// // // // // //         return 'Thu';
// // // // // //       case 5:
// // // // // //         return 'Fri';
// // // // // //       case 6:
// // // // // //         return 'Sat';
// // // // // //       case 7:
// // // // // //         return 'Sun';
// // // // // //       default:
// // // // // //         return '';
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // // void main() {
// // // // // //   runApp(MaterialApp(
// // // // // //     home: SchedulePage(),
// // // // // //   ));
// // // // // // }



// // // // // // // import 'package:flutter/material.dart';

// // // // // // // class SchedulePage extends StatelessWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: Text('Schedule'),
// // // // // // //       ),
// // // // // // //       body: GridView.builder(
// // // // // // //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // //           crossAxisCount: 7, // 7 days in a week
// // // // // // //         ),
// // // // // // //         itemCount: 7,
// // // // // // //         itemBuilder: (context, index) {
// // // // // // //           final currentDate = DateTime.now();
// // // // // // //           final weekDay = (currentDate.weekday + index) % 7; // Adjust for the current day of the week
// // // // // // //           final dayDate = currentDate.add(Duration(days: index));

// // // // // // //           return GestureDetector(
// // // // // // //             onTap: () {
// // // // // // //               // Handle tap on a specific day
// // // // // // //               // You can navigate to a detail page or show a bottom sheet to add/edit schedule
// // // // // // //               // You can pass the index to identify which day was tapped
// // // // // // //             },
// // // // // // //             child: Container(
// // // // // // //               alignment: Alignment.center,
// // // // // // //               margin: EdgeInsets.all(5.0),
// // // // // // //               decoration: BoxDecoration(
// // // // // // //                 color: Colors.blueGrey[200],
// // // // // // //                 borderRadius: BorderRadius.circular(10.0),
// // // // // // //               ),
// // // // // // //               child: Column(
// // // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //                 children: [
// // // // // // //                   Text(
// // // // // // //                     // Display the day name
// // // // // // //                     getDayOfWeek(weekDay),
// // // // // // //                     style: TextStyle(fontSize: 16.0),
// // // // // // //                   ),
// // // // // // //                   Text(
// // // // // // //                     // Display the day date
// // // // // // //                     '${dayDate.day}/${dayDate.month}',
// // // // // // //                     style: TextStyle(fontSize: 14.0),
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           );
// // // // // // //         },
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   String getDayOfWeek(int weekDay) {
// // // // // // //     // Calculate the day of the week based on index
// // // // // // //     // Adjust this logic based on your requirement
// // // // // // //     switch (weekDay) {
// // // // // // //       case 1:
// // // // // // //         return 'Mon';
// // // // // // //       case 2:
// // // // // // //         return 'Tue';
// // // // // // //       case 3:
// // // // // // //         return 'Wed';
// // // // // // //       case 4:
// // // // // // //         return 'Thu';
// // // // // // //       case 5:
// // // // // // //         return 'Fri';
// // // // // // //       case 6:
// // // // // // //         return 'Sat';
// // // // // // //       case 0:
// // // // // // //         return 'Sun';
// // // // // // //       default:
// // // // // // //         return '';
// // // // // // //     }
// // // // // // //   }
// // // // // // // }

// // // // // // // void main() {
// // // // // // //   runApp(MaterialApp(
// // // // // // //     home: SchedulePage(),
// // // // // // //   ));
// // // // // // // }

// // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // class SchedulePage extends StatelessWidget {
// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       appBar: AppBar(
// // // // // // // //         title: Text('Schedule'),
// // // // // // // //       ),
// // // // // // // //       body: GridView.builder(
// // // // // // // //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // // //           crossAxisCount: 7, // 7 days in a week
// // // // // // // //         ),
// // // // // // // //         itemCount: 7,
// // // // // // // //         itemBuilder: (context, index) {
// // // // // // // //           return GestureDetector(
// // // // // // // //             onTap: () {
// // // // // // // //               // Handle tap on a specific day
// // // // // // // //               // You can navigate to a detail page or show a bottom sheet to add/edit schedule
// // // // // // // //               // You can pass the index to identify which day was tapped
// // // // // // // //             },
// // // // // // // //             child: Container(
// // // // // // // //               alignment: Alignment.center,
// // // // // // // //               margin: EdgeInsets.all(5.0),
// // // // // // // //               decoration: BoxDecoration(
// // // // // // // //                 color: Colors.blueGrey[200],
// // // // // // // //                 borderRadius: BorderRadius.circular(10.0),
// // // // // // // //               ),
// // // // // // // //               child: Text(
// // // // // // // //                 // Display the day of the week
// // // // // // // //                 getDayOfWeek(index),
// // // // // // // //                 style: TextStyle(fontSize: 16.0),
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           );
// // // // // // // //         },
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   String getDayOfWeek(int index) {
// // // // // // // //     // Calculate the day of the week based on index
// // // // // // // //     // Adjust this logic based on your requirement
// // // // // // // //     switch (index) {
// // // // // // // //       case 0:
// // // // // // // //         return 'Mon';
// // // // // // // //       case 1:
// // // // // // // //         return 'Tue';
// // // // // // // //       case 2:
// // // // // // // //         return 'Wed';
// // // // // // // //       case 3:
// // // // // // // //         return 'Thu';
// // // // // // // //       case 4:
// // // // // // // //         return 'Fri';
// // // // // // // //       case 5:
// // // // // // // //         return 'Sat';
// // // // // // // //       case 6:
// // // // // // // //         return 'Sun';
// // // // // // // //       default:
// // // // // // // //         return '';
// // // // // // // //     }
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // void main() {
// // // // // // // //   runApp(MaterialApp(
// // // // // // // //     home: SchedulePage(),
// // // // // // // //   ));
// // // // // // // // }

// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:flutter/services.dart';

// // // // // // // // // void main() {
// // // // // // // // //    SystemChrome.setSystemUIOverlayStyle(
// // // // // // // // //         const SystemUiOverlayStyle(statusBarColor: Color(0xFF3C8243)));
// // // // // // // // //   runApp( MaterialApp(
       
// // // // // // // // //     debugShowCheckedModeBanner: false,
// // // // // // // // //     home: SchedulePage(),
// // // // // // // // //   ));
// // // // // // // // // }
// // // // // // // // // class SchedulePage extends StatefulWidget {
// // // // // // // // //   const SchedulePage({super.key});

// // // // // // // // //   @override
// // // // // // // // //   State<SchedulePage> createState() => _SchedulePageState();
// // // // // // // // // }

// // // // // // // // // class _SchedulePageState extends State<SchedulePage> {
// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return const Placeholder();
// // // // // // // // //   }
// // // // // // // // // }