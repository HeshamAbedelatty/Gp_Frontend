// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

class AudioAdapter extends TypeAdapter<Audio> {
  @override
  final int typeId = 0;

  @override
  Audio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audio(
      id: fields[0] as int,
      user: fields[1] as String,
      fileName: fields[2] as String,
      filePath: fields[3] as String,
      duration: Duration(milliseconds: fields[4] as int),
      uploadedDate: fields[5] as DateTime,
      isFavorite: fields[6] as bool,
      currentPosition: Duration(milliseconds: fields[7] as int),
    );
  }

  @override
  void write(BinaryWriter writer, Audio obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.fileName)
      ..writeByte(3)
      ..write(obj.filePath)
      ..writeByte(4)
      ..write(obj.duration.inMilliseconds)
      ..writeByte(5)
      ..write(obj.uploadedDate)
      ..writeByte(6)
      ..write(obj.isFavorite)
      ..writeByte(7)
      ..write(obj.currentPosition.inMilliseconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
