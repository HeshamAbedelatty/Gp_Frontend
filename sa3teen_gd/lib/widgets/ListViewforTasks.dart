import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';
import 'package:sa3teen_gd/widgets/taskItems.dart';

class ListViewforTasks extends StatelessWidget {
  const ListViewforTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return taskItem();
    });
  }
}












// ListView(
//           // padding: EdgeInsets.symmetric(horizontal: 20),
//           children: const [
//             customAppBar(),
//             SizedBox(height: 30),
//             taskItem(),
//             taskItem(),
//             taskItem(),
//             taskItem(),
//             taskItem(),
//             // Container(
//             //   width: 300,
//             //   height: 300,
//             //   color: KPrimaryColourGreen,
//             // ),
//           ],
//         ),