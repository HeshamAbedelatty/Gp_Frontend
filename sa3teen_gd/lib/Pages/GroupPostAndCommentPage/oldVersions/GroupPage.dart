//not needed anymore old version
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'PostWidget.dart';

// class GroupPage extends StatefulWidget {
//   final String groupName;
//   final String groupImageUrl;
//   final List<String> members;

//   GroupPage({
//     required this.groupName,
//     required this.groupImageUrl,
//     required this.members,
//   });

//   @override
//   _GroupPageState createState() => _GroupPageState();
// }

// class _GroupPageState extends State<GroupPage> {
//   List<Post> posts = [];

//   @override
//   void initState() {
//     super.initState();
//     // Add some dummy posts
//     posts = [
//       Post(
//         id: '1',
//         content: 'This is the first post',
//         creatorName: 'User 1',
//         creatorImageUrl: 'https://example.com/user1.jpg',
//         likes: 10,
//         dislikes: 2,
//         createdAt: DateTime.now().subtract(Duration(hours: 1)),
//       ),
//       Post(
//         id: '2',
//         content: 'This is the second post',
//         creatorName: 'User 2',
//         creatorImageUrl: 'https://example.com/user2.jpg',
//         likes: 5,
//         dislikes: 1,
//         createdAt: DateTime.now().subtract(Duration(hours: 2)),
//       ),
//       Post(
//         id: '3',
//         content: 'This is the second post',
//         creatorName: 'User 2',
//         creatorImageUrl: 'https://example.com/user2.jpg',
//         likes: 5,
//         dislikes: 1,
//         createdAt: DateTime.now().subtract(Duration(hours: 2)),
//       ),
//       Post(
//         id: '4',
//         content: 'This is the second post',
//         creatorName: 'User 2',
//         creatorImageUrl: 'https://example.com/user2.jpg',
//         likes: 5,
//         dislikes: 1,
//         createdAt: DateTime.now().subtract(Duration(hours: 2)),
//       ),
//     ];
//   }

//   void _addPost(String content) {
//     setState(() {
//       posts.add(
//         Post(
//           id: DateTime.now().toString(),
//           content: content,
//           creatorName: 'New User',
//           creatorImageUrl: 'https://example.com/new_user.jpg',
//           likes: 0,
//           dislikes: 0,
//           createdAt: DateTime.now(),
//         ),
//       );
//     });
//   }

//   void _showPostDialog() {
//     final TextEditingController _postController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title:const Text('Create Post'),
//         content: TextField(
//           controller: _postController,
//           decoration:const InputDecoration(hintText: 'Write your post here...'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (_postController.text.isNotEmpty) {
//                 _addPost(_postController.text);
//                 Navigator.of(context).pop();
//               }
//             },
//             child: Text('Post'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
        
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 175.0,
//             backgroundColor: Colors.amber,
//             flexibleSpace:const FlexibleSpaceBar(
//               background: ClipRRect(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(30.0),
//                 ),
                
//                 // child: Image.network(
//                 //   widget.groupImageUrl,
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//             ),
//             pinned: false,
//             title: Text(widget.groupName),
//           ),
//          const SliverToBoxAdapter(
          
//           ),
//         const  SliverToBoxAdapter(
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Members',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: widget.members.map((member) {
//                   return const CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Color.fromARGB(255, 134, 143, 148),
//                     // backgroundImage: NetworkImage(widget.groupImageUrl)
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         const  SliverToBoxAdapter(
//             child: Divider(),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return PostWidget(
//                   post: posts[index],
//                   onDelete: () {
//                     setState(() {
//                       posts.removeAt(index);
//                     });
//                   },
//                   onLike: () {
//                     setState(() {
//                       posts[index].likes++;
//                     });
//                   },
//                   onDislike: () {
//                     setState(() {
//                       posts[index].dislikes++;
//                     });
//                   },
//                   onComment: (comment) {
//                     setState(() {
//                       // posts[index].comments.add(comment);
//                     });
//                   },
//                 );
//               },
//               childCount: posts.length,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/GroupPostAndCommentPage/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import 'PostWidget.dart';

// // class GroupPage extends StatefulWidget {
// //   final String groupName;
// //   final String groupImageUrl;
// //   final List<String> members;

// //   GroupPage({
// //     required this.groupName,
// //     required this.groupImageUrl,
// //     required this.members,
// //   });

// //   @override
// //   _GroupPageState createState() => _GroupPageState();
// // }

// // class _GroupPageState extends State<GroupPage> {
// //   List<Post> posts = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Add some dummy posts
// //     posts = [
// //       Post(
// //         id: '1',
// //         content: 'This is the first post',
// //         creatorName: 'User 1',
// //         creatorImageUrl: 'https://example.com/user1.jpg',
// //         likes: 10,
// //         dislikes: 2,
// //         createdAt: DateTime.now().subtract(Duration(hours: 1)),
// //       ),
// //       Post(
// //         id: '2',
// //         content: 'This is the second post',
// //         creatorName: 'User 2',
// //         creatorImageUrl: 'https://example.com/user2.jpg',
// //         likes: 5,
// //         dislikes: 1,
// //         createdAt: DateTime.now().subtract(Duration(hours: 2)),
// //       ),
// //     ];
// //   }

// //   void _addPost(String content) {
// //     setState(() {
// //       posts.add(
// //         Post(
// //           id: DateTime.now().toString(),
// //           content: content,
// //           creatorName: 'New User',
// //           creatorImageUrl: 'https://example.com/new_user.jpg',
// //           likes: 0,
// //           dislikes: 0,
// //           createdAt: DateTime.now(),
// //         ),
// //       );
// //     });
// //   }

// //   void _showPostDialog() {
// //     final TextEditingController _postController = TextEditingController();

// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Create Post'),
// //         content: TextField(
// //           controller: _postController,
// //           decoration: InputDecoration(hintText: 'Write your post here...'),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //             child: Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               if (_postController.text.isNotEmpty) {
// //                 _addPost(_postController.text);
// //                 Navigator.of(context).pop();
// //               }
// //             },
// //             child: Text('Post'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.groupName),
// //       ),
// //       body: CustomScrollView(
// //         slivers: [
// //           SliverToBoxAdapter(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Row(
// //                 children: [
// //                   CircleAvatar(
// //                     radius: 30,
// //                     backgroundImage: NetworkImage(widget.groupImageUrl),
// //                   ),
// //                   SizedBox(width: 16),
// //                   Text(
// //                     widget.groupName,
// //                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Align(
// //                 alignment: Alignment.centerLeft,
// //                 child: Text(
// //                   'Members',
// //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Row(
// //                 children: widget.members.map((member) {
// //                   return const CircleAvatar(
// //                     radius: 20,
// //                     backgroundColor: Color.fromARGB(255, 134, 143, 148),
// //                     // backgroundImage: NetworkImage(widget.groupImageUrl)
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: Divider(),
// //           ),
// //           SliverList(
// //             delegate: SliverChildBuilderDelegate(
// //               (context, index) {
// //                 return PostWidget(
// //                   post: posts[index],
// //                   onDelete: () {
// //                     setState(() {
// //                       posts.removeAt(index);
// //                     });
// //                   },
// //                   onLike: () {
// //                     setState(() {
// //                       posts[index].likes++;
// //                     });
// //                   },
// //                   onDislike: () {
// //                     setState(() {
// //                       posts[index].dislikes++;
// //                     });
// //                   },
// //                   onComment: (comment) {
// //                     setState(() {
// //                       // posts[index].comments.add(comment);
// //                     });
// //                   },
// //                 );
// //               },
// //               childCount: posts.length,
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showPostDialog,
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // import 'PostWidget.dart';

// // // class GroupPage extends StatefulWidget {
// // //   final String groupName;
// // //   final String groupImageUrl;
// // //   final List<String> members;

// // //   GroupPage({
// // //     required this.groupName,
// // //     required this.groupImageUrl,
// // //     required this.members,
// // //   });

// // //   @override
// // //   _GroupPageState createState() => _GroupPageState();
// // // }

// // // class _GroupPageState extends State<GroupPage> {
// // //   List<Post> posts = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Add some dummy posts
// // //     posts = [
// // //       Post(
// // //         id: '1',
// // //         content: 'This is the first post',
// // //         creatorName: 'User 1',
// // //         creatorImageUrl: 'https://example.com/user1.jpg',
// // //         likes: 10,
// // //         dislikes: 2,
// // //         createdAt: DateTime.now().subtract(Duration(hours: 1)),
// // //       ),
// // //       Post(
// // //         id: '2',
// // //         content: 'This is the second post',
// // //         creatorName: 'User 2',
// // //         creatorImageUrl: 'https://example.com/user2.jpg',
// // //         likes: 5,
// // //         dislikes: 1,
// // //         createdAt: DateTime.now().subtract(Duration(hours: 2)),
// // //       ),
// // //     ];
// // //   }

// // //   void _addPost(String content) {
// // //     setState(() {
// // //       posts.add(
// // //         Post(
// // //           id: DateTime.now().toString(),
// // //           content: content,
// // //           creatorName: 'New User',
// // //           creatorImageUrl: 'https://example.com/new_user.jpg',
// // //           likes: 0,
// // //           dislikes: 0,
// // //           createdAt: DateTime.now(),
// // //         ),
// // //       );
// // //     });
// // //   }

// // //   void _showPostDialog() {
// // //     final TextEditingController _postController = TextEditingController();

// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text('Create Post'),
// // //         content: TextField(
// // //           controller: _postController,
// // //           decoration: InputDecoration(hintText: 'Write your post here...'),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () {
// // //               Navigator.of(context).pop();
// // //             },
// // //             child: Text('Cancel'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_postController.text.isNotEmpty) {
// // //                 _addPost(_postController.text);
// // //                 Navigator.of(context).pop();
// // //               }
// // //             },
// // //             child: Text('Post'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(widget.groupName),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Row(
// // //               children: [

// // //                 CircleAvatar(
// // //                   radius: 30,
// // //                   backgroundImage: NetworkImage(widget.groupImageUrl),
// // //                 ),
// // //                 SizedBox(width: 16),
// // //                 Text(
// // //                   widget.groupName,
// // //                   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //          const Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //             child: Align(
// // //               alignment: Alignment.centerLeft,
// // //               child: Text(
// // //                 'Members',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //               ),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// // //             child: Row(
// // //               children: widget.members.map((member) {
// // //                 return const CircleAvatar(radius: 20,
// // //                 backgroundColor: Color.fromARGB(255, 134, 143, 148),
// // //                   // backgroundImage: NetworkImage(widget.groupImageUrl)
// // //                   );
// // //                 // ListTile(
// // //                 //   leading: Icon(Icons.person),
// // //                 //   // title: Text(member),
// // //                 // );
// // //               }).toList(),
// // //             ),
// // //           ),
// // //           Divider(),
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: posts.length,
// // //               itemBuilder: (context, index) {
// // //                 return PostWidget(
// // //                   post: posts[index],
// // //                   onDelete: () {
// // //                     setState(() {
// // //                       posts.removeAt(index);
// // //                     });
// // //                   },
// // //                   onLike: () {
// // //                     setState(() {
// // //                       posts[index].likes++;
// // //                     });
// // //                   },
// // //                   onDislike: () {
// // //                     setState(() {
// // //                       posts[index].dislikes++;
// // //                     });
// // //                   },
// // //                   onComment: (comment) {
// // //                     setState(() {
// // //                       // posts[index].comments.add(comment);
// // //                     });
// // //                   },
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _showPostDialog,
// // //         child: Icon(Icons.add),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/PostAndCommentPage2noReplyForChat.dart';

// // // class GroupPage extends StatelessWidget {
// // //   final String groupName;
// // //   final String groupImageUrl;
// // //   final List<String> members;

// // //   GroupPage({
// // //     required this.groupName,
// // //     required this.groupImageUrl,
// // //     required this.members,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(groupName),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Row(
// // //               children: [
// // //                 CircleAvatar(
// // //                   backgroundImage: NetworkImage(groupImageUrl),
// // //                   radius: 40.0,
// // //                 ),
// // //                 SizedBox(width: 20.0),
// // //                 Text(
// // //                   groupName,
// // //                   style: TextStyle(
// // //                     fontSize: 24.0,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   'Members',
// // //                   style: TextStyle(
// // //                     fontSize: 18.0,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: 10.0),
// // //                 ...members.map((member) => ListTile(
// // //                       leading: Icon(Icons.person),
// // //                       title: Text(member),
// // //                     )),
// // //               ],
// // //             ),
// // //           ),
// // //           Expanded(child: PostAndCommentPage()),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
