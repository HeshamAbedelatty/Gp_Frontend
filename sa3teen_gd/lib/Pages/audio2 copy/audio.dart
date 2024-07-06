import 'package:hive/hive.dart';

part 'audiomodel.g.dart';

@HiveType(typeId: 0)
class Audio {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String user;

  @HiveField(2)
  final String fileName;

  @HiveField(3)
  final String filePath;

  @HiveField(4)
  final Duration duration;

  @HiveField(5)
  final DateTime uploadedDate;

  @HiveField(6)
  bool isFavorite;

  @HiveField(7)
  Duration currentPosition;

  Audio({
    required this.id,
    required this.user,
    required this.fileName,
    required this.filePath,
    required this.duration,
    required this.uploadedDate,
    this.isFavorite = false,
    this.currentPosition = Duration.zero,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      id: json['id'],
      user: json['user'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      duration: _parseDuration(json['duration']),
      uploadedDate: DateTime.parse(json['uploaded_date']),
      isFavorite: json['is_favorite'],
      currentPosition: _parseDuration(json['current_position']),
    );
  }

  static Duration _parseDuration(String duration) {
    final parts = duration.split(':').map(int.parse).toList();
    return Duration(hours: parts[0], minutes: parts[1], seconds: parts[2]);
  }
}
