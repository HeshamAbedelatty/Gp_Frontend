import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constants.dart';

class customAppBar extends StatelessWidget {
  const customAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person),
        Spacer(),
        Text(
          "ToDoList",
          style: TextStyle(fontSize: 20),
        ),
        Spacer(),
        Container(
          height: 27,
          width: 27,
          color: KPrimaryColourGreen ,
          child: Center(
            child: Icon(Icons.search),
          ),
        ),
        Container(
          height: 27,
          width: 27,
          color: KPrimaryColourGreen,
          child: Center(
            child: Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}
