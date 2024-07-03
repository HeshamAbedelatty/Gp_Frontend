class Post {
  final int id;
  final String description;
  final String? image;
  final String createdAt;
  final int likes;
  final bool userHasLiked;
  final String group;
  final User user;

  Post({
    required this.id,
    required this.description,
    this.image,
    required this.createdAt,
    required this.likes,
    required this.userHasLiked,
    required this.group,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      likes: json['likes'],
      userHasLiked: json['user_has_liked'],
      group: json['group'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String username;
  final String? image;

  User({required this.username, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      image: json['image'],
    );
  }
}
