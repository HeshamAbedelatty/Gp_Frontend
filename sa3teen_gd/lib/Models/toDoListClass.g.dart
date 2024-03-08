// // GENERATED CODE - DO NOT MODIFY BY HAND
// import 'package:hive/hive.dart';
// import 'package:sa3teen_gd/Models/toDoListClass.dart';
// //part of 'toDoListClass.dart'; //comment to remove the error

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class ToDoListClassAdapter extends TypeAdapter<ToDoListClass> {
//   @override
//   final int typeId = 0;

//   @override
//   ToDoListClass read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return ToDoListClass(
//       taskName: fields[0] as String,
//       date: fields[1] as String,
//       color: fields[2] as int,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, ToDoListClass obj) {
//     writer
//       ..writeByte(3)
//       ..writeByte(0)
//       ..write(obj.taskName)
//       ..writeByte(1)
//       ..write(obj.date)
//       ..writeByte(2)
//       ..write(obj.color);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ToDoListClassAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
