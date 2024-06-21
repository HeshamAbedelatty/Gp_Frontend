// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/PostAndCommentModel.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
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
//   final TextEditingController _postController = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();

//   void _addPost(String content) {
//     setState(() {
//       _posts.add(Post(id: DateTime.now().toString(), content: content));
//     });
//     _postController.clear();
//   }

//   void _addComment(String postId, String content) {
//     setState(() {
//       final post = _posts.firstWhere((post) => post.id == postId);
//       post.comments.add(Comment(id: DateTime.now().toString(), content: content));
//     });
//     _commentController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Group App')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _postController,
//                   decoration: InputDecoration(hintText: 'What\'s on your mind?'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_postController.text.isNotEmpty) {
//                       _addPost(_postController.text);
//                     }
//                   },
//                   child: Text('Post'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _posts.length,
//               itemBuilder: (context, index) {
//                 final post = _posts[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(post.content, style: TextStyle(fontSize: 16.0)),
//                         Divider(),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: post.comments.length,
//                           itemBuilder: (context, index) {
//                             final comment = post.comments[index];
//                             return ListTile(
//                               title: Text(comment.content),
//                             );
//                           },
//                         ),
//                         TextField(
//                           controller: _commentController,
//                           decoration: InputDecoration(hintText: 'Add a comment'),
//                           onSubmitted: (text) {
//                             if (text.isNotEmpty) {
//                               _addComment(post.id, text);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
