class Post {
  final String id;
  final String content;
  final String creatorName;
  final String creatorImageUrl;
  int likes;
  int dislikes;
  final DateTime createdAt;
  bool showComments;
  List<Comment> comments;

  Post({
    required this.id,
    required this.content,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
    this.showComments = false,
    this.comments = const [],
  });
}

class Comment {
  final String id;
  final String content;
  final String creatorName;
  final String creatorImageUrl;
  final DateTime createdAt;
  int likes;
  int dislikes;
  List<Reply> replies;

  Comment({
    required this.id,
    required this.content,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.createdAt,
    this.likes = 0,
    this.dislikes = 0,
    this.replies = const [],
  });
}

class Reply {
  final String id;
  final String content;
  final String creatorName;
  final String creatorImageUrl;
  final DateTime createdAt;

  Reply({
    required this.id,
    required this.content,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.createdAt,
  });
}
