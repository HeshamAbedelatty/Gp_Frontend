/// working i will leave it just in case 

// import 'package:flutter/material.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import '../Models/PostAndCommentModel.dart';
// import 'package:like_button/like_button.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Post> _posts = [];
//   Map<String, TextEditingController> _commentControllers = {};

//   void _addPost(String content) {
//     setState(() {
//       final newPost = Post(
//         id: DateTime.now().toString(),
//         content: content,
//         creatorName: 'Salma',
//         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
//         likes: 0,
//         dislikes: 0,
//         createdAt: DateTime.now(),
//       );
//       _posts.add(newPost);
//       _commentControllers[newPost.id] = TextEditingController();
//     });
//   }

//   void _addComment(String postId, String content) {
//     final postIndex = _posts.indexWhere((post) => post.id == postId);
//     if (postIndex != -1) {
//       setState(() {
//         _posts[postIndex].comments.add(Comment(
//               id: DateTime.now().toString(),
//               content: content,
//               creatorName:
//                   'Commenter Name', // Replace with actual commenter name
//               creatorImageUrl:
//                   'https://example.com/commenter_profile_picture.jpg', // Replace with actual image URL
//               createdAt: DateTime.now(),
//             ));
//       });
//       _commentControllers[postId]?.clear();
//     }
//   }

//   void _toggleComments(String postId) {
//     setState(() {
//       final postIndex = _posts.indexWhere((post) => post.id == postId);
//       if (postIndex != -1) {
//         _posts[postIndex].showComments = !_posts[postIndex].showComments;
//       }
//     });
//   }

//   void _toggleCommentLike(String postId, String commentId, bool isLike) {
//     setState(() {
//       final postIndex = _posts.indexWhere((post) => post.id == postId);
//       if (postIndex != -1) {
//         final commentIndex = _posts[postIndex]
//             .comments
//             .indexWhere((comment) => comment.id == commentId);
//         if (commentIndex != -1) {
//           if (isLike) {
//             _posts[postIndex].comments[commentIndex].likes++;
//           } else {
//             _posts[postIndex].comments[commentIndex].dislikes++;
//           }
//         }
//       }
//     });
//   }

//   void _showPostDialog() {
//     final TextEditingController _postController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Create Post'),
//           content: TextField(
//             controller: _postController,
//             decoration:
//                 const InputDecoration(hintText: 'What\'s on your mind?'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_postController.text.isNotEmpty) {
//                   _addPost(_postController.text);
//                 }
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Post'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteComment(String postId, String commentId) {
//     setState(() {
//       final postIndex = _posts.indexWhere((post) => post.id == postId);
//       if (postIndex != -1) {
//         _posts[postIndex]
//             .comments
//             .removeWhere((comment) => comment.id == commentId);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _commentControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     super.dispose();
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text('The Group')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _posts.length,
//               itemBuilder: (context, index) {
//                 final post = _posts[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     shadowColor: Colors.black,
//                     color: kprimaryColourWhite,
//                     margin: const EdgeInsets.all(8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 backgroundImage:
//                                     NetworkImage(post.creatorImageUrl),
//                               ),
//                               const SizedBox(width: 10.0),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(post.creatorName,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   Text(_formatTimestamp(post.createdAt),
//                                       style: const TextStyle(
//                                           color: Colors.grey, fontSize: 12.0)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10.0),
//                           Text(post.content,
//                               style: const TextStyle(fontSize: 16.0)),
//                           const SizedBox(height: 10.0),
//                           Row(
//                             children: [
//                               LikeButton(
//                                 circleColor: const CircleColor(
//                                     start: Color(0xff00ddff),
//                                     end: Color(0xff0099cc)),
//                                 bubblesColor: const BubblesColor(
//                                   dotPrimaryColor: Color(0xff33b5e5),
//                                   dotSecondaryColor: Color(0xff0099cc),
//                                 ),
//                                 likeBuilder: (bool isLiked) {
//                                   return Icon(
//                                     Icons.thumb_up,
//                                     color: isLiked
//                                         ? Colors.green.shade700
//                                         : Colors.brown.shade200,
//                                   );
//                                 },
//                                 likeCount: post.likes,
//                               ),
//                               Text(
//                                 ' Likes',
//                                 style: TextStyle(
//                                   color: Colors.brown.shade200,
//                                 ),
//                               ),
//                               const Spacer(flex: 1),
//                               LikeButton(
//                                 circleColor: const CircleColor(
//                                     start: Color(0xff00ddff),
//                                     end: Color(0xff0099cc)),
//                                 bubblesColor: const BubblesColor(
//                                   dotPrimaryColor: Color(0xff33b5e5),
//                                   dotSecondaryColor: Color(0xff0099cc),
//                                 ),
//                                 likeBuilder: (bool isLiked) {
//                                   return Icon(
//                                     Icons.thumb_down,
//                                     color: isLiked
//                                         ? Colors.green.shade700
//                                         : Colors.brown.shade200,
//                                   );
//                                 },
//                                 likeCount: post.dislikes,
//                               ),
//                               Text(
//                                 ' Dislikes',
//                                 style: TextStyle(
//                                   color: Colors.brown.shade200,
//                                 ),
//                               ),
//                               const Spacer(flex: 1),
//                               IconButton(
//                                 onPressed: () {
//                                   _toggleComments(post.id);
//                                 },
//                                 icon: Icon(
//                                   Icons.comment,
//                                   color: Colors.brown.shade200,
//                                 ),
//                               ),
//                               Text(
//                                 'Comments',
//                                 style: TextStyle(
//                                   color: Colors.brown.shade200,
//                                 ),
//                               ),
//                               const Spacer(flex: 1),
//                               LikeButton(
//                                 likeBuilder: (bool isLiked) {
//                                   return Icon(
//                                     Icons.favorite,
//                                     color: isLiked
//                                         ? Colors.red.shade900
//                                         : Colors.brown.shade200,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10.0),
//                           if (post.showComments) ...[
//                             const Divider(),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: _commentControllers[post.id],
//                                     decoration: InputDecoration(
//                                       hintText: 'Add a comment',
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(25)),
//                                     ),
//                                     onFieldSubmitted: (text) {
//                                       if (text.isNotEmpty) {
//                                         _addComment(post.id, text);
//                                         _commentControllers[post.id]?.clear();
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.send,
//                                     color: Colors.brown.shade200,
//                                   ),
//                                   onPressed: () {
//                                     if (_commentControllers[post.id]
//                                             ?.text
//                                             .isNotEmpty ??
//                                         false) {
//                                       _addComment(post.id,
//                                           _commentControllers[post.id]!.text);
//                                       _commentControllers[post.id]?.clear();
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: post.comments.length,
//                               itemBuilder: (context, index) {
//                                 final comment = post.comments[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Card(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           35.0), // Adjust the value as needed
//                                     ),
//                                     color: Colors.white,
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 4.0, horizontal: 8.0),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 15,
//                                                 backgroundImage: NetworkImage(
//                                                     comment.creatorImageUrl),
//                                               ),
//                                               const SizedBox(width: 10.0),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(comment.creatorName,
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                                   Text(
//                                                       _formatTimestamp(
//                                                           comment.createdAt),
//                                                       style: const TextStyle(
//                                                           color: Colors.grey,
//                                                           fontSize: 12.0)),
//                                                   Text(comment.content),
//                                                 ],
//                                               ),
//                                               const Spacer(
//                                                 flex: 1,
//                                               ),
//                                               LikeButton(
//                                                 circleColor: const CircleColor(
//                                                     start: Color(0xff00ddff),
//                                                     end: Color(0xff0099cc)),
//                                                 bubblesColor:
//                                                     const BubblesColor(
//                                                   dotPrimaryColor:
//                                                       Color(0xff33b5e5),
//                                                   dotSecondaryColor:
//                                                       Color(0xff0099cc),
//                                                 ),
//                                                 likeBuilder: (bool isLiked) {
//                                                   return Icon(
//                                                     Icons.thumb_up,
//                                                     color: isLiked
//                                                         ? Colors.green.shade700
//                                                         : Colors.brown.shade200,
//                                                     size: 18,
//                                                   );
//                                                 },
//                                                 likeCount: comment.likes,
//                                                 onTap: (isLiked) async {
//                                                   _toggleCommentLike(post.id,
//                                                       comment.id, true);
//                                                   return !isLiked;
//                                                 },
//                                               ),
//                                               const SizedBox(width: 8.0),
//                                               LikeButton(
//                                                 circleColor: const CircleColor(
//                                                     start: Color(0xff00ddff),
//                                                     end: Color(0xff0099cc)),
//                                                 bubblesColor:
//                                                     const BubblesColor(
//                                                   dotPrimaryColor:
//                                                       Color(0xff33b5e5),
//                                                   dotSecondaryColor:
//                                                       Color(0xff0099cc),
//                                                 ),
//                                                 likeBuilder: (bool isLiked) {
//                                                   return Icon(
//                                                     Icons.thumb_down,
//                                                     color: isLiked
//                                                         ? Colors.green.shade700
//                                                         : Colors.brown.shade200,
//                                                     size: 18,
//                                                   );
//                                                 },
//                                                 likeCount: comment.dislikes,
//                                                 onTap: (isLiked) async {
//                                                   _toggleCommentLike(post.id,
//                                                       comment.id, false);
//                                                   return !isLiked;
//                                                 },
//                                               ),
//                                               IconButton(
//                                                 onPressed: () {
//                                                   _deleteComment(
//                                                       post.id, comment.id);
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.delete,
//                                                   color: Colors.brown.shade200,
//                                                   size: 18,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         backgroundColor: Colors.green,
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }




// // import 'dart:ui';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import '../Models/PostAndCommentModel.dart';
// // import 'package:like_button/like_button.dart';
// // import 'package:intl/intl.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: HomeScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   List<Post> _posts = [];
// //   Map<String, TextEditingController> _commentControllers = {};

// //   void _addPost(String content) {
// //     setState(() {
// //       final newPost = Post(
// //         id: DateTime.now().toString(),
// //         content: content,
// //         creatorName: 'Salma',
// //         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
// //         likes: 0,
// //         dislikes: 0,
// //       );
// //       _posts.add(newPost);
// //       _commentControllers[newPost.id] = TextEditingController();
// //     });
// //   }

// //   void _addComment(String postId, String content) {
// //     final postIndex = _posts.indexWhere((post) => post.id == postId);
// //     if (postIndex != -1) {
// //       setState(() {
// //         _posts[postIndex].comments.add(Comment(
// //           id: DateTime.now().toString(),
// //           content: content,
// //           creatorName: 'Commenter Name', // Replace with actual commenter name
// //           creatorImageUrl: 'https://example.com/commenter_profile_picture.jpg', // Replace with actual image URL
// //           createdAt: DateTime.now(),
// //         ));
// //       });
// //       _commentControllers[postId]?.clear();
// //     }
// //   }

// //   void _toggleComments(String postId) {
// //     setState(() {
// //       final postIndex = _posts.indexWhere((post) => post.id == postId);
// //       if (postIndex != -1) {
// //         _posts[postIndex].showComments = !_posts[postIndex].showComments;
// //       }
// //     });
// //   }

// //   void _toggleCommentLike(String postId, String commentId, bool isLike) {
// //     setState(() {
// //       final postIndex = _posts.indexWhere((post) => post.id == postId);
// //       if (postIndex != -1) {
// //         final commentIndex = _posts[postIndex].comments.indexWhere((comment) => comment.id == commentId);
// //         if (commentIndex != -1) {
// //           if (isLike) {
// //             _posts[postIndex].comments[commentIndex].likes++;
// //           } else {
// //             _posts[postIndex].comments[commentIndex].dislikes++;
// //           }
// //         }
// //       }
// //     });
// //   }

// //   void _showPostDialog() {
// //     final TextEditingController _postController = TextEditingController();
// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text('Create Post'),
// //           content: TextField(
// //             controller: _postController,
// //             decoration: InputDecoration(hintText: 'What\'s on your mind?'),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //               child: Text('Cancel'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (_postController.text.isNotEmpty) {
// //                   _addPost(_postController.text);
// //                 }
// //                 Navigator.of(context).pop(); // Close the dialog
// //               },
// //               child: Text('Post'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _commentControllers.forEach((key, controller) {
// //       controller.dispose();
// //     });
// //     super.dispose();
// //   }

// //   String _formatTimestamp(DateTime timestamp) {
// //     return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(title: Text('Group')),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _posts.length,
// //               itemBuilder: (context, index) {
// //                 final post = _posts[index];
// //                 return Card(
// //                   shadowColor: Colors.black,
// //                   color: kprimaryColourWhite,
// //                   margin: EdgeInsets.all(8.0),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Row(
// //                           children: [
// //                             CircleAvatar(
// //                               backgroundImage: NetworkImage(post.creatorImageUrl),
// //                             ),
// //                             SizedBox(width: 10.0),
// //                             Text(post.creatorName,
// //                                 style: TextStyle(fontWeight: FontWeight.bold)),
// //                           ],
// //                         ),
// //                         SizedBox(height: 10.0),
// //                         Text(post.content, style: TextStyle(fontSize: 16.0)),
// //                         SizedBox(height: 10.0),
// //                         Row(
// //                           children: [
// //                             LikeButton(
// //                               circleColor: CircleColor(
// //                                   start: Color(0xff00ddff),
// //                                   end: Color(0xff0099cc)),
// //                               bubblesColor: BubblesColor(
// //                                 dotPrimaryColor: Color(0xff33b5e5),
// //                                 dotSecondaryColor: Color(0xff0099cc),
// //                               ),
// //                               likeBuilder: (bool isLiked) {
// //                                 return Icon(
// //                                   Icons.thumb_up,
// //                                   color: isLiked
// //                                       ? Colors.green.shade700
// //                                       : Colors.brown.shade200,
// //                                 );
// //                               },
// //                               likeCount: post.likes,
// //                             ),
// //                             Text(
// //                               ' Likes',
// //                               style: TextStyle(
// //                                 color: Colors.brown.shade200,
// //                               ),
// //                             ),
// //                             Spacer(flex: 1),
// //                             LikeButton(
// //                               circleColor: CircleColor(
// //                                   start: Color(0xff00ddff),
// //                                   end: Color(0xff0099cc)),
// //                               bubblesColor: BubblesColor(
// //                                 dotPrimaryColor: Color(0xff33b5e5),
// //                                 dotSecondaryColor: Color(0xff0099cc),
// //                               ),
// //                               likeBuilder: (bool isLiked) {
// //                                 return Icon(
// //                                   Icons.thumb_down,
// //                                   color: isLiked
// //                                       ? Colors.green.shade700
// //                                       : Colors.brown.shade200,
// //                                 );
// //                               },
// //                               likeCount: post.dislikes,
// //                             ),
// //                             Text(
// //                               ' Dislikes',
// //                               style: TextStyle(
// //                                 color: Colors.brown.shade200,
// //                               ),
// //                             ),
// //                             Spacer(flex: 1),
// //                             IconButton(
// //                               onPressed: () {
// //                                 _toggleComments(post.id);
// //                               },
// //                               icon: Icon(
// //                                 Icons.comment,
// //                                 color: Colors.brown.shade200,
// //                               ),
// //                             ),
// //                             Text(
// //                               'Comments',
// //                               style: TextStyle(
// //                                 color: Colors.brown.shade200,
// //                               ),
// //                             ),
// //                             Spacer(flex: 1),
// //                             LikeButton(
// //                               likeBuilder: (bool isLiked) {
// //                                 return Icon(
// //                                   Icons.favorite,
// //                                   color: isLiked
// //                                       ? Colors.red.shade900
// //                                       : Colors.brown.shade200,
// //                                 );
// //                               },
// //                             ),
// //                           ],
// //                         ),
// //                         SizedBox(height: 10.0),
// //                         Divider(),
// //                         if (post.showComments) ...[
// //                           Row(
// //                             children: [
// //                               Expanded(
// //                                 child: TextFormField(
// //                                   controller: _commentControllers[post.id],
// //                                   decoration: InputDecoration(hintText: 'Add a comment'),
// //                                   onFieldSubmitted: (text) {
// //                                     if (text.isNotEmpty) {
// //                                       _addComment(post.id, text);
// //                                       _commentControllers[post.id]?.clear();
// //                                     }
// //                                   },
// //                                 ),
// //                               ),
// //                               IconButton(
// //                                 icon: Icon(Icons.add),
// //                                 onPressed: () {
// //                                   if (_commentControllers[post.id]?.text.isNotEmpty ?? false) {
// //                                     _addComment(post.id, _commentControllers[post.id]!.text);
// //                                     _commentControllers[post.id]?.clear();
// //                                   }
// //                                 },
// //                               ),
// //                             ],
// //                           ),
// //                           ListView.builder(
// //                             shrinkWrap: true,
// //                             physics: NeverScrollableScrollPhysics(),
// //                             itemCount: post.comments.length,
// //                             itemBuilder: (context, index) {
// //                               final comment = post.comments[index];
// //                               return ListTile(
// //                                 leading: CircleAvatar(
// //                                   backgroundImage: NetworkImage(comment.creatorImageUrl),
// //                                 ),
// //                                 title: Text(comment.creatorName),
// //                                 subtitle: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(comment.content),
// //                                     Text(_formatTimestamp(comment.createdAt)),
// //                                     Row(
// //                                       children: [
// //                                         LikeButton(
// //                                           circleColor: CircleColor(
// //                                               start: Color(0xff00ddff),
// //                                               end: Color(0xff0099cc)),
// //                                           bubblesColor: BubblesColor(
// //                                             dotPrimaryColor: Color(0xff33b5e5),
// //                                             dotSecondaryColor: Color(0xff0099cc),
// //                                           ),
// //                                           likeBuilder: (bool isLiked) {
// //                                             return Icon(
// //                                               Icons.thumb_up,
// //                                               color: isLiked
// //                                                   ? Colors.green.shade700
// //                                                   : Colors.brown.shade200,
// //                                             );
// //                                           },
// //                                           likeCount: comment.likes,
// //                                           onTap: (isLiked) async {
// //                                             _toggleCommentLike(post.id, comment.id, true);
// //                                             return !isLiked;
// //                                           },
// //                                         ),
// //                                         SizedBox(width: 8.0),
// //                                         LikeButton(
// //                                           circleColor: CircleColor(
// //                                               start: Color(0xff00ddff),
// //                                               end: Color(0xff0099cc)),
// //                                           bubblesColor: BubblesColor(
// //                                             dotPrimaryColor: Color(0xff33b5e5),
// //                                             dotSecondaryColor: Color(0xff0099cc),
// //                                           ),
// //                                           likeBuilder: (bool isLiked) {
// //                                             return Icon(
// //                                               Icons.thumb_down,
// //                                               color: isLiked
// //                                                   ? Colors.green.shade700
// //                                                   : Colors.brown.shade200,
// //                                             );
// //                                           },
// //                                           likeCount: comment.dislikes,
// //                                           onTap: (isLiked) async {
// //                                             _toggleCommentLike(post.id, comment.id, false);
// //                                             return !isLiked;
// //                                           },
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showPostDialog,
// //         backgroundColor: Colors.green,
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }


// // // import 'dart:ui';

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/widgets.dart';
// // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // import '../Models/PostAndCommentModel.dart';
// // // import 'package:like_button/like_button.dart';
// // // import 'package:intl/intl.dart';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: HomeScreen(),
// // //     );
// // //   }
// // // }

// // // class HomeScreen extends StatefulWidget {
// // //   @override
// // //   _HomeScreenState createState() => _HomeScreenState();
// // // }

// // // class _HomeScreenState extends State<HomeScreen> {
// // //   List<Post> _posts = [];
// // //   Map<String, TextEditingController> _commentControllers = {};

// // //   void _addPost(String content) {
// // //     setState(() {
// // //       final newPost = Post(
// // //         id: DateTime.now().toString(),
// // //         content: content,
// // //         creatorName: 'Salma',
// // //         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
// // //         likes: 0,
// // //         dislikes: 0,
// // //       );
// // //       _posts.add(newPost);
// // //       _commentControllers[newPost.id] = TextEditingController();
// // //     });
// // //   }

// // //   void _addComment(String postId, String content) {
// // //     final postIndex = _posts.indexWhere((post) => post.id == postId);
// // //     if (postIndex != -1) {
// // //       setState(() {
// // //         _posts[postIndex].comments.add(Comment(
// // //           id: DateTime.now().toString(),
// // //           content: content,
// // //           creatorName: 'Commenter Name', // Replace with actual commenter name
// // //           creatorImageUrl: 'https://example.com/commenter_profile_picture.jpg', // Replace with actual image URL
// // //           createdAt: DateTime.now(),
// // //         ));
// // //       });
// // //       _commentControllers[postId]?.clear();
// // //     }
// // //   }

// // //   void _toggleComments(String postId) {
// // //     setState(() {
// // //       final postIndex = _posts.indexWhere((post) => post.id == postId);
// // //       if (postIndex != -1) {
// // //         _posts[postIndex].showComments = !_posts[postIndex].showComments;
// // //       }
// // //     });
// // //   }

// // //   void _showPostDialog() {
// // //     final TextEditingController _postController = TextEditingController();
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) {
// // //         return AlertDialog(
// // //           title: Text('Create Post'),
// // //           content: TextField(
// // //             controller: _postController,
// // //             decoration: InputDecoration(hintText: 'What\'s on your mind?'),
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.of(context).pop(); // Close the dialog
// // //               },
// // //               child: Text('Cancel'),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 if (_postController.text.isNotEmpty) {
// // //                   _addPost(_postController.text);
// // //                 }
// // //                 Navigator.of(context).pop(); // Close the dialog
// // //               },
// // //               child: Text('Post'),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _commentControllers.forEach((key, controller) {
// // //       controller.dispose();
// // //     });
// // //     super.dispose();
// // //   }

// // //   String _formatTimestamp(DateTime timestamp) {
// // //     return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(title: Text('Group')),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: _posts.length,
// // //               itemBuilder: (context, index) {
// // //                 final post = _posts[index];
// // //                 return Card(
// // //                   shadowColor: Colors.black,
// // //                   color: kprimaryColourWhite,
// // //                   margin: EdgeInsets.all(8.0),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(8.0),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Row(
// // //                           children: [
// // //                             CircleAvatar(
// // //                               backgroundImage: NetworkImage(post.creatorImageUrl),
// // //                             ),
// // //                             SizedBox(width: 10.0),
// // //                             Text(post.creatorName,
// // //                                 style: TextStyle(fontWeight: FontWeight.bold)),
// // //                           ],
// // //                         ),
// // //                         SizedBox(height: 10.0),
// // //                         Text(post.content, style: TextStyle(fontSize: 16.0)),
// // //                         SizedBox(height: 10.0),
// // //                         Row(
// // //                           children: [
// // //                             LikeButton(
// // //                               circleColor: CircleColor(
// // //                                   start: Color(0xff00ddff),
// // //                                   end: Color(0xff0099cc)),
// // //                               bubblesColor: BubblesColor(
// // //                                 dotPrimaryColor: Color(0xff33b5e5),
// // //                                 dotSecondaryColor: Color(0xff0099cc),
// // //                               ),
// // //                               likeBuilder: (bool isLiked) {
// // //                                 return Icon(
// // //                                   Icons.thumb_up,
// // //                                   color: isLiked
// // //                                       ? Colors.green.shade700
// // //                                       : Colors.brown.shade200,
// // //                                 );
// // //                               },
// // //                               likeCount: post.likes,
// // //                             ),
// // //                             Text(
// // //                               ' Likes',
// // //                               style: TextStyle(
// // //                                 color: Colors.brown.shade200,
// // //                               ),
// // //                             ),
// // //                             Spacer(flex: 1),
// // //                             LikeButton(
// // //                               circleColor: CircleColor(
// // //                                   start: Color(0xff00ddff),
// // //                                   end: Color(0xff0099cc)),
// // //                               bubblesColor: BubblesColor(
// // //                                 dotPrimaryColor: Color(0xff33b5e5),
// // //                                 dotSecondaryColor: Color(0xff0099cc),
// // //                               ),
// // //                               likeBuilder: (bool isLiked) {
// // //                                 return Icon(
// // //                                   Icons.thumb_down,
// // //                                   color: isLiked
// // //                                       ? Colors.green.shade700
// // //                                       : Colors.brown.shade200,
// // //                                 );
// // //                               },
// // //                               likeCount: post.dislikes,
// // //                             ),
// // //                             Text(
// // //                               ' Dislikes',
// // //                               style: TextStyle(
// // //                                 color: Colors.brown.shade200,
// // //                               ),
// // //                             ),
// // //                             Spacer(flex: 1),
// // //                             IconButton(
// // //                               onPressed: () {
// // //                                 _toggleComments(post.id);
// // //                               },
// // //                               icon: Icon(
// // //                                 Icons.comment,
// // //                                 color: Colors.brown.shade200,
// // //                               ),
// // //                             ),
// // //                             Text(
// // //                               'Comments',
// // //                               style: TextStyle(
// // //                                 color: Colors.brown.shade200,
// // //                               ),
// // //                             ),
// // //                             Spacer(flex: 1),
// // //                             LikeButton(
// // //                               likeBuilder: (bool isLiked) {
// // //                                 return Icon(
// // //                                   Icons.favorite,
// // //                                   color: isLiked
// // //                                       ? Colors.red.shade900
// // //                                       : Colors.brown.shade200,
// // //                                 );
// // //                               },
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         SizedBox(height: 10.0),
// // //                         Divider(),
// // //                         if (post.showComments) ...[
// // //                           Row(
// // //                             children: [
// // //                               Expanded(
// // //                                 child: TextFormField(
// // //                                   controller: _commentControllers[post.id],
// // //                                   decoration: InputDecoration(hintText: 'Add a comment'),
// // //                                   onFieldSubmitted: (text) {
// // //                                     if (text.isNotEmpty) {
// // //                                       _addComment(post.id, text);
// // //                                       _commentControllers[post.id]?.clear();
// // //                                     }
// // //                                   },
// // //                                 ),
// // //                               ),
// // //                               IconButton(
// // //                                 icon: Icon(Icons.add),
// // //                                 onPressed: () {
// // //                                   if (_commentControllers[post.id]?.text.isNotEmpty ?? false) {
// // //                                     _addComment(post.id, _commentControllers[post.id]!.text);
// // //                                     _commentControllers[post.id]?.clear();
// // //                                   }
// // //                                 },
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           ListView.builder(
// // //                             shrinkWrap: true,
// // //                             physics: NeverScrollableScrollPhysics(),
// // //                             itemCount: post.comments.length,
// // //                             itemBuilder: (context, index) {
// // //                               final comment = post.comments[index];
// // //                               return ListTile(
// // //                                 leading: CircleAvatar(
// // //                                   backgroundImage: NetworkImage(comment.creatorImageUrl),
// // //                                 ),
// // //                                 title: Text(comment.creatorName),
// // //                                 subtitle: Column(
// // //                                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                                   children: [
// // //                                     Text(comment.content),
// // //                                     Text(_formatTimestamp(comment.createdAt),
// // //                                         style: TextStyle(fontSize: 12, color: Colors.grey)),
// // //                                   ],
// // //                                 ),
// // //                               );
// // //                             },
// // //                           ),
// // //                         ],
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _showPostDialog,
// // //         backgroundColor: Colors.green,
// // //         child: Icon(Icons.add),
// // //       ),
// // //     );
// // //   }
// // // }










// // // // workingggggggggggggggggggggg
// // // // import 'dart:ui';

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/widgets.dart';
// // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // import '../Models/PostAndCommentModel.dart';
// // // // import 'package:like_button/like_button.dart';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       debugShowCheckedModeBanner: false,
// // // //       home: HomeScreen(),
// // // //     );
// // // //   }
// // // // }

// // // // class HomeScreen extends StatefulWidget {
// // // //   @override
// // // //   _HomeScreenState createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   List<Post> _posts = [];
// // // //   Map<String, TextEditingController> _commentControllers = {};

// // // //   void _addPost(String content) {
// // // //     setState(() {
// // // //       final newPost = Post(
// // // //         id: DateTime.now().toString(),
// // // //         content: content,
// // // //         creatorName: 'Salma',
// // // //         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
// // // //         likes: 0,
// // // //         dislikes: 0,
// // // //       );
// // // //       _posts.add(newPost);
// // // //       _commentControllers[newPost.id] = TextEditingController();
// // // //     });
// // // //   }

// // // //   void _addComment(String postId, String content) {
// // // //     final postIndex = _posts.indexWhere((post) => post.id == postId);
// // // //     if (postIndex != -1) {
// // // //       setState(() {
// // // //         _posts[postIndex].comments.add(Comment(id: DateTime.now().toString(), content: content));
// // // //       });
// // // //       _commentControllers[postId]?.clear();
// // // //     }
// // // //   }

// // // //   void _toggleComments(String postId) {
// // // //     setState(() {
// // // //       final postIndex = _posts.indexWhere((post) => post.id == postId);
// // // //       if (postIndex != -1) {
// // // //         _posts[postIndex].showComments = !_posts[postIndex].showComments;
// // // //       }
// // // //     });
// // // //   }

// // // //   void _showPostDialog() {
// // // //     final TextEditingController _postController = TextEditingController();
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) {
// // // //         return AlertDialog(
// // // //           title: Text('Create Post'),
// // // //           content: TextField(
// // // //             controller: _postController,
// // // //             decoration: InputDecoration(hintText: 'What\'s on your mind?'),
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () {
// // // //                 Navigator.of(context).pop(); // Close the dialog
// // // //               },
// // // //               child: Text('Cancel'),
// // // //             ),
// // // //             ElevatedButton(
// // // //               onPressed: () {
// // // //                 if (_postController.text.isNotEmpty) {
// // // //                   _addPost(_postController.text);
// // // //                 }
// // // //                 Navigator.of(context).pop(); // Close the dialog
// // // //               },
// // // //               child: Text('Post'),
// // // //             ),
// // // //           ],
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _commentControllers.forEach((key, controller) {
// // // //       controller.dispose();
// // // //     });
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(title: Text('Group')),
// // // //       body: Column(
// // // //         children: [
// // // //           Expanded(
// // // //             child: ListView.builder(
// // // //               itemCount: _posts.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final post = _posts[index];
// // // //                 return Padding(
// // // //                   padding: const EdgeInsets.all(8.0),
// // // //                   child: Card(
// // // //                     shadowColor: Colors.black,
// // // //                     color: kprimaryColourWhite,
// // // //                     margin: EdgeInsets.all(8.0),
// // // //                     child: Padding(
// // // //                       padding: const EdgeInsets.all(8.0),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Row(
// // // //                             children: [
// // // //                               CircleAvatar(
// // // //                                 backgroundImage: NetworkImage(post.creatorImageUrl),
// // // //                               ),
// // // //                               SizedBox(width: 10.0),
// // // //                               Text(post.creatorName,
// // // //                                   style: TextStyle(fontWeight: FontWeight.bold)),
// // // //                             ],
// // // //                           ),
// // // //                           SizedBox(height: 10.0),
// // // //                           Text(post.content, style: TextStyle(fontSize: 16.0)),
// // // //                           SizedBox(height: 10.0),
// // // //                           Row(
// // // //                             children: [
// // // //                               LikeButton(
// // // //                                 circleColor: CircleColor(
// // // //                                     start: Color(0xff00ddff),
// // // //                                     end: Color(0xff0099cc)),
// // // //                                 bubblesColor: BubblesColor(
// // // //                                   dotPrimaryColor: Color(0xff33b5e5),
// // // //                                   dotSecondaryColor: Color(0xff0099cc),
// // // //                                 ),
// // // //                                 likeBuilder: (bool isLiked) {
// // // //                                   return Icon(
// // // //                                     Icons.thumb_up,
// // // //                                     color: isLiked
// // // //                                         ? Colors.green.shade700
// // // //                                         : Colors.brown.shade200,
// // // //                                   );
// // // //                                 },
// // // //                                 likeCount: post.likes,
// // // //                               ),
// // // //                               Text(
// // // //                                 ' Likes',
// // // //                                 style: TextStyle(
// // // //                                   color: Colors.brown.shade200,
// // // //                                 ),
// // // //                               ),
// // // //                               Spacer(flex: 1),
// // // //                               LikeButton(
// // // //                                 circleColor: CircleColor(
// // // //                                     start: Color(0xff00ddff),
// // // //                                     end: Color(0xff0099cc)),
// // // //                                 bubblesColor: BubblesColor(
// // // //                                   dotPrimaryColor: Color(0xff33b5e5),
// // // //                                   dotSecondaryColor: Color(0xff0099cc),
// // // //                                 ),
// // // //                                 likeBuilder: (bool isLiked) {
// // // //                                   return Icon(
// // // //                                     Icons.thumb_down,
// // // //                                     color: isLiked
// // // //                                         ? Colors.green.shade700
// // // //                                         : Colors.brown.shade200,
// // // //                                   );
// // // //                                 },
// // // //                                 likeCount: post.dislikes,
// // // //                               ),
// // // //                               Text(
// // // //                                 ' Dislikes',
// // // //                                 style: TextStyle(
// // // //                                   color: Colors.brown.shade200,
// // // //                                 ),
// // // //                               ),
// // // //                               Spacer(flex: 1),
// // // //                               IconButton(
// // // //                                 onPressed: () {
// // // //                                   _toggleComments(post.id);
// // // //                                 },
// // // //                                 icon: Icon(
// // // //                                   Icons.comment,
// // // //                                   color: Colors.brown.shade200,
// // // //                                 ),
// // // //                               ),
// // // //                               Text(
// // // //                                 'Comments',
// // // //                                 style: TextStyle(
// // // //                                   color: Colors.brown.shade200,
// // // //                                 ),
// // // //                               ),
// // // //                               Spacer(flex: 1),
// // // //                               LikeButton(
// // // //                                 likeBuilder: (bool isLiked) {
// // // //                                   return Icon(
// // // //                                     Icons.favorite,
// // // //                                     color: isLiked
// // // //                                         ? Colors.red.shade900
// // // //                                         : Colors.brown.shade200,
// // // //                                   );
// // // //                                 },
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                           SizedBox(height: 10.0),
                          
// // // //                           if (post.showComments) ...[
// // // //                             Divider(),
// // // //                             Row(
// // // //                               children: [
// // // //                                 Expanded(
// // // //                                   child: TextFormField(
// // // //                                     controller: _commentControllers[post.id],
// // // //                                     decoration: InputDecoration(hintText: 'Add a comment'),
// // // //                                     onFieldSubmitted: (text) {
// // // //                                       if (text.isNotEmpty) {
// // // //                                         _addComment(post.id, text);
// // // //                                         _commentControllers[post.id]?.clear();
// // // //                                       }
// // // //                                     },
// // // //                                   ),
// // // //                                 ),
// // // //                                 IconButton(
// // // //                                   icon: Icon(Icons.send,color:Colors.brown.shade200 ,),
// // // //                                   onPressed: () {
// // // //                                     if (_commentControllers[post.id]?.text.isNotEmpty ?? false) {
// // // //                                       _addComment(post.id, _commentControllers[post.id]!.text);
// // // //                                       _commentControllers[post.id]?.clear();
// // // //                                     }
// // // //                                   },
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                             ListView.builder(
// // // //                               shrinkWrap: true,
// // // //                               physics: NeverScrollableScrollPhysics(),
// // // //                               itemCount: post.comments.length,
// // // //                               itemBuilder: (context, index) {
// // // //                                 final comment = post.comments[index];
                                
// // // //                                 return ListTile(
// // // //                                   title: Text(comment.content),
// // // //                                 );
// // // //                               },
// // // //                             ),
// // // //                           ],
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: _showPostDialog,
// // // //         backgroundColor: Colors.green,
// // // //         child: Icon(Icons.add),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // import 'dart:ui';

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter/widgets.dart';
// // // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // // import '../Models/PostAndCommentModel.dart';
// // // // // import 'package:like_button/like_button.dart';

// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }

// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       debugShowCheckedModeBanner: false,
// // // // //       home: HomeScreen(),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class HomeScreen extends StatefulWidget {
// // // // //   @override
// // // // //   _HomeScreenState createState() => _HomeScreenState();
// // // // // }

// // // // // class _HomeScreenState extends State<HomeScreen> {
// // // // //   List<Post> _posts = [];
// // // // //   bool isLiked=false;
// // // // //   final TextEditingController _commentController = TextEditingController();

// // // // //   void _addPost(String content) {
// // // // //     setState(() {
// // // // //       _posts.add(Post(
// // // // //         id: DateTime.now().toString(),
// // // // //         content: content,
// // // // //         creatorName: 'Salma',
// // // // //         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
// // // // //         likes: 0, dislikes: 0,
// // // // //       ));
// // // // //     });
// // // // //   }

// // // // //   void _addComment(String postId, String content) {
// // // // //     final postIndex = _posts.indexWhere((post) => post.id == postId);
// // // // //     if (postIndex != -1) {
// // // // //       setState(() {
// // // // //         _posts[postIndex].comments.add(Comment(id: DateTime.now().toString(), content: content));
// // // // //       });
// // // // //       _commentController.clear();
// // // // //     }
// // // // //   }

// // // // //   void _toggleComments(String postId) {
// // // // //     setState(() {
// // // // //       final postIndex = _posts.indexWhere((post) => post.id == postId);
// // // // //       if (postIndex != -1) {
// // // // //         _posts[postIndex].showComments = !_posts[postIndex].showComments;
// // // // //       }
// // // // //     });
// // // // //   }

// // // // //   void _showPostDialog() {
// // // // //     final TextEditingController _postController = TextEditingController();
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) {
// // // // //         return AlertDialog(
// // // // //           title: Text('Create Post'),
// // // // //           content: TextField(
// // // // //             controller: _postController,
// // // // //             decoration: InputDecoration(hintText: 'What\'s on your mind?'),
// // // // //           ),
// // // // //           actions: [
// // // // //             TextButton(
// // // // //               onPressed: () {
// // // // //                 Navigator.of(context).pop(); // Close the dialog
// // // // //               },
// // // // //               child: Text('Cancel'),
// // // // //             ),
// // // // //             ElevatedButton(
// // // // //               onPressed: () {
// // // // //                 if (_postController.text.isNotEmpty) {
// // // // //                   _addPost(_postController.text);
// // // // //                 }
// // // // //                 Navigator.of(context).pop(); // Close the dialog
// // // // //               },
// // // // //               child: Text('Post'),
// // // // //             ),
// // // // //           ],
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       appBar: AppBar(title: Text('Group')),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           Expanded(
// // // // //             child: ListView.builder(
// // // // //               itemCount: _posts.length,
// // // // //               itemBuilder: (context, index) {
// // // // //                 final post = _posts[index];
// // // // //                 return Padding(
// // // // //                   padding: const EdgeInsets.all(8.0),
// // // // //                   child: Card(
// // // // //                     shadowColor: Colors.black,
// // // // //                     color: kprimaryColourWhite,
// // // // //                     margin: EdgeInsets.all(8.0),
// // // // //                     child: Padding(
// // // // //                       padding: const EdgeInsets.all(8.0),
// // // // //                       child: Column(
// // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                         children: [
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               CircleAvatar(
// // // // //                                 backgroundImage: NetworkImage(post.creatorImageUrl),
// // // // //                               ),
// // // // //                               SizedBox(width: 10.0),
// // // // //                               Text(post.creatorName,
// // // // //                                   style: TextStyle(fontWeight: FontWeight.bold)),
// // // // //                             ],
// // // // //                           ),
// // // // //                           SizedBox(height: 10.0),
// // // // //                           Text(post.content, style: TextStyle(fontSize: 16.0)),
// // // // //                           SizedBox(height: 10.0),
// // // // //                           Row(
// // // // //                             children: [
// // // // //                               LikeButton(
// // // // //                                 circleColor: CircleColor(
// // // // //                                     start: Color(0xff00ddff),
// // // // //                                     end: Color(0xff0099cc)),
// // // // //                                 bubblesColor: BubblesColor(
// // // // //                                   dotPrimaryColor: Color(0xff33b5e5),
// // // // //                                   dotSecondaryColor: Color(0xff0099cc),
// // // // //                                 ),
// // // // //                                 likeBuilder: (bool isLiked) {
// // // // //                                   return Icon(
// // // // //                                     Icons.thumb_up,
// // // // //                                     color: isLiked
// // // // //                                         ? Colors.green.shade700
// // // // //                                         : Colors.brown.shade200,
// // // // //                                   );
// // // // //                                 },
// // // // //                                 likeCount: post.likes,
// // // // //                               ),
// // // // //                               Text(
// // // // //                                 ' Likes',
// // // // //                                 style: TextStyle(
// // // // //                                   color: Colors.brown.shade200,
// // // // //                                 ),
// // // // //                               ),
// // // // //                               Spacer(flex: 1),
// // // // //                               LikeButton(
// // // // //                                 circleColor: CircleColor(
// // // // //                                     start: Color(0xff00ddff),
// // // // //                                     end: Color(0xff0099cc)),
// // // // //                                 bubblesColor: BubblesColor(
// // // // //                                   dotPrimaryColor: Color(0xff33b5e5),
// // // // //                                   dotSecondaryColor: Color(0xff0099cc),
// // // // //                                 ),
// // // // //                                 likeBuilder: (bool isLiked) {
// // // // //                                   return Icon(
// // // // //                                     Icons.thumb_down,
// // // // //                                     color: isLiked
// // // // //                                         ? Colors.green.shade700
// // // // //                                         : Colors.brown.shade200,
// // // // //                                   );
// // // // //                                 },
// // // // //                                 likeCount: post.dislikes,
// // // // //                               ),
// // // // //                               Text(
// // // // //                                 ' Dislikes',
// // // // //                                 style: TextStyle(
// // // // //                                   color: Colors.brown.shade200,
// // // // //                                 ),
// // // // //                               ),
// // // // //                               Spacer(flex: 1),
// // // // //                               IconButton(
// // // // //                                 onPressed: () {
// // // // //                                   _toggleComments(post.id);
// // // // //                                 },
// // // // //                                 icon: Icon(
// // // // //                                   Icons.comment,
// // // // //                                   color: Colors.brown.shade200,
// // // // //                                 ),
// // // // //                               ),
// // // // //                               Text(
// // // // //                                 'Comments',
// // // // //                                 style: TextStyle(
// // // // //                                   color: Colors.brown.shade200,
// // // // //                                 ),
// // // // //                               ),
// // // // //                               Spacer(flex: 1),
// // // // //                               LikeButton(
// // // // //                                 likeBuilder: (bool isLiked) {
// // // // //                                   return Icon(
// // // // //                                     Icons.favorite,
// // // // //                                     color: isLiked
// // // // //                                         ? Colors.red.shade900
// // // // //                                         : Colors.brown.shade200,
// // // // //                                   );
// // // // //                                 },
// // // // //                               ),
// // // // //                             ],
// // // // //                           ),
// // // // //                           SizedBox(height: 10.0),
// // // // //                           if (post.showComments) ...[
// // // // //                             Divider(),
// // // // //                             Row(
// // // // //                               children: [
// // // // //                                 Expanded(
// // // // //                                   child: TextFormField(
// // // // //                                   controller: _commentController,
// // // // //                                   decoration: InputDecoration(hintText: 'Add a comment'),
// // // // //                                   onFieldSubmitted: (text) {
// // // // //                                     if (text.isNotEmpty) {
// // // // //                                       _addComment(post.id, text);
// // // // //                                       _commentController.clear();
// // // // //                                     }
// // // // //                                   },
// // // // //                                 ),
// // // // //                                 ),
// // // // //                                 IconButton(
// // // // //                                   icon: Icon(Icons.send,color: Colors.brown.shade200,),
// // // // //                                   onPressed: () {
// // // // //                                     if (_commentController.text.isNotEmpty) {
// // // // //                                       _addComment(post.id, _commentController.text);
// // // // //                                       _commentController.clear();
// // // // //                                     }
// // // // //                                   },
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                             ListView.builder(
// // // // //                               shrinkWrap: true,
// // // // //                               physics: NeverScrollableScrollPhysics(),
// // // // //                               itemCount: post.comments.length,
// // // // //                               itemBuilder: (context, index) {
// // // // //                                 final comment = post.comments[index];
// // // // //                                 return ListTile(
// // // // //                                   title: Text(comment.content),
// // // // //                                 );
// // // // //                               },
// // // // //                             ),
// // // // //                           ],
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 );
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       floatingActionButton: FloatingActionButton(
// // // // //         onPressed: _showPostDialog,
// // // // //         backgroundColor: Colors.green,
// // // // //         child: Icon(Icons.add),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // // import 'dart:ui';

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter/widgets.dart';
// // // // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // // // import '../Models/PostAndCommentModel.dart';
// // // // // // import 'package:like_button/like_button.dart';

// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }

// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       debugShowCheckedModeBanner: false,
// // // // // //       home: HomeScreen(),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class HomeScreen extends StatefulWidget {
// // // // // //   @override
// // // // // //   _HomeScreenState createState() => _HomeScreenState();
// // // // // // }

// // // // // // class _HomeScreenState extends State<HomeScreen> {
// // // // // //   List<Post> _posts = [];
// // // // // //   bool isLiked=false;
// // // // // //   final TextEditingController _commentController = TextEditingController();

// // // // // //   void _addPost(String content) {
// // // // // //     setState(() {
// // // // // //       _posts.add(Post(
// // // // // //         id: DateTime.now().toString(),
// // // // // //         content: content,
// // // // // //         creatorName: 'Salma',
// // // // // //         creatorImageUrl: 'https://example.com/salma_profile_picture.jpg',
// // // // // //         likes: 0, dislikes: 0, // Replace with actual image URL
// // // // // //       ));
// // // // // //     });
// // // // // //   }

// // // // // //   // void _addComment(String postId, String content) {
// // // // // //   //   setState(() {
// // // // // //   //     final post = _posts.firstWhere((post) => post.id == postId);
// // // // // //   //     post.comments
// // // // // //   //         .add(Comment(id: DateTime.now().toString(), content: content));
// // // // // //   //   });
// // // // // //   //   _commentController.clear();
// // // // // //   // }
// // // // // // void _addComment(String postId, String content) {
// // // // // //   final postIndex = _posts.indexWhere((post) => post.id == postId);
// // // // // //   if (postIndex != -1) {
// // // // // //     setState(() {
// // // // // //       _posts[postIndex].comments.add(Comment(id: DateTime.now().toString(), content: content));
// // // // // //     });
// // // // // //     _commentController.clear();
// // // // // //   }
// // // // // // }

// // // // // //   void _showPostDialog() {
// // // // // //     final TextEditingController _postController = TextEditingController();
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (context) {
// // // // // //         return AlertDialog(
// // // // // //           title: Text('Create Post'),
// // // // // //           content: TextField(
// // // // // //             controller: _postController,
// // // // // //             decoration: InputDecoration(hintText: 'What\'s on your mind?'),
// // // // // //           ),
// // // // // //           actions: [
// // // // // //             TextButton(
// // // // // //               onPressed: () {
// // // // // //                 Navigator.of(context).pop(); // Close the dialog
// // // // // //               },
// // // // // //               child: Text('Cancel'),
// // // // // //             ),
// // // // // //             ElevatedButton(
// // // // // //               onPressed: () {
// // // // // //                 if (_postController.text.isNotEmpty) {
// // // // // //                   _addPost(_postController.text);
// // // // // //                 }
// // // // // //                 Navigator.of(context).pop(); // Close the dialog
// // // // // //               },
// // // // // //               child: Text('Post'),
// // // // // //             ),
// // // // // //           ],
// // // // // //         );
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: Colors.white,
// // // // // //       appBar: AppBar(title: Text('Group')),
// // // // // //       body: Column(
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             child: ListView.builder(
// // // // // //               itemCount: _posts.length,
// // // // // //               itemBuilder: (context, index) {
// // // // // //                 final post = _posts[index];
// // // // // //                 return Card(
// // // // // //                   // surfaceTintColor:Colors.black,
// // // // // //                   shadowColor: Colors.black,
// // // // // //                   // shadowColor:kpr
// // // // // //                   color: kprimaryColourWhite,
// // // // // //                   margin: EdgeInsets.all(8.0),
// // // // // //                   child: Padding(
// // // // // //                     padding: const EdgeInsets.all(8.0),
// // // // // //                     child: Column(
// // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                       children: [
// // // // // //                         Row(
// // // // // //                           children: [
// // // // // //                             CircleAvatar(
// // // // // //                               backgroundImage:
// // // // // //                                   NetworkImage(post.creatorImageUrl),
// // // // // //                             ),
// // // // // //                             SizedBox(width: 10.0),
// // // // // //                             Text(post.creatorName,
// // // // // //                                 style: TextStyle(fontWeight: FontWeight.bold)),
// // // // // //                           ],
// // // // // //                         ),
// // // // // //                         SizedBox(height: 10.0),
// // // // // //                         Text(post.content, style: TextStyle(fontSize: 16.0)),
// // // // // //                         SizedBox(height: 10.0),
// // // // // //                         Row(
// // // // // //                           children: [
// // // // // //                             LikeButton(
// // // // // //                               // size: buttonSize,
// // // // // //                               circleColor: CircleColor(
// // // // // //                                   start: Color(0xff00ddff),
// // // // // //                                   end: Color(0xff0099cc)),
// // // // // //                               bubblesColor: BubblesColor(
// // // // // //                                 dotPrimaryColor: Color(0xff33b5e5),
// // // // // //                                 dotSecondaryColor: Color(0xff0099cc),
// // // // // //                               ),
// // // // // //                               likeBuilder: (bool isLiked) {
// // // // // //                                 return Icon(
// // // // // //                                   Icons.thumb_up,
// // // // // //                                   color: isLiked
// // // // // //                                       ? Colors.green.shade700
// // // // // //                                       : Colors.brown.shade200,
// // // // // //                                   // size: buttonSize,
// // // // // //                                 );
// // // // // //                               },
// // // // // //                               likeCount: post.likes,
// // // // // //                             ),
// // // // // //                             Text(
// // // // // //                               ' Likes',
// // // // // //                               style: TextStyle(
// // // // // //                                 color: Colors.brown.shade200,
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                             Spacer(
// // // // // //                               flex: 1,
// // // // // //                             ),
// // // // // //                             LikeButton(
// // // // // //                               // size: buttonSize,
// // // // // //                               circleColor: CircleColor(
// // // // // //                                   start: Color(0xff00ddff),
// // // // // //                                   end: Color(0xff0099cc)),
// // // // // //                               bubblesColor: BubblesColor(
// // // // // //                                 dotPrimaryColor: Color(0xff33b5e5),
// // // // // //                                 dotSecondaryColor: Color(0xff0099cc),
// // // // // //                               ),
// // // // // //                               likeBuilder: (bool isLiked) {
// // // // // //                                 return Icon(
// // // // // //                                   Icons.thumb_down,
// // // // // //                                   color: isLiked
// // // // // //                                       ? Colors.green.shade700
// // // // // //                                       : Colors.brown.shade200,
// // // // // //                                   // size: buttonSize,
// // // // // //                                 );
// // // // // //                               },
// // // // // //                               likeCount: post.dislikes,
// // // // // //                             ),
// // // // // //                             Text(
// // // // // //                               ' disLikes',
// // // // // //                               style: TextStyle(
// // // // // //                                 color: Colors.brown.shade200,
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                             Spacer(
// // // // // //                               flex: 1,
// // // // // //                             ),
// // // // // //                             IconButton(
// // // // // //                                 onPressed: () {},
// // // // // //                                 icon: Icon(
// // // // // //                                   Icons.comment,
// // // // // //                                   color: Colors.brown.shade200,
// // // // // //                                 )),
// // // // // //                             Text(
// // // // // //                               'Comments',
// // // // // //                               style: TextStyle(
// // // // // //                                 color: Colors.brown.shade200,
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                             Spacer(
// // // // // //                               flex: 1,
// // // // // //                             ),
// // // // // //                             LikeButton(
// // // // // //                               likeBuilder: (bool isLiked) {
// // // // // //                                 return Icon(
// // // // // //                                   Icons.favorite,
// // // // // //                                   color: isLiked
// // // // // //                                       ? Colors.red.shade900
// // // // // //                                       : Colors.brown.shade200,
// // // // // //                                   // size: buttonSize,
// // // // // //                                 );
// // // // // //                               },
// // // // // //                             ),
// // // // // //                           ],
// // // // // //                         ),
// // // // // //                         SizedBox(height: 10.0),
// // // // // //                         // IconButton(onPressed: (){}, icon: Icons.fingerprint),
// // // // // //                         Divider(),
// // // // // //                         Row(
// // // // // //                           children: [
// // // // // //                             Expanded(
// // // // // //                               child: TextField(
// // // // // //                                 controller: _commentController,
// // // // // //                                 decoration:
// // // // // //                                     InputDecoration(hintText: 'Add a comment'),
// // // // // //                                 onSubmitted: (text) {
// // // // // //                                   if (text.isNotEmpty) {
// // // // // //                                     _addComment(post.id, text);
// // // // // //                                     _commentController.clear();
// // // // // //                                   }
// // // // // //                                 },
// // // // // //                               ),
// // // // // //                             ),
// // // // // //                             IconButton(
// // // // // //                               icon: Icon(Icons.add),
// // // // // //                               onPressed: () {
// // // // // //                                 if (_commentController.text.isNotEmpty) {
// // // // // //                                   _addComment(post.id, _commentController.text);
// // // // // //                                   _commentController.clear();
// // // // // //                                 }
// // // // // //                               },
// // // // // //                             ),
// // // // // //                           ],
// // // // // //                         ),

// // // // // //                         ListView.builder(
// // // // // //                           shrinkWrap: true,
// // // // // //                           physics: NeverScrollableScrollPhysics(),
// // // // // //                           itemCount: post.comments.length,
// // // // // //                           itemBuilder: (context, index) {
// // // // // //                             final comment = post.comments[index];
// // // // // //                             return ListTile(
// // // // // //                               title: Text(comment.content),
// // // // // //                             );
// // // // // //                           },
// // // // // //                         ),
// // // // // //                         // TextField(
// // // // // //                         //   controller: _commentController,
// // // // // //                         //   decoration:
// // // // // //                         //       InputDecoration(hintText: 'Add a comment'),
// // // // // //                         //   onSubmitted: (text) {
// // // // // //                         //     if (text.isNotEmpty) {
// // // // // //                         //       _addComment(post.id, text);
// // // // // //                         //     }
// // // // // //                         //   },
// // // // // //                         // ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 );
// // // // // //               },
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //       floatingActionButton: FloatingActionButton(
// // // // // //         onPressed: _showPostDialog,
// // // // // //         backgroundColor: Colors.green,
// // // // // //         child: Icon(Icons.add),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }







