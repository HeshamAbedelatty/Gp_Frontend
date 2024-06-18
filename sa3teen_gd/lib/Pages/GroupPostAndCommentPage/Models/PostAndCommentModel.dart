class Post {
  String id;
  String content;
  String creatorName;
  String creatorImageUrl;
  int likes;
  int dislikes;
  List<Comment> comments;
  bool showComments;

  Post({
    required this.id,
    required this.content,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.likes,
    required this.dislikes,
    List<Comment>? comments,
    this.showComments = false,
  }) : this.comments = comments ?? [];
}

class Comment {
  String id;
  String content;
  String creatorName;
  String creatorImageUrl;
  DateTime createdAt;
  int likes;
  int dislikes;

  Comment({
    required this.id,
    required this.content,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.createdAt,
    this.likes = 0,
    this.dislikes = 0,
  });
}

// class Post {
//   String id;
//   String content;
//   String creatorName;
//   String creatorImageUrl;
//   int likes;
//   int dislikes;
//   List<Comment> comments;
//   bool showComments;

//   Post({
//     required this.id,
//     required this.content,
//     required this.creatorName,
//     required this.creatorImageUrl,
//     required this.likes,
//     required this.dislikes,
//     List<Comment>? comments,
//     this.showComments = false,
//   }) : this.comments = comments ?? [];
// }

// class Comment {
//   String id;
//   String content;
//   String creatorName;
//   String creatorImageUrl;
//   DateTime createdAt;

//   Comment({
//     required this.id,
//     required this.content,
//     required this.creatorName,
//     required this.creatorImageUrl,
//     required this.createdAt,
//   });
// }

// // class Post {
// //   String id;
// //   String content;
// //   String creatorName;
// //   String creatorImageUrl;
// //   int likes;
// //   int dislikes;
// //   List<Comment> comments;
// //   bool showComments; // Add this line

// //   Post({
// //     required this.id,
// //     required this.content,
// //     required this.creatorName,
// //     required this.creatorImageUrl,
// //     required this.likes,
// //     required this.dislikes,
// //     List<Comment>? comments,
// //     this.showComments = false, // Initialize with false
// //   }) : this.comments = comments ?? [];
// // }

// // class Comment {
// //   String id;
// //   String content;

// //   Comment({required this.id, required this.content});
// // }

// // // class Post {
// // //   String id;
// // //   String content;
// // //   String creatorName;
// // //   String creatorImageUrl;
// // //   int likes;
// // //   int dislikes;
// // //   List<Comment> comments;

// // //   Post({
// // //     required this.id,
// // //     required this.content,
// // //     required this.creatorName,
// // //     required this.creatorImageUrl,
// // //     required this.likes,
// // //     required this.dislikes,
// // //      List<Comment>? comments, // Make comments nullable
// // //   }) : this.comments = comments ?? []; // Initialize with an empty list if comments are null

// // // }

// // // class Comment {
// // //   String id;
// // //   String content;

// // //   Comment({required this.id, required this.content});
// // // }
