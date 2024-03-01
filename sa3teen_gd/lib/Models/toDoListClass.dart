import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

//part 'toDoListClass.g.dart'; //comment to remove the error

@HiveType(typeId: 0)
class ToDoListClass extends HiveObject {
  @HiveField(0)
  final String taskName;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final int color;
  //final String priority;
  ToDoListClass({
    required this.taskName,
    required this.date,
    required this.color,
  });
}
