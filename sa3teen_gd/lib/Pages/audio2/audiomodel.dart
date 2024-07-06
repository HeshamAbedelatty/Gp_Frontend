class Audio {
  final int id;
  final String user;
  final String fileName;
  final String filePath;
  final Duration duration;
  final DateTime uploadedDate;
  late final bool isFavorite;
  final Duration currentPosition;

  Audio({
    required this.id,
    required this.user,
    required this.fileName,
    required this.filePath,
    required this.duration,
    required this.uploadedDate,
    required this.isFavorite,
    required this.currentPosition,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      id: json['id'],
      user: json['user'],
      fileName: json['file_name'],
      filePath: json['file_path'],
      duration: Duration(
          seconds: int.parse(json['duration'].split(':').map((e) => e).join())),
      uploadedDate: DateTime.parse(json['uploaded_date']),
      isFavorite: json['is_favorite'],
      currentPosition: Duration(
          seconds: int.parse(
              json['current_position'].split(':').map((e) => e).join())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'file_name': fileName,
      'file_path': filePath,
      'duration': duration.inSeconds.toString(),
      'uploaded_date': uploadedDate.toIso8601String(),
      'is_favorite': isFavorite,
      'current_position': currentPosition.inSeconds.toString(),
    };
  }
}
