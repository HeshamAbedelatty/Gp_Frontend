// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// import 'package:like_button/like_button.dart';

// class PostListWidget extends StatelessWidget {
//   final List<Post> posts;
//   final Function(String) deletePost;
//   final Function(String) toggleComments;
//   final Function(String, String) addComment;
//   final Function(String, String, bool) toggleCommentLike;
//   final Function(String, String) deleteComment;
//   final Function(String, String, String) addReply;
//   final Map<String, TextEditingController> commentControllers;
//   final Map<String, TextEditingController> replyControllers;
//   final Map<String, bool> showReplyFields;

//   const PostListWidget({
//     Key? key,
//     required this.posts,
//     required this.deletePost,
//     required this.toggleComments,
//     required this.addComment,
//     required this.toggleCommentLike,
//     required this.deleteComment,
//     required this.addReply,
//     required this.commentControllers,
//     required this.replyControllers,
//     required this.showReplyFields,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final post = posts[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               shadowColor: Colors.black,
//               color: Colors.white, // Adjust this as per your `kprimaryColourWhite`
//               margin: const EdgeInsets.all(8.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(post.creatorImageUrl),
//                         ),
//                         const SizedBox(width: 10.0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(post.creatorName,
//                                 style: const TextStyle(fontWeight: FontWeight.bold)),
//                             Text(post.createdAt.toString(), // Use your _formatTimestamp method here
//                                 style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
//                           ],
//                         ),
//                         const Spacer(),
//                         PopupMenuButton<String>(
//                           onSelected: (String value) {
//                             if (value == 'delete') {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialog(
//                                   title: Text('Delete Post'),
//                                   content: Text('Are you sure you want to delete this post?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         deletePost(post.id);
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Text('Delete'),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }
//                           },
//                           itemBuilder: (BuildContext context) {
//                             return {'delete'}.map((String choice) {
//                               return PopupMenuItem<String>(
//                                 value: choice,
//                                 child: Text(choice),
//                               );
//                             }).toList();
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10.0),
//                     Text(post.content, style: const TextStyle(fontSize: 16.0)),
//                     const SizedBox(height: 10.0),
//                     Row(
//                       children: [
//                         LikeButton(
//                           circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                           bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5), dotSecondaryColor: Color(0xff0099cc)),
//                           likeBuilder: (bool isLiked) {
//                             return Icon(
//                               Icons.thumb_up,
//                               color: isLiked ? Colors.green.shade700 : Colors.brown.shade200,
//                             );
//                           },
//                           likeCount: post.likes,
//                         ),
//                         Text(
//                           ' Likes',
//                           style: TextStyle(
//                             color: Colors.brown.shade200,
//                           ),
//                         ),
//                         const Spacer(flex: 1),
//                         LikeButton(
//                           circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                           bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5), dotSecondaryColor: Color(0xff0099cc)),
//                           likeBuilder: (bool isLiked) {
//                             return Icon(
//                               Icons.thumb_down,
//                               color: isLiked ? Colors.green.shade700 : Colors.brown.shade200,
//                             );
//                           },
//                           likeCount: post.dislikes,
//                         ),
//                         Text(
//                           ' Dislikes',
//                           style: TextStyle(
//                             color: Colors.brown.shade200,
//                           ),
//                         ),
//                         const Spacer(flex: 1),
//                         IconButton(
//                           onPressed: () {
//                             toggleComments(post.id);
//                           },
//                           icon: Icon(
//                             Icons.comment,
//                             color: Colors.brown.shade200,
//                           ),
//                         ),
//                         Text(
//                           'Comments',
//                           style: TextStyle(
//                             color: Colors.brown.shade200,
//                           ),
//                         ),
//                         const Spacer(flex: 1),
//                         LikeButton(
//                           likeBuilder: (bool isLiked) {
//                             return Icon(
//                               Icons.favorite,
//                               color: isLiked ? Colors.red.shade900 : Colors.brown.shade200,
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10.0),
//                     if (post.showComments) ...[
//                       const Divider(),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               controller: commentControllers[post.id],
//                               decoration: InputDecoration(
//                                 hintText: 'Add a comment',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                               ),
//                               onFieldSubmitted: (text) {
//                                 if (text.isNotEmpty) {
//                                   addComment(post.id, text);
//                                   commentControllers[post.id]?.clear();
//                                 }
//                               },
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.send,
//                               color: Colors.brown.shade200,
//                             ),
//                             onPressed: () {
//                               if (commentControllers[post.id]?.text.isNotEmpty ?? false) {
//                                 addComment(post.id, commentControllers[post.id]!.text);
//                                 commentControllers[post.id]?.clear();
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: post.comments.length,
//                         itemBuilder: (context, index) {
//                           final comment = post.comments[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(35.0),
//                               ),
//                               color: Colors.white,
//                               margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 15,
//                                           backgroundImage: NetworkImage(comment.creatorImageUrl),
//                                         ),
//                                         const SizedBox(width: 10.0),
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(comment.creatorName,
//                                                 style: const TextStyle(fontWeight: FontWeight.bold)),
//                                             Text(comment.createdAt.toString(), // Use your _formatTimestamp method here
//                                                 style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
//                                             Text(comment.content),
//                                           ],
//                                         ),
//                                         const Spacer(),
//                                         LikeButton(
//                                           circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                                           bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5), dotSecondaryColor: Color(0xff0099cc)),
//                                           likeBuilder: (bool isLiked) {
//                                             return Icon(
//                                               Icons.thumb_up,
//                                               color: isLiked ? Colors.green.shade700 : Colors.brown.shade200,
//                                               size: 18,
//                                             );
//                                           },
//                                           likeCount: comment.likes,
//                                           onTap: (isLiked) async {
//                                             toggleCommentLike(post.id, comment.id, true);
//                                             return !isLiked;
//                                           },
//                                         ),
//                                         const SizedBox(width: 8.0),
//                                         LikeButton(
//                                           circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
//                                           bubblesColor: const BubblesColor(dotPrimaryColor: Color(0xff33b5e5), dotSecondaryColor: Color(0xff0099cc)),
//                                           likeBuilder: (bool isLiked) {
//                                             return Icon(
//                                               Icons.thumb_down,
//                                               color: isLiked ? Colors.green.shade700 : Colors.brown.shade200,
//                                               size: 18,
//                                             );
//                                           },
//                                           likeCount: comment.dislikes,
//                                           onTap: (isLiked) async {
//                                             toggleCommentLike(post.id, comment.id, false);
//                                             return !isLiked;
//                                           },
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             deleteComment(post.id, comment.id);
//                                           },
//                                           icon: Icon(
//                                             Icons.delete,
//                                             color: Colors.brown.shade200,
//                                             size: 18,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                               icon: Icon(
//                                                 Icons.reply,
//                                                 color: Colors.brown.shade200,
//                                                 size: 18,
//                                               ),
//                                               onPressed: () {
//                                                 showReplyFields[comment.id] = !(showReplyFields[comment.id] ?? false);
//                                               },
//                                             ),
//                                             const Text('Reply'),
//                                           ],
//                                         ),
//                                         if (showReplyFields[comment.id] ?? false)
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   controller: replyControllers[comment.id],
//                                                   decoration: InputDecoration(
//                                                     hintText: 'Add a reply',
//                                                     border: OutlineInputBorder(
//                                                       borderRadius: BorderRadius.circular(25),
//                                                     ),
//                                                   ),
//                                                   onFieldSubmitted: (text) {
//                                                     if (text.isNotEmpty) {
//                                                       addReply(post.id, comment.id, text);
//                                                       replyControllers[comment.id]?.clear();
//                                                     }
//                                                   },
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(
//                                                   Icons.send,
//                                                   color: Colors.brown.shade200,
//                                                 ),
//                                                 onPressed: () {
//                                                   if (replyControllers[comment.id]?.text.isNotEmpty ?? false) {
//                                                     String replyText = replyControllers[comment.id]!.text;
//                                                     addReply(post.id, comment.id, replyText);
//                                                     replyControllers[comment.id]?.clear();
//                                                   }
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         ListView.builder(
//                                           shrinkWrap: true,
//                                           physics: const NeverScrollableScrollPhysics(),
//                                           itemCount: comment.replies.length,
//                                           itemBuilder: (context, replyIndex) {
//                                             final reply = comment.replies[replyIndex];
//                                             return Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   CircleAvatar(
//                                                     radius: 12,
//                                                     backgroundImage: NetworkImage(reply.creatorImageUrl),
//                                                   ),
//                                                   const SizedBox(width: 10.0),
//                                                   Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(reply.creatorName,
//                                                           style: const TextStyle(fontWeight: FontWeight.bold)),
//                                                       Text(reply.createdAt.toString(), // Use your _formatTimestamp method here
//                                                           style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
//                                                       Text(reply.content),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
