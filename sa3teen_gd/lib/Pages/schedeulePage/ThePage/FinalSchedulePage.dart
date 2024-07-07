import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/EditTaskScreen.dart';
import 'package:gp_screen/Pages/schedeulePage/ThePage/addScheduleTask.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';
import 'package:provider/provider.dart';

import '../../../Services/API_services.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int remindInterval;
  final Color color;

  Task({
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

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  Api_services api_services = Api_services();

  List<Task> _tasks = [];

  int selecteditem = 0;



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

  String getDayName(DateTime dateTime) {
    return DateFormat.EEEE().format(dateTime);
  }

initState(){

    super.initState();
     _fetchToDoList();
}

  _fetchToDoList(){
    Provider.of<Api_services>(context,listen: false).listSchedule(accessToken);
  }
  @override
  Widget build(BuildContext context) {
   // final providerprocess = Provider.of<Api_services>(context);
    // Calculate the starting date to be the previous Saturday
    DateTime startingDate =
    _currentDate.subtract(Duration(days: _currentDate.weekday - 6));

    return Scaffold(
      body: Consumer<Api_services> (
        builder: (context, Api_services providerprocess, child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAppBar(
                    title: 'Schedule',
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  SizedBox(
                    height: 70, // Adjusted height for the row of day cards
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        7,
                            (index) =>
                            _buildDayCard(startingDate.add(Duration(days: index))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: providerprocess.listScheduledetails .length,
                      itemBuilder: (context, index) {
                        selecteditem = index;
                        return _buildTaskCard(providerprocess.listScheduledetails[index],providerprocess);
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3C8243),
                    ),
                    onPressed: () {
                      _showAddTaskScreen(context, null);
                    },
                    child: const Text(
                      'Add lecture time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildDayCard(DateTime day) {
    String dayLabel = DateFormat('E').format(day);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = day;
        });
      },
      child: Container(
        width: 70,
        height: 35,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _selectedDate == day
              ? const Color(0xFF3C8243)
              : const Color.fromARGB(255, 235, 232, 231),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            dayLabel,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _selectedDate == day ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(listSchedule,providerprocess) {
    // Check if the task's date matches the day name of the selected date
    if ((listSchedule['day']) == getDayName(_selectedDate)) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.grey, width: 0.1),
                  ),
                  color: hexToColor(listSchedule['color']),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 8, right: 8, top: 5),
                    child: Text(
                      '${(listSchedule['start_time'])}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.grey, width: 0.1),
                  ),
                  color: hexToColor(listSchedule['color']),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 8, right: 8, top: 5),
                    child: Text(
                      '${(listSchedule['end_time'])}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              // Ensure Expanded is directly inside Row
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: Colors.grey, width: 0.1),
                ),
                color: hexToColor(listSchedule['color']),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // Ensure Row is here
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listSchedule['title'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              listSchedule['description'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () async {
                          _showAddTaskScreen(context, listSchedule);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete this slot?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3C8243),
                                    ),
                                    onPressed: () async {
                                      providerprocess.DeleteSlot(listSchedule['id'], accessToken);
                                      // await api_services.deleteSlot(listSchedule['id'], accessToken);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(); // Return an empty container if the task's date doesn't match the selected date
  }
  //
  // void _showAddTaskScreen(BuildContext context,providerprocess) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddTaskScreen()),
  //   );// Refresh the task list after adding a new task
  //
  // }

  void _showAddTaskScreen(BuildContext context,dynamic listSchedule) {

   showDialog(context: context, builder: (context)=> EditTaskScreen(
     // onSaveTask: (String title , String day, TimeOfDay start, TimeOfDay end , int remain, Color  color)  {
     // Add the task to the list of tasks
     // setState(() {
     //   _tasks.add(task);
     //   // });
     //   return _tasks;
     // },
     task: EditTask(

       id: listSchedule == null ? null :

       listSchedule!['id'],

       title: listSchedule == null ? "" :
       listSchedule['title'],
       description:listSchedule == null ? "" : listSchedule['description'],
       day: _selectedDate,
       startTime: listSchedule == null ? null : TimeOfDay(
         hour: int.parse(listSchedule['start_time'].split(':')[0]),
         minute: int.parse(listSchedule['start_time'].split(':')[1]),
       ),
       endTime:listSchedule == null ? null : TimeOfDay(
         hour: int.parse(listSchedule['end_time'].split(':')[0]),
         minute: int.parse(listSchedule['end_time'].split(':')[1]),
       ),
       remindInterval: 5, // Set the remindInterval appropriately
       color: listSchedule == null ? null : hexToColor(listSchedule['color']),
     ),
   ));
  }
}
