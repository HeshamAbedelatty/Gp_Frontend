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

class Reply {
  final int id;
  final String description;
  final String? image;
  final DateTime createdAt;
  final int likes;
  final User user;
  final String group;
  final int comment;
  final bool userHasLiked;

  Reply({
    required this.id,
    required this.description,
    this.image,
    required this.createdAt,
    required this.likes,
    required this.user,
    required this.group,
    required this.comment,
    required this.userHasLiked,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      likes: json['likes'],
      user: User.fromJson(json['user']),
      group: json['group'],
      comment: json['comment'],
      userHasLiked: json['user_has_liked'],
    );
  }
}

class Comment {
  final int id;
  final String description;
  final String? image;
  final DateTime createdAt;
  final int likes;
  final User user;
  final String group;
  final int post;
  final bool userHasLiked;
  final List<Reply> replies;

  Comment({
    required this.id,
    required this.description,
    this.image,
    required this.createdAt,
    required this.likes,
    required this.user,
    required this.group,
    required this.post,
    required this.userHasLiked,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      likes: json['likes'],
      user: User.fromJson(json['user']),
      group: json['group'],
      post: json['post'],
      userHasLiked: json['user_has_liked'],
      replies: (json['replies'] as List).map((i) => Reply.fromJson(i)).toList(),
    );
  }
}
