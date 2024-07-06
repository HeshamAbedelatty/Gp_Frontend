// ignore_for_file: file_names

class MaterialModel {
  final int id;
  final User user;
  final String title;
  final String mediaPath;
  final DateTime uploadedTime;

  MaterialModel({
    required this.id,
    required this.user,
    required this.title,
    required this.mediaPath,
    required this.uploadedTime,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      title: json['title'],
      mediaPath: json['media_path'],
      uploadedTime: DateTime.parse(json['uploaded_Time']),
    );
  }
}

class User {
  final String username;
  final String image;

  User({required this.username, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      image: json['image'],
    );
  }
}
