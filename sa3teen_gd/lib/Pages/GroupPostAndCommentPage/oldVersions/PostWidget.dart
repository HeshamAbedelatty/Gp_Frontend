// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';

// class PostWidget extends StatelessWidget {
//   final Post post;
//   final VoidCallback onDelete;
//   final VoidCallback onLike;
//   final VoidCallback onDislike;
//   final Function(String) onComment;

//   PostWidget({
//     required this.post,
//     required this.onDelete,
//     required this.onLike,
//     required this.onDislike,
//     required this.onComment,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _commentController = TextEditingController();

//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(post.creatorImageUrl),
//                 ),
//                 SizedBox(width: 10),
//                 Text(post.creatorName, style: TextStyle(fontWeight: FontWeight.bold)),
//                 Spacer(),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: onDelete,
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text(post.content),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.thumb_up),
//                   onPressed: onLike,
//                 ),
//                 Text(post.likes.toString()),
//                 IconButton(
//                   icon: Icon(Icons.thumb_down),
//                   onPressed: onDislike,
//                 ),
//                 Text(post.dislikes.toString()),
//               ],
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _commentController,
//                     decoration: InputDecoration(hintText: 'Write a comment...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_commentController.text.isNotEmpty) {
//                       onComment(_commentController.text);
//                       _commentController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//             ...post.comments.map((comment) => ListTile(
//               leading: Icon(Icons.comment),
//               title: Text(comment.content),
//               subtitle: Text(comment.creatorName),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
