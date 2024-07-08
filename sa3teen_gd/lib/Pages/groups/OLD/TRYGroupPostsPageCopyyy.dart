// // ignore_for_file: avoid_print
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/GroupsAPI.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:like_button/like_button.dart';
// import 'package:intl/intl.dart';

// class GroupDetailPage extends StatefulWidget {
//   // final int id;
//   // final String groupName;
//   // final String groupImageUrl;
//   // final List<String> members;
//   // final String groupState;
//   final int groupId;
//   final String accessToken;
//   GroupDetailPage({required this.groupId, required this.accessToken});

//   // GroupDetailPage(
//   //     {required this.id,
//   //     required this.groupName,
//   //     required this.groupImageUrl,
//   //     required this.members,
//   //     required this.groupState});

//   @override
//   _GroupDetailPageState createState() => _GroupDetailPageState();
// }

// class _GroupDetailPageState extends State<GroupDetailPage> {
//    late Future<ListGroupsModel> futureGroup;

//   List<Post> _posts = [];
//   Map<String, TextEditingController> _commentControllers = {};
//   Map<String, TextEditingController> _replyControllers = {};
//   Map<String, bool> _showReplyFields = {};

//   // @override
//   // void initState() {
//   //   super.initState();
//   // }

//   void _addPost(String content) {
//     setState(() {
//       final newPost = Post(
//         id: DateTime.now().toString(),
//         content: content,
//         creatorName: 'New User',
//         creatorImageUrl: 'https://example.com/new_user.jpg',
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
//               creatorName: 'Commenter Name',
//               creatorImageUrl:
//                   'https://example.com/commenter_profile_picture.jpg',
//               createdAt: DateTime.now(),
//             ));
//       });
//       _commentControllers[postId]?.clear();
//     }
//   }

//   void _addReply(String postId, String commentId, String content) {
//     final postIndex = _posts.indexWhere((post) => post.id == postId);
//     if (postIndex != -1) {
//       final commentIndex = _posts[postIndex]
//           .comments
//           .indexWhere((comment) => comment.id == commentId);
//       if (commentIndex != -1) {
//         setState(() {
//           _posts[postIndex].comments[commentIndex].replies.add(Reply(
//                 id: DateTime.now().toString(),
//                 content: content,
//                 creatorName: 'Replier Name',
//                 creatorImageUrl:
//                     'https://example.com/replier_profile_picture.jpg',
//                 createdAt: DateTime.now(),
//               ));
//         });
//       }
//       _replyControllers[commentId]?.clear();
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

//   void _deletePost(String postId) {
//     setState(() {
//       _posts.removeWhere((post) => post.id == postId);
//     });
//   }

//   String _formatTimestamp(DateTime timestamp) {
//     return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
//   }
//  @override
//   void initState() {
//     super.initState();
//     futureGroup = GroupService().getGroupById(widget.accessToken, widget.groupId);
//   }
//   @override
//   void dispose() {
//     _commentControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     _replyControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
    

//       body: CustomScrollView(
//         slivers: [
//           // SizedBox(height: 10,),
//           const SliverToBoxAdapter(
//             child: Padding(
//               padding:  EdgeInsets.symmetric(horizontal: 16.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: SizedBox(
//                   height: 10,
//                 ),
//               ),
//             ),
//           ),
//           // SliverAppBar(
//           //   expandedHeight: 160.0,
//           //   backgroundColor: Colors.white,
//           //   flexibleSpace: FlexibleSpaceBar(
//           //     background: ClipRRect(
//           //       borderRadius: const BorderRadius.vertical(
//           //         // top: Radius.circular(15.0),
//           //         bottom: Radius.circular(20.0),
//           //       ),
//           //       child: Image.asset(
//           //           'lib/assets/icons/Web_Development_Banner_Image_0e476d1ab6.jpg',
//           //           fit: BoxFit.cover
//           //           // clipBehavior: Clip.hardEdge
//           //           ),
//           //       // child: Image.network(
//           //       //   widget.groupImageUrl,
//           //       //   fit: BoxFit.cover,
//           //       // ),
//           //     ),
//           //   ),
//           //   pinned: false,
//           //   title: Text(
//           //     widget.groupName,
//           //     style:const TextStyle(color: kprimaryColourWhite),
//           //   ),
//           // ),
// SliverToBoxAdapter(child: FutureBuilder<ListGroupsModel>(
//         future: futureGroup,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data found'));
//           } else {
//             final group = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Text('ID: ${group.id}', style: TextStyle(fontSize: 18)),
//                 const  SizedBox(height: 8),
//                   Text(group.title, style:const TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
//                  const SizedBox(height: 5),
//                   //  const  SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.lock,color:Colors.grey,size: 18 ,),
//                       Text(' ${group.type} group ', style: TextStyle(fontSize: 22,color: Colors.grey)),
//                    Text('(${group.members} members)', style: TextStyle(fontSize: 16,color: Colors.grey)), ],
//                   ),
//                   Card(child: Column(children: [Text('Description: ${group.description}', style: TextStyle(fontSize: 18)),],),),
                  
              
//                 const  SizedBox(height: 8),
                 
//                  const SizedBox(height: 8),
                  
//                 const  SizedBox(height: 8),
//                   group.image != null
//                       ? Image.network(group.image!)
//                       :const Text('No image available', style: TextStyle(fontSize: 18)),
               
//                 ],
//               ),
//             );
//           }
//         },
//       ),)
//           //  SliverToBoxAdapter(
//           //   child: Padding(
//           //     padding: EdgeInsets.symmetric(horizontal: 16.0),
//           //     child: Align(
//           //       alignment: Alignment.centerLeft,
//           //       child: Column(
//           //         crossAxisAlignment: CrossAxisAlignment.start,
//           //         children: [
//           //           SizedBox(height: 8),
//           //           // Text(widget.groupState);
//           //           Text(
//           //             'Members',
//           //             style:
//           //                 TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           //           ),
//           //           SizedBox(height: 8),
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           // ,SliverToBoxAdapter(
//           //   child: Padding(
//           //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           //     child: Column(
//           //       children: [
//           //         Row(
//           //           children: widget.members.map((member) {
//           //             return const CircleAvatar(
//           //               radius: 17,
//           //               backgroundColor: Color.fromARGB(255, 198, 244, 224),
//           //             );
//           //           }).toList(),
//           //         ),
//           //         const SizedBox(height: 14),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           // SliverToBoxAdapter(
//           //   child: Padding(
//           //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           //       child: Column(
//           //         children: [
//           //           Row(
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             children: [
//           //               RoundedButton(
//           //                 height: 40,
//           //                 width: 175,
//           //                 colory: kprimaryColourGreen,
//           //                 buttonText: 'Group Setting',
//           //                 onPressed: () {
//           //                   // Action to perform when Group Setting button is clicked
//           //                   print('Group Setting button clicked!');
//           //                 },
//           //               ),
//           //              const SizedBox(
//           //                   width:
//           //                       16), // Adjust spacing between buttons as needed
//           //               RoundedButton(
//           //                 height: 40,
//           //                 width: 175,
//           //                 colory: kprimaryColourcream,
//           //                 buttonText: 'Share',
//           //                 onPressed: () {
//           //                   // Action to perform when Share Button is clicked
//           //                   print('Share button clicked!');
//           //                 },
//           //               ),
//           //             ],
//           //           ),
//           //         const  SizedBox(height: 12),
//           //           Row(
//           //             mainAxisAlignment: MainAxisAlignment.center,
//           //             children: [
//           //               RoundedButton(
//           //                 height: 40,
//           //                 width: 100,
//           //                 colory: kprimaryColourcream,
//           //                 buttonText: 'you',
//           //                 onPressed: () {
//           //                   // Action to perform when Group Setting button is clicked
//           //                   print('Group Setting button clicked!');
//           //                 },
//           //               ),
//           //             const  SizedBox(
//           //                   width:
//           //                       16), // Adjust spacing between buttons as needed
//           //               RoundedButton(
//           //                 height: 40,
//           //                 width: 100,
//           //                 colory: kprimaryColourcream,
//           //                 buttonText: 'favorites',
//           //                 onPressed: () {
//           //                   // Action to perform when Another Button is clicked
//           //                   print('Another button clicked!');
//           //                 },
//           //               ),
//           //             const  SizedBox(
//           //                   width:
//           //                       16), // Adjust spacing between buttons as needed
//           //               RoundedButton(
//           //                 height: 40,
//           //                 width: 100,
//           //                 colory: kprimaryColourcream,
//           //                 buttonText: 'materials',
//           //                 onPressed: () {
//           //                   // Action to perform when Another Button is clicked
//           //                   print('Another button clicked!');
//           //                   // Add your custom action here
//           //                 },
//           //               ),
//           //             ],
//           //           ),
//           //         const  SizedBox(height: 10),
//           //         ],
//           //       )),
//           // ),
         
//           // SliverPadding(
//           //   padding: const EdgeInsets.all(10),
//           //   sliver: SliverList(
//           //     delegate: SliverChildBuilderDelegate(
//           //       (BuildContext context, int index) {
//           //         if (index < _posts.length) {
//           //           // Check index range
//           //           final post = _posts[index];
//           //           return Card(
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(20.0),
//           //             ),
//           //             shadowColor: Colors.black,
//           //             color: kprimaryColourWhite,
//           //             child: Padding(
//           //               padding: const EdgeInsets.all(12.0),
//           //               child: Column(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: [
//           //                   Row(
//           //                     children: [
//           //                       CircleAvatar(
//           //                         backgroundImage:
//           //                             NetworkImage(post.creatorImageUrl),
//           //                       ),
//           //                       const SizedBox(width: 10.0),
//           //                       Column(
//           //                         crossAxisAlignment: CrossAxisAlignment.start,
//           //                         children: [
//           //                           Text(post.creatorName,
//           //                               style: const TextStyle(
//           //                                   fontWeight: FontWeight.bold)),
//           //                           Text(_formatTimestamp(post.createdAt),
//           //                               style: const TextStyle(
//           //                                   color: Colors.grey,
//           //                                   fontSize: 12.0)),
//           //                         ],
//           //                       ),
//           //                       const Spacer(),
//           //                       PopupMenuButton<String>(
//           //                         onSelected: (String value) {
//           //                           if (value == 'delete') {
//           //                             showDialog(
//           //                               context: context,
//           //                               builder: (context) => AlertDialog(
//           //                                 title:const Text('Delete Post'),
//           //                                 content:const Text(
//           //                                     'Are you sure you want to delete this post?'),
//           //                                 actions: [
//           //                                   TextButton(
//           //                                     onPressed: () {
//           //                                       Navigator.of(context).pop();
//           //                                     },
//           //                                     child:const Text('Cancel'),
//           //                                   ),
//           //                                   TextButton(
//           //                                     onPressed: () {
//           //                                       _deletePost(post.id);
//           //                                       Navigator.of(context).pop();
//           //                                     },
//           //                                     child:const Text('Delete'),
//           //                                   ),
//           //                                 ],
//           //                               ),
//           //                             );
//           //                           }
//           //                         },
//           //                         itemBuilder: (BuildContext context) {
//           //                           return {'delete'}.map((String choice) {
//           //                             return PopupMenuItem<String>(
//           //                               value: choice,
//           //                               child: Text(choice),
//           //                             );
//           //                           }).toList();
//           //                         },
//           //                       ),
//           //                     ],
//           //                   ),
//           //                   const SizedBox(height: 10.0),
//           //                   Text(post.content,
//           //                       style: const TextStyle(fontSize: 16.0)),
//           //                   const SizedBox(height: 10.0),
//           //                   Row(
//           //                     children: [
//           //                       LikeButton(
//           //                         circleColor: const CircleColor(
//           //                             start: Color(0xff00ddff),
//           //                             end: Color(0xff0099cc)),
//           //                         bubblesColor: const BubblesColor(
//           //                             dotPrimaryColor: Color(0xff33b5e5),
//           //                             dotSecondaryColor: Color(0xff0099cc)),
//           //                         likeBuilder: (bool isLiked) {
//           //                           return Icon(
//           //                             Icons.thumb_up,
//           //                             color: isLiked
//           //                                 ? Colors.green.shade700
//           //                                 : Colors.brown.shade200,
//           //                           );
//           //                         },
//           //                         likeCount: post.likes,
//           //                       ),
//           //                       Text(
//           //                         ' Likes',
//           //                         style: TextStyle(
//           //                           color: Colors.brown.shade200,
//           //                         ),
//           //                       ),
//           //                       const Spacer(flex: 1),
//           //                       LikeButton(
//           //                         circleColor: const CircleColor(
//           //                             start: Color(0xff00ddff),
//           //                             end: Color(0xff0099cc)),
//           //                         bubblesColor: const BubblesColor(
//           //                             dotPrimaryColor: Color(0xff33b5e5),
//           //                             dotSecondaryColor: Color(0xff0099cc)),
//           //                         likeBuilder: (bool isLiked) {
//           //                           return Icon(
//           //                             Icons.thumb_down,
//           //                             color: isLiked
//           //                                 ? Colors.green.shade700
//           //                                 : Colors.brown.shade200,
//           //                           );
//           //                         },
//           //                         likeCount: post.dislikes,
//           //                       ),
//           //                       Text(
//           //                         ' Dislikes',
//           //                         style: TextStyle(
//           //                           color: Colors.brown.shade200,
//           //                         ),
//           //                       ),
//           //                       const Spacer(flex: 1),
//           //                       IconButton(
//           //                         onPressed: () {
//           //                           _toggleComments(post.id);
//           //                         },
//           //                         icon: Icon(
//           //                           Icons.comment,
//           //                           color: Colors.brown.shade200,
//           //                         ),
//           //                       ),
//           //                       Text(
//           //                         'Comments',
//           //                         style: TextStyle(
//           //                           color: Colors.brown.shade200,
//           //                         ),
//           //                       ),
//           //                       const Spacer(flex: 1),
//           //                       LikeButton(
//           //                         likeBuilder: (bool isLiked) {
//           //                           return Icon(
//           //                             Icons.favorite,
//           //                             color: isLiked
//           //                                 ? Colors.red.shade900
//           //                                 : Colors.brown.shade200,
//           //                           );
//           //                         },
//           //                       ),
//           //                     ],
//           //                   ),
//           //                   const SizedBox(height: 10.0),
//           //                   if (post.showComments) ...[
//           //                     const Divider(),
//           //                     Row(
//           //                       children: [
//           //                         Expanded(
//           //                           child: TextFormField(
//           //                             controller: _commentControllers[post.id],
//           //                             decoration: InputDecoration(
//           //                               hintText: 'Add a comment',
//           //                               border: OutlineInputBorder(
//           //                                   borderRadius:
//           //                                       BorderRadius.circular(25)),
//           //                             ),
//           //                             onFieldSubmitted: (text) {
//           //                               if (text.isNotEmpty) {
//           //                                 _addComment(post.id, text);
//           //                                 _commentControllers[post.id]?.clear();
//           //                               }
//           //                             },
//           //                           ),
//           //                         ),
//           //                         IconButton(
//           //                           icon: Icon(
//           //                             Icons.send,
//           //                             color: Colors.brown.shade200,
//           //                           ),
//           //                           onPressed: () {
//           //                             if (_commentControllers[post.id]
//           //                                     ?.text
//           //                                     .isNotEmpty ??
//           //                                 false) {
//           //                               _addComment(post.id,
//           //                                   _commentControllers[post.id]!.text);
//           //                               _commentControllers[post.id]?.clear();
//           //                             }
//           //                           },
//           //                         ),
//           //                       ],
//           //                     ),
//           //                     ListView.builder(
//           //                       shrinkWrap: true,
//           //                       physics: const NeverScrollableScrollPhysics(),
//           //                       itemCount: post.comments.length,
//           //                       itemBuilder: (context, index) {
//           //                         final comment = post.comments[index];
//           //                         return Padding(
//           //                           padding: const EdgeInsets.all(8.0),
//           //                           child: Card(
//           //                             shape: RoundedRectangleBorder(
//           //                               borderRadius:
//           //                                   BorderRadius.circular(35.0),
//           //                             ),
//           //                             color: Colors.white,
//           //                             margin: const EdgeInsets.symmetric(
//           //                                 vertical: 4.0, horizontal: 8.0),
//           //                             child: Padding(
//           //                               padding: const EdgeInsets.all(8.0),
//           //                               child: Column(
//           //                                 crossAxisAlignment:
//           //                                     CrossAxisAlignment.start,
//           //                                 children: [
//           //                                   Row(
//           //                                     children: [
//           //                                       CircleAvatar(
//           //                                         radius: 15,
//           //                                         backgroundImage: NetworkImage(
//           //                                             comment.creatorImageUrl),
//           //                                       ),
//           //                                       const SizedBox(width: 10.0),
//           //                                       Column(
//           //                                         crossAxisAlignment:
//           //                                             CrossAxisAlignment.start,
//           //                                         children: [
//           //                                           Text(comment.creatorName,
//           //                                               style: const TextStyle(
//           //                                                   fontWeight:
//           //                                                       FontWeight
//           //                                                           .bold)),
//           //                                           Text(
//           //                                               _formatTimestamp(
//           //                                                   comment.createdAt),
//           //                                               style: const TextStyle(
//           //                                                   color: Colors.grey,
//           //                                                   fontSize: 12.0)),
//           //                                           Text(comment.content),
//           //                                         ],
//           //                                       ),
//           //                                       const Spacer(),
//           //                                       LikeButton(
//           //                                         circleColor:
//           //                                             const CircleColor(
//           //                                                 start:
//           //                                                     Color(0xff00ddff),
//           //                                                 end: Color(
//           //                                                     0xff0099cc)),
//           //                                         bubblesColor:
//           //                                             const BubblesColor(
//           //                                                 dotPrimaryColor:
//           //                                                     Color(0xff33b5e5),
//           //                                                 dotSecondaryColor:
//           //                                                     Color(
//           //                                                         0xff0099cc)),
//           //                                         likeBuilder: (bool isLiked) {
//           //                                           return Icon(
//           //                                             Icons.thumb_up,
//           //                                             color: isLiked
//           //                                                 ? Colors
//           //                                                     .green.shade700
//           //                                                 : Colors
//           //                                                     .brown.shade200,
//           //                                             size: 18,
//           //                                           );
//           //                                         },
//           //                                         likeCount: comment.likes,
//           //                                         onTap: (isLiked) async {
//           //                                           _toggleCommentLike(post.id,
//           //                                               comment.id, true);
//           //                                           return !isLiked;
//           //                                         },
//           //                                       ),
//           //                                       const SizedBox(width: 8.0),
//           //                                       LikeButton(
//           //                                         circleColor:
//           //                                             const CircleColor(
//           //                                                 start:
//           //                                                     Color(0xff00ddff),
//           //                                                 end: Color(
//           //                                                     0xff0099cc)),
//           //                                         bubblesColor:
//           //                                             const BubblesColor(
//           //                                                 dotPrimaryColor:
//           //                                                     Color(0xff33b5e5),
//           //                                                 dotSecondaryColor:
//           //                                                     Color(
//           //                                                         0xff0099cc)),
//           //                                         likeBuilder: (bool isLiked) {
//           //                                           return Icon(
//           //                                             Icons.thumb_down,
//           //                                             color: isLiked
//           //                                                 ? Colors
//           //                                                     .green.shade700
//           //                                                 : Colors
//           //                                                     .brown.shade200,
//           //                                             size: 18,
//           //                                           );
//           //                                         },
//           //                                         likeCount: comment.dislikes,
//           //                                         onTap: (isLiked) async {
//           //                                           _toggleCommentLike(post.id,
//           //                                               comment.id, false);
//           //                                           return !isLiked;
//           //                                         },
//           //                                       ),
//           //                                       IconButton(
//           //                                         onPressed: () {
//           //                                           _deleteComment(
//           //                                               post.id, comment.id);
//           //                                         },
//           //                                         icon: Icon(
//           //                                           Icons.delete,
//           //                                           color:
//           //                                               Colors.brown.shade200,
//           //                                           size: 18,
//           //                                         ),
//           //                                       ),
//           //                                     ],
//           //                                   ),
//           //                                   Column(
//           //                                     crossAxisAlignment:
//           //                                         CrossAxisAlignment.start,
//           //                                     children: [
//           //                                       Row(
//           //                                         children: [
//           //                                           IconButton(
//           //                                             icon: Icon(
//           //                                               Icons.reply,
//           //                                               color: Colors
//           //                                                   .brown.shade200,
//           //                                               size: 18,
//           //                                             ),
//           //                                             onPressed: () {
//           //                                               setState(() {
//           //                                                 _showReplyFields[
//           //                                                         comment.id] =
//           //                                                     !(_showReplyFields[
//           //                                                             comment
//           //                                                                 .id] ??
//           //                                                         false);
//           //                                               });
//           //                                             },
//           //                                           ),
//           //                                           const Text('Reply'),
//           //                                         ],
//           //                                       ),
//           //                                       if (_showReplyFields[
//           //                                               comment.id] ??
//           //                                           false)
//           //                                         Row(
//           //                                           children: [
//           //                                             Expanded(
//           //                                               child: TextFormField(
//           //                                                 controller:
//           //                                                     _replyControllers[
//           //                                                         comment.id],
//           //                                                 decoration:
//           //                                                     InputDecoration(
//           //                                                   hintText:
//           //                                                       'Add a reply',
//           //                                                   border: OutlineInputBorder(
//           //                                                       borderRadius:
//           //                                                           BorderRadius
//           //                                                               .circular(
//           //                                                                   25)),
//           //                                                 ),
//           //                                                 onFieldSubmitted:
//           //                                                     (text) {
//           //                                                   if (text
//           //                                                       .isNotEmpty) {
//           //                                                     _addReply(
//           //                                                         post.id,
//           //                                                         comment.id,
//           //                                                         text);
//           //                                                     _replyControllers[
//           //                                                             comment
//           //                                                                 .id]
//           //                                                         ?.clear();
//           //                                                   } //dy 48ala 3adi li t7t 3nd l icon li m4 48ala
//           //                                                 },
//           //                                               ),
//           //                                             ),
//           //                                             IconButton(
//           //                                               icon: Icon(
//           //                                                 Icons.send,
//           //                                                 color: Colors
//           //                                                     .brown.shade200,
//           //                                               ),
//           //                                               onPressed: () {
//           //                                                 // Ensure _replyControllers[comment.id] exists and its text is not empty
//           //                                                 if (_replyControllers[
//           //                                                             comment
//           //                                                                 .id]
//           //                                                         ?.text
//           //                                                         .isNotEmpty ??
//           //                                                     false) {
//           //                                                   String replyText =
//           //                                                       _replyControllers[
//           //                                                               comment
//           //                                                                   .id]!
//           //                                                           .text;
//           //                                                   _addReply(
//           //                                                       post.id,
//           //                                                       comment.id,
//           //                                                       replyText);
//           //                                                   _replyControllers[
//           //                                                           comment.id]
//           //                                                       ?.clear();
//           //                                                   // Add focus removal logic if needed
//           //                                                 } else {
//           //                                                   // Log or handle the case where reply text is empty or controller is null
//           //                                                   print(
//           //                                                       "Reply text is empty or _replyControllers[comment.id] is null.");
//           //                                                   print(
//           //                                                       "hi ${_replyControllers[comment.id]}");
//           //                                                 }
//           //                                               },
//           //                                             ),
//           //                                           ],
//           //                                         ),
//           //                                       ListView.builder(
//           //                                         shrinkWrap: true,
//           //                                         physics:
//           //                                             const NeverScrollableScrollPhysics(),
//           //                                         itemCount:
//           //                                             comment.replies.length,
//           //                                         itemBuilder:
//           //                                             (context, replyIndex) {
//           //                                           final reply = comment
//           //                                               .replies[replyIndex];
//           //                                           return Padding(
//           //                                             padding:
//           //                                                 const EdgeInsets.all(
//           //                                                     8.0),
//           //                                             child: Row(
//           //                                               crossAxisAlignment:
//           //                                                   CrossAxisAlignment
//           //                                                       .start,
//           //                                               children: [
//           //                                                 CircleAvatar(
//           //                                                   radius: 12,
//           //                                                   backgroundImage:
//           //                                                       NetworkImage(reply
//           //                                                           .creatorImageUrl),
//           //                                                 ),
//           //                                                 const SizedBox(
//           //                                                     width: 10.0),
//           //                                                 Column(
//           //                                                   crossAxisAlignment:
//           //                                                       CrossAxisAlignment
//           //                                                           .start,
//           //                                                   children: [
//           //                                                     Text(
//           //                                                         reply
//           //                                                             .creatorName,
//           //                                                         style: const TextStyle(
//           //                                                             fontWeight:
//           //                                                                 FontWeight
//           //                                                                     .bold)),
//           //                                                     Text(
//           //                                                         _formatTimestamp(
//           //                                                             reply
//           //                                                                 .createdAt),
//           //                                                         style: const TextStyle(
//           //                                                             color: Colors
//           //                                                                 .grey,
//           //                                                             fontSize:
//           //                                                                 12.0)),
//           //                                                     Text(reply
//           //                                                         .content),
//           //                                                   ],
//           //                                                 ),
//           //                                               ],
//           //                                             ),
//           //                                           );
//           //                                         },
//           //                                       ),
//           //                                     ],
//           //                                   ),
//           //                                 ],
//           //                               ),
//           //                             ),
//           //                           ),
//           //                         );
//           //                       },
//           //                     ),
//           //                   ],
//           //                 ],
//           //               ),
//           //             ),
//           //           );
//           //         } else {
//           //           return SizedBox
//           //               .shrink(); // Return an empty SizedBox if index is out of range
//           //         }
//           //       },
//           //       childCount: _posts.length,
//               // ),
//             // ),
//           // ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         backgroundColor: Colors.green,
//         child:const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }