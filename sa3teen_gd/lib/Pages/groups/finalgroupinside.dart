import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
import 'package:gp_screen/Pages/groups/GroupsAPI.dart';
import 'package:gp_screen/Pages/groups/postsComments.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
class GroupDetailPage extends StatefulWidget {
  final int groupId;
  final String accessToken;

  GroupDetailPage({required this.groupId, required this.accessToken});

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  late Future<ListGroupsModel> futureGroup;
  List<Post> _posts = [];
  Map<String, TextEditingController> _commentControllers = {};
  Map<String, TextEditingController> _replyControllers = {};
  Map<String, bool> _showReplyFields = {};

  @override
  void initState() {
    super.initState();
    futureGroup = GroupService().getGroupById(widget.accessToken, widget.groupId);
  }

  void _addPost(String content) {
    setState(() {
      final newPost = Post(
        id: DateTime.now().toString(),
        content: content,
        creatorName: 'New User',
        creatorImageUrl: 'https://example.com/new_user.jpg',
        likes: 0,
        dislikes: 0,
        createdAt: DateTime.now(),
      );
      _posts.add(newPost);
      _commentControllers[newPost.id] = TextEditingController();
    });
  }

  void _addComment(String postId, String content) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      setState(() {
        _posts[postIndex].comments.add(Comment(
          id: DateTime.now().toString(),
          content: content,
          creatorName: 'Commenter Name',
          creatorImageUrl: 'https://example.com/commenter_profile_picture.jpg',
          createdAt: DateTime.now(),
        ));
      });
      _commentControllers[postId]?.clear();
    }
  }

  void _addReply(String postId, String commentId, String content) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final commentIndex = _posts[postIndex]
          .comments
          .indexWhere((comment) => comment.id == commentId);
      if (commentIndex != -1) {
        setState(() {
          _posts[postIndex].comments[commentIndex].replies.add(Reply(
            id: DateTime.now().toString(),
            content: content,
            creatorName: 'Replier Name',
            creatorImageUrl: 'https://example.com/replier_profile_picture.jpg',
            createdAt: DateTime.now(),
          ));
        });
      }
      _replyControllers[commentId]?.clear();
    }
  }

  void _toggleComments(String postId) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        _posts[postIndex].showComments = !_posts[postIndex].showComments;
      }
    });
  }

  void _toggleCommentLike(String postId, String commentId, bool isLike) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        final commentIndex = _posts[postIndex]
            .comments
            .indexWhere((comment) => comment.id == commentId);
        if (commentIndex != -1) {
          if (isLike) {
            _posts[postIndex].comments[commentIndex].likes++;
          } else {
            _posts[postIndex].comments[commentIndex].dislikes++;
          }
        }
      }
    });
  }

  void _deleteComment(String postId, String commentId) {
    setState(() {
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex != -1) {
        _posts[postIndex]
            .comments
            .removeWhere((comment) => comment.id == commentId);
      }
    });
  }

  void _deletePost(String postId) {
    setState(() {
      _posts.removeWhere((post) => post.id == postId);
    });
  }

  void _showPostDialog() {
    final TextEditingController _postController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: TextField(
            controller: _postController,
            decoration: const InputDecoration(hintText: 'What\'s on your mind?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_postController.text.isNotEmpty) {
                  _addPost(_postController.text);
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _commentControllers.forEach((key, controller) {
      controller.dispose();
    });
    _replyControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder<ListGroupsModel>(
        future: futureGroup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final group = snapshot.data!;
            return ListView(
              children: [
                const SizedBox(height: 8),
                group.image != null
                    ? Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.only(bottomLeft: Radius.circular(20)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(group.image!),
                          ),
                        ),
                      )
                    : Container(
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                            color: kprimaryColourcream),
                        child: Icon(
                          Icons.group,
                          size: 50,
                          color: Colors.grey.shade800,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(group.title,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text(group.subject,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.lock,
                            color: Colors.grey,
                            size: 18,
                          ),
                          Text(' ${group.type} group ',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700)),
                          Text('(${group.members} members)',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600)),
                          Spacer(flex: 1),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                            height: 40,
                            width: 175,
                            colory: kprimaryColourGreen,
                            buttonText: 'Group Setting',
                            onPressed: () {
                              print('Group Setting button clicked!');
                            },
                          ),
                          const SizedBox(width: 16),
                          RoundedButton(
                            height: 40,
                            width: 175,
                            colory: kprimaryColourcream,
                            buttonText: 'Share',
                            onPressed: () {
                              print('Share button clicked!');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundedButton(
                                  height: 40,
                                  width: 110,
                                  colory: kprimaryColourcream,
                                  buttonText: 'Description',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Description'),
                                          content: Text(
                                            group.description,
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 16),
                                RoundedButton(
                                  height: 40,
                                  width: 60,
                                  colory: kprimaryColourcream,
                                  buttonText: 'You',
                                  onPressed: () {
                                    print('Event button clicked!');
                                  },
                                ),
                                const SizedBox(width: 16),
                                RoundedButton(
                                  height: 40,
                                  width: 100,
                                  colory: kprimaryColourcream,
                                  buttonText: 'Favorites',
                                  onPressed: () {
                                    print('Modules button clicked!');
                                  },
                                ),
                                const SizedBox(width: 16),
                                RoundedButton(
                                  height: 40,
                                  width: 110,
                                  colory: kprimaryColourcream,
                                  buttonText: 'Materials',
                                  onPressed: () {
                                    print('Files button clicked!');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                     
                    ],
                  ),
                ),
             Expanded(
                   child: Container(
                    height: 500,
                     child: PostListWidget(
                                posts: _posts,
                                deletePost: _deletePost,
                                toggleComments: _toggleComments,
                                addComment: _addComment,
                                toggleCommentLike: _toggleCommentLike,
                                deleteComment: _deleteComment,
                                addReply: _addReply,
                                commentControllers: _commentControllers,
                                replyControllers: _replyControllers,
                                showReplyFields: _showReplyFields,
                              ),
                   ),
                 ),  ],
            );
          }
        },
      ),
                       floatingActionButton: FloatingActionButton(
        onPressed: _showPostDialog,
        backgroundColor: Colors.green,
        child:const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}


// class GroupDetailPage extends StatefulWidget {
//   final int groupId;
//   final String accessToken;

//   GroupDetailPage({required this.groupId, required this.accessToken});

//   @override
//   _GroupDetailPageState createState() => _GroupDetailPageState();
// }

// class _GroupDetailPageState extends State<GroupDetailPage> {
//   late Future<ListGroupsModel> futureGroup;
//   List<Post> _posts = [];
//   Map<String, TextEditingController> _commentControllers = {};
//   Map<String, TextEditingController> _replyControllers = {};
//   Map<String, bool> _showReplyFields = {};

//   @override
//   void initState() {
//     super.initState();
//     futureGroup =
//         GroupService().getGroupById(widget.accessToken, widget.groupId);
//   }

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
//       body: ListView(
//         children:[FutureBuilder<ListGroupsModel>(
//           future: futureGroup,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData) {
//               return Center(child: Text('No data found'));
//             } else {
//               final group = snapshot.data!;
//               return Column(
//                 children: [
//                   const SizedBox(height: 8),
//                   group.image != null
//                       ? Container(
//                           height: 150,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.only(bottomLeft: Radius.circular(20)),
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(group.image!),
//                             ),
//                           ),
//                         )
//                       : Container(
//                           height: 150,
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
//                               color: kprimaryColourcream),
//                           child: Icon(
//                             Icons.group,
//                             size: 50,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(group.title,
//                             style: const TextStyle(
//                                 fontSize: 26, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 3),
//                         Text(group.subject,
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey.shade700)),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                               size: 18,
//                             ),
//                             Text(' ${group.type} group ',
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.grey.shade700)),
//                             Text('(${group.members} members)',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.grey.shade600)),
//                             Spacer(flex: 1),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             RoundedButton(
//                               height: 40,
//                               width: 175,
//                               colory: kprimaryColourGreen,
//                               buttonText: 'Group Setting',
//                               onPressed: () {
//                                 print('Group Setting button clicked!');
//                               },
//                             ),
//                             const SizedBox(width: 16),
//                             RoundedButton(
//                               height: 40,
//                               width: 175,
//                               colory: kprimaryColourcream,
//                                                           buttonText: 'Share',
//                               onPressed: () {
//                                 print('Share button clicked!');
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Container(
//                           height: 50,
//                           child: ListView(
//                             scrollDirection: Axis.horizontal,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   RoundedButton(
//                                     height: 40,
//                                     width: 110,
//                                     colory: kprimaryColourcream,
//                                     buttonText: 'Description',
//                                     onPressed: () {
//                                       showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: const Text('Description'),
//                                             content: Text(
//                                               group.description,
//                                               style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey.shade800,
//                                               ),
//                                             ),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () =>
//                                                     Navigator.pop(context),
//                                                 child: const Text('OK'),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                   ),
//                                   const SizedBox(width: 16),
//                                   RoundedButton(
//                                     height: 40,
//                                     width: 58,
//                                     colory: kprimaryColourcream,
//                                     buttonText: 'you',
//                                     onPressed: () {
//                                       print('you button clicked!');
//                                     },
//                                   ),
//                                   const SizedBox(width: 16),
//                                   RoundedButton(
//                                     height: 40,
//                                     width: 90,
//                                     colory: kprimaryColourcream,
//                                     buttonText: 'favorites',
//                                     onPressed: () {
//                                       print('favorites button clicked!');
//                                     },
//                                   ),
//                                   const SizedBox(width: 16),
//                                   RoundedButton(
//                                     height: 40,
//                                     width: 95,
//                                     colory: kprimaryColourcream,
//                                     buttonText: 'materials',
//                                     onPressed: () {
//                                       print('materials button clicked!');
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8),
                        
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ), ] 
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         backgroundColor: Colors.green,
//         child: Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
















// PostListWidget(
//                           posts: _posts,
//                           deletePost: _deletePost,
//                           toggleComments: _toggleComments,
//                           addComment: _addComment,
//                           toggleCommentLike: _toggleCommentLike,
//                           deleteComment: _deleteComment,
//                           addReply: _addReply,
//                           commentControllers: _commentControllers,
//                           replyControllers: _replyControllers,
//                           showReplyFields: _showReplyFields,
//                         ),

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/Gapi.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/p.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:intl/intl.dart';
// import 'package:like_button/like_button.dart';

// class GroupDetailPage extends StatefulWidget {
//   final int groupId;
//   final String accessToken;

//   GroupDetailPage({required this.groupId, required this.accessToken});

//   @override
//   _GroupDetailPageState createState() => _GroupDetailPageState();
// }

// class _GroupDetailPageState extends State<GroupDetailPage> {
//   late Future<ListGroupsModel> futureGroup;
//   List<Post> _posts = [];
//   Map<String, TextEditingController> _commentControllers = {};
//   Map<String, TextEditingController> _replyControllers = {};
//   Map<String, bool> _showReplyFields = {};

//   @override
//   void initState() {
//     super.initState();
//     futureGroup =
//         GroupService().getGroupById(widget.accessToken, widget.groupId);
//   }

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
//       body: FutureBuilder<ListGroupsModel>(
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
//             return Column(
//               children: [
//               const  SizedBox(height: 8,),
                    
//                     group.image != null
//                         ? Container(
//                             height: 150,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius:const BorderRadius.only(
//                                   bottomLeft: Radius.circular(20)),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(group.image!),
//                               ),
//                             ),
//                           )
//                         : Container(
//                             height: 150,
//                             width: double.infinity,
//                             decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(20)),
//                                 color: kprimaryColourcream
//                                 ),
//                             child: Icon(
//                               Icons.group,
//                               size: 50,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
                
//                 Padding(
//                   padding: const EdgeInsets.only(left:  12.0,right:  12.0,top: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(group.title,
//                           style: const TextStyle(
//                               fontSize: 26, fontWeight: FontWeight.bold)),
//                      const SizedBox(height: 3),
//                       Text(group.subject,
//                           style:  TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey.shade700)),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.lock,
//                             color: Colors.grey,
//                             size: 18,
//                           ),
//                           Text(' ${group.type} group ',
//                               style: TextStyle(
//                                   fontSize: 18, color: Colors.grey.shade700)),
//                           Text('(${group.members} members)',
//                               style: TextStyle(
//                                   fontSize: 14, color: Colors.grey.shade600)),
//                                   Spacer(flex: 1,),
//                                                           ],
//                       ),
                    
//                         const  SizedBox(height: 8,),  Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         RoundedButton(
//                           height: 40,
//                           width: 175,
//                           colory: kprimaryColourGreen,
//                           buttonText: 'Group Setting',
//                           onPressed: () {
//                             print('Group Setting button clicked!');
//                           },
//                         ),
//                        const SizedBox(
//                             width:
//                                 16), 
//                         RoundedButton(
//                           height: 40,
//                           width: 175,
//                           colory: kprimaryColourcream,
//                           buttonText: 'Share',
//                           onPressed: () {
//                             print('Share button clicked!');
//                           },
//                         ),
                        
//                       ],
//                     ),
//                   const  SizedBox(height: 12),
//                     Container(height: 50,
//                       child: ListView(scrollDirection: Axis.horizontal,
//                         children:[Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [ 
//                           RoundedButton(
//                             height: 40,
//                             width: 110,
//                             colory: kprimaryColourcream,
//                             buttonText: 'Description',
//                             onPressed: () {
//                               showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title:const Text('Description'),
//                             content: Text(group.description,style: TextStyle(fontSize: 18,color: Colors.grey.shade800),),
//                             actions: [
//                               TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child:const Text('OK'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                               print('Share button clicked!');
//                             },
//                           ),const SizedBox(
//                               width:
//                                   16), 
//                             RoundedButton(
//                               height: 40,
//                               width: 58,
//                               colory: kprimaryColourcream,
//                               buttonText: 'you',
//                               onPressed: () {
//                                 // Action to perform when Group Setting button is clicked
//                                 print('Group Setting button clicked!');
//                               },
//                             ),
//                           const  SizedBox(
//                                 width:
//                                     16), // Adjust spacing between buttons as needed
//                             RoundedButton(
//                               height: 40,
//                               width: 90,
//                               colory: kprimaryColourcream,
//                               buttonText: 'favorites',
//                               onPressed: () {
//                                 // Action to perform when Another Button is clicked
//                                 print('Another button clicked!');
//                               },
//                             ),
//                           const  SizedBox(
//                                 width:
//                                     16), // Adjust spacing between buttons as needed
//                             RoundedButton(
//                               height: 40,
//                               width: 95,
//                               colory: kprimaryColourcream,
//                               buttonText: 'materials',
//                               onPressed: () {
//                                 // Action to perform when Another Button is clicked
//                                 print('Another button clicked!');
//                                 // Add your custom action here
//                               },
//                             ),
//                           ],
//                         ),] 
//                       ),
//                     ),
                 
                    
//                     Expanded(
//                       child: PostListWidget(
//                               posts: _posts,
//                               deletePost: _deletePost,
//                               toggleComments: _toggleComments,
//                               addComment: _addComment,
//                               toggleCommentLike: _toggleCommentLike,
//                               deleteComment: _deleteComment,
//                               addReply: _addReply,
//                               commentControllers: _commentControllers,
//                               replyControllers: _replyControllers,
//                               showReplyFields: _showReplyFields,
//                             ),
//                     ),
//                     ],
//                   ),
//                 ),
              
//               ],
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPostDialog,
//         // (){},
//         backgroundColor: Colors.green,
//         child:const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }









// //  Container(
//                     //   // height: double.infinity,
//                     //   height: 500,
//                     //    child: Expanded(
//                     //                child: ListView.builder(
//                     //                  itemCount: _posts.length,
//                     //                  itemBuilder: (context, index) {
//                     //                    final post = _posts[index];
//                     //                    return Padding(
//                     //                      padding: const EdgeInsets.all(8.0),
//                     //                      child: Card(
//                     //                        shape: RoundedRectangleBorder(
//                     //     borderRadius: BorderRadius.circular(20.0),
//                     //                        ),
//                     //                        shadowColor: Colors.black,
//                     //                        color: kprimaryColourWhite,
//                     //                        margin: const EdgeInsets.all(8.0),
//                     //                        child: Padding(
//                     //     padding: const EdgeInsets.all(8.0),
//                     //     child: Column(
//                     //       crossAxisAlignment: CrossAxisAlignment.start,
//                     //       children: [
//                     //         Row(
//                     //           children: [
//                     //             CircleAvatar(
//                     //               backgroundImage:
//                     //                   NetworkImage(post.creatorImageUrl),
//                     //             ),
//                     //             const SizedBox(width: 10.0),
//                     //             Column(
//                     //               crossAxisAlignment: CrossAxisAlignment.start,
//                     //               children: [
//                     //                 Text(post.creatorName,
//                     //                     style: const TextStyle(
//                     //                         fontWeight: FontWeight.bold)),
//                     //                 Text(_formatTimestamp(post.createdAt),
//                     //                     style: const TextStyle(
//                     //                         color: Colors.grey, fontSize: 12.0)),
//                     //               ],
//                     //             ),
//                     //             const Spacer(),
//                     //             PopupMenuButton<String>(
//                     //               onSelected: (String value) {
//                     //                 if (value == 'delete') {
//                     //                   showDialog(
//                     //                     context: context,
//                     //                     builder: (context) => AlertDialog(
//                     //                       title: Text('Delete Post'),
//                     //                       content: Text(
//                     //                           'Are you sure you want to delete this post?'),
//                     //                       actions: [
//                     //                         TextButton(
//                     //                           onPressed: () {
//                     //                             Navigator.of(context).pop();
//                     //                           },
//                     //                           child: Text('Cancel'),
//                     //                         ),
//                     //                         TextButton(
//                     //                           onPressed: () {
//                     //                             _deletePost(post.id);
//                     //                             Navigator.of(context).pop();
//                     //                           },
//                     //                           child: Text('Delete'),
//                     //                         ),
//                     //                       ],
//                     //                     ),
//                     //                   );
//                     //                 }
//                     //               },
//                     //               itemBuilder: (BuildContext context) {
//                     //                 return {'delete'}.map((String choice) {
//                     //                   return PopupMenuItem<String>(
//                     //                     value: choice,
//                     //                     child: Text(choice),
//                     //                   );
//                     //                 }).toList();
//                     //               },
//                     //             ),
//                     //           ],
//                     //         ),
//                     //         const SizedBox(height: 10.0),
//                     //         Text(post.content,
//                     //             style: const TextStyle(fontSize: 16.0)),
//                     //         const SizedBox(height: 10.0),
//                     //         Row(
//                     //           children: [
//                     //             LikeButton(
//                     //               circleColor: const CircleColor(
//                     //                   start: Color(0xff00ddff),
//                     //                   end: Color(0xff0099cc)),
//                     //               bubblesColor: const BubblesColor(
//                     //                   dotPrimaryColor: Color(0xff33b5e5),
//                     //                   dotSecondaryColor: Color(0xff0099cc)),
//                     //               likeBuilder: (bool isLiked) {
//                     //                 return Icon(
//                     //                   Icons.thumb_up,
//                     //                   color: isLiked
//                     //                       ? Colors.green.shade700
//                     //                       : Colors.brown.shade200,
//                     //                 );
//                     //               },
//                     //               likeCount: post.likes,
//                     //             ),
//                     //             Text(
//                     //               ' Likes',
//                     //               style: TextStyle(
//                     //                 color: Colors.brown.shade200,
//                     //               ),
//                     //             ),
//                     //             const Spacer(flex: 1),
//                     //             LikeButton(
//                     //               circleColor: const CircleColor(
//                     //                   start: Color(0xff00ddff),
//                     //                   end: Color(0xff0099cc)),
//                     //               bubblesColor: const BubblesColor(
//                     //                   dotPrimaryColor: Color(0xff33b5e5),
//                     //                   dotSecondaryColor: Color(0xff0099cc)),
//                     //               likeBuilder: (bool isLiked) {
//                     //                 return Icon(
//                     //                   Icons.thumb_down,
//                     //                   color: isLiked
//                     //                       ? Colors.green.shade700
//                     //                       : Colors.brown.shade200,
//                     //                 );
//                     //               },
//                     //               likeCount: post.dislikes,
//                     //             ),
//                     //             Text(
//                     //               ' Dislikes',
//                     //               style: TextStyle(
//                     //                 color: Colors.brown.shade200,
//                     //               ),
//                     //             ),
//                     //             const Spacer(flex: 1),
//                     //             IconButton(
//                     //               onPressed: () {
//                     //                 _toggleComments(post.id);
//                     //               },
//                     //               icon: Icon(
//                     //                 Icons.comment,
//                     //                 color: Colors.brown.shade200,
//                     //               ),
//                     //             ),
//                     //             Text(
//                     //               'Comments',
//                     //               style: TextStyle(
//                     //                 color: Colors.brown.shade200,
//                     //               ),
//                     //             ),
//                     //             const Spacer(flex: 1),
//                     //             LikeButton(
//                     //               likeBuilder: (bool isLiked) {
//                     //                 return Icon(
//                     //                   Icons.favorite,
//                     //                   color: isLiked
//                     //                       ? Colors.red.shade900
//                     //                       : Colors.brown.shade200,
//                     //                 );
//                     //               },
//                     //             ),
//                     //           ],
//                     //         ),
//                     //         const SizedBox(height: 10.0),
//                     //         if (post.showComments) ...[
//                     //           const Divider(),
//                     //           Row(
//                     //             children: [
//                     //               Expanded(
//                     //                 child: TextFormField(
//                     //                   controller: _commentControllers[post.id],
//                     //                   decoration: InputDecoration(
//                     //                     hintText: 'Add a comment',
//                     //                     border: OutlineInputBorder(
//                     //                         borderRadius:
//                     //                             BorderRadius.circular(25)),
//                     //                   ),
//                     //                   onFieldSubmitted: (text) {
//                     //                     if (text.isNotEmpty) {
//                     //                       _addComment(post.id, text);
//                     //                       _commentControllers[post.id]?.clear();
//                     //                     }
//                     //                   },
//                     //                 ),
//                     //               ),
//                     //               IconButton(
//                     //                 icon: Icon(
//                     //                   Icons.send,
//                     //                   color: Colors.brown.shade200,
//                     //                 ),
//                     //                 onPressed: () {
//                     //                   if (_commentControllers[post.id]
//                     //                           ?.text
//                     //                           .isNotEmpty ??
//                     //                       false) {
//                     //                     _addComment(post.id,
//                     //                         _commentControllers[post.id]!.text);
//                     //                     _commentControllers[post.id]?.clear();
//                     //                   }
//                     //                 },
//                     //               ),
//                     //             ],
//                     //           ),
//                     //           ListView.builder(
//                     //             shrinkWrap: true,
//                     //             physics: const NeverScrollableScrollPhysics(),
//                     //             itemCount: post.comments.length,
//                     //             itemBuilder: (context, index) {
//                     //               final comment = post.comments[index];
//                     //               return Padding(
//                     //                 padding: const EdgeInsets.all(8.0),
//                     //                 child: Card(
//                     //                   shape: RoundedRectangleBorder(
//                     //                     borderRadius: BorderRadius.circular(35.0),
//                     //                   ),
//                     //                   color: Colors.white,
//                     //                   margin: const EdgeInsets.symmetric(
//                     //                       vertical: 4.0, horizontal: 8.0),
//                     //                   child: Padding(
//                     //                     padding: const EdgeInsets.all(8.0),
//                     //                     child: Column(
//                     //                       crossAxisAlignment:
//                     //                           CrossAxisAlignment.start,
//                     //                       children: [
//                     //                         Row(
//                     //                           children: [
//                     //                             CircleAvatar(
//                     //                               radius: 15,
//                     //                               backgroundImage: NetworkImage(
//                     //                                   comment.creatorImageUrl),
//                     //                             ),
//                     //                             const SizedBox(width: 10.0),
//                     //                             Column(
//                     //                               crossAxisAlignment:
//                     //                                   CrossAxisAlignment.start,
//                     //                               children: [
//                     //                                 Text(comment.creatorName,
//                     //                                     style: const TextStyle(
//                     //                                         fontWeight:
//                     //                                             FontWeight.bold)),
//                     //                                 Text(
//                     //                                     _formatTimestamp(
//                     //                                         comment.createdAt),
//                     //                                     style: const TextStyle(
//                     //                                         color: Colors.grey,
//                     //                                         fontSize: 12.0)),
//                     //                                 Text(comment.content),
//                     //                               ],
//                     //                             ),
//                     //                             const Spacer(),
//                     //                             LikeButton(
//                     //                               circleColor: const CircleColor(
//                     //                                   start: Color(0xff00ddff),
//                     //                                   end: Color(0xff0099cc)),
//                     //                               bubblesColor:
//                     //                                   const BubblesColor(
//                     //                                       dotPrimaryColor:
//                     //                                           Color(0xff33b5e5),
//                     //                                       dotSecondaryColor:
//                     //                                           Color(0xff0099cc)),
//                     //                               likeBuilder: (bool isLiked) {
//                     //                                 return Icon(
//                     //                                   Icons.thumb_up,
//                     //                                   color: isLiked
//                     //                                       ? Colors.green.shade700
//                     //                                       : Colors.brown.shade200,
//                     //                                   size: 18,
//                     //                                 );
//                     //                               },
//                     //                               likeCount: comment.likes,
//                     //                               onTap: (isLiked) async {
//                     //                                 _toggleCommentLike(post.id,
//                     //                                     comment.id, true);
//                     //                                 return !isLiked;
//                     //                               },
//                     //                             ),
//                     //                             const SizedBox(width: 8.0),
//                     //                             LikeButton(
//                     //                               circleColor: const CircleColor(
//                     //                                   start: Color(0xff00ddff),
//                     //                                   end: Color(0xff0099cc)),
//                     //                               bubblesColor:
//                     //                                   const BubblesColor(
//                     //                                       dotPrimaryColor:
//                     //                                           Color(0xff33b5e5),
//                     //                                       dotSecondaryColor:
//                     //                                           Color(0xff0099cc)),
//                     //                               likeBuilder: (bool isLiked) {
//                     //                                 return Icon(
//                     //                                   Icons.thumb_down,
//                     //                                   color: isLiked
//                     //                                       ? Colors.green.shade700
//                     //                                       : Colors.brown.shade200,
//                     //                                   size: 18,
//                     //                                 );
//                     //                               },
//                     //                               likeCount: comment.dislikes,
//                     //                               onTap: (isLiked) async {
//                     //                                 _toggleCommentLike(post.id,
//                     //                                     comment.id, false);
//                     //                                 return !isLiked;
//                     //                               },
//                     //                             ),
//                     //                             IconButton(
//                     //                               onPressed: () {
//                     //                                 _deleteComment(
//                     //                                     post.id, comment.id);
//                     //                               },
//                     //                               icon: Icon(
//                     //                                 Icons.delete,
//                     //                                 color: Colors.brown.shade200,
//                     //                                 size: 18,
//                     //                               ),
//                     //                             ),
//                     //                           ],
//                     //                         ),
//                     //                         Column(
//                     //                           crossAxisAlignment:
//                     //                               CrossAxisAlignment.start,
//                     //                           children: [
//                     //                             Row(
//                     //                               children: [
//                     //                                 IconButton(
//                     //                                   icon: Icon(
//                     //                                     Icons.reply,
//                     //                                     color:
//                     //                                         Colors.brown.shade200,
//                     //                                     size: 18,
//                     //                                   ),
//                     //                                   onPressed: () {
//                     //                                     setState(() {
//                     //                                       _showReplyFields[
//                     //                                               comment.id] =
//                     //                                           !(_showReplyFields[
//                     //                                                   comment
//                     //                                                       .id] ??
//                     //                                               false);
//                     //                                     });
//                     //                                   },
//                     //                                 ),
//                     //                                 const Text('Reply'),
//                     //                               ],
//                     //                             ),
//                     //                             if (_showReplyFields[
//                     //                                     comment.id] ??
//                     //                                 false)
//                     //                               Row(
//                     //                                 children: [
//                     //                                   Expanded(
//                     //                                     child: TextFormField(
//                     //                                       controller:
//                     //                                           _replyControllers[
//                     //                                               comment.id],
//                     //                                       decoration:
//                     //                                           InputDecoration(
//                     //                                         hintText:
//                     //                                             'Add a reply',
//                     //                                         border: OutlineInputBorder(
//                     //                                             borderRadius:
//                     //                                                 BorderRadius
//                     //                                                     .circular(
//                     //                                                         25)),
//                     //                                       ),
//                     //                                       onFieldSubmitted:
//                     //                                           (text) {
//                     //                                         if (text.isNotEmpty) {
//                     //                                           _addReply(
//                     //                                               post.id,
//                     //                                               comment.id,
//                     //                                               text);
//                     //                                           _replyControllers[
//                     //                                                   comment.id]
//                     //                                               ?.clear();
//                     //                                         } //dy 48ala 3adi li t7t 3nd l icon li m4 48ala
//                     //                                       },
//                     //                                     ),
//                     //                                   ),
                                            
//                     //                                   IconButton(
//                     //                                     icon: Icon(
//                     //                                       Icons.send,
//                     //                                       color: Colors
//                     //                                           .brown.shade200,
//                     //                                     ),
//                     //                                     onPressed: () {
//                     //                                       // Ensure _replyControllers[comment.id] exists and its text is not empty
//                     //                                       if (_replyControllers[
//                     //                                                       comment
//                     //                                                           .id]
//                     //                                                   ?.text
//                     //                                                   .isNotEmpty ??
//                     //                                               false
                                                             
//                     //                                           ) {
//                     //                                         String replyText =
//                     //                                             _replyControllers[
//                     //                                                     comment
//                     //                                                         .id]!
//                     //                                                 .text;
//                     //                                         _addReply(
//                     //                                             post.id,
//                     //                                             comment.id,
//                     //                                             replyText);
//                     //                                         _replyControllers[
//                     //                                                 comment.id]
//                     //                                             ?.clear();
//                     //                                         // Add focus removal logic if needed
//                     //                                       } else {
//                     //                                         // Log or handle the case where reply text is empty or controller is null
//                     //                                         print(
//                     //                                             "Reply text is empty or _replyControllers[comment.id] is null.");
//                     //                                         print(
//                     //                                             "hi ${_replyControllers[comment.id]}");
//                     //                                       }
//                     //                                     },
//                     //                                   ),
//                     //                                 ],
//                     //                               ),
//                     //                             ListView.builder(
//                     //                               shrinkWrap: true,
//                     //                               physics:
//                     //                                   const NeverScrollableScrollPhysics(),
//                     //                               itemCount:
//                     //                                   comment.replies.length,
//                     //                               itemBuilder:
//                     //                                   (context, replyIndex) {
//                     //                                 final reply = comment
//                     //                                     .replies[replyIndex];
//                     //                                 return Padding(
//                     //                                   padding:
//                     //                                       const EdgeInsets.all(
//                     //                                           8.0),
//                     //                                   child: Row(
//                     //                                     crossAxisAlignment:
//                     //                                         CrossAxisAlignment
//                     //                                             .start,
//                     //                                     children: [
//                     //                                       CircleAvatar(
//                     //                                         radius: 12,
//                     //                                         backgroundImage:
//                     //                                             NetworkImage(reply
//                     //                                                 .creatorImageUrl),
//                     //                                       ),
//                     //                                       const SizedBox(
//                     //                                           width: 10.0),
//                     //                                       Column(
//                     //                                         crossAxisAlignment:
//                     //                                             CrossAxisAlignment
//                     //                                                 .start,
//                     //                                         children: [
//                     //                                           Text(
//                     //                                               reply
//                     //                                                   .creatorName,
//                     //                                               style: const TextStyle(
//                     //                                                   fontWeight:
//                     //                                                       FontWeight
//                     //                                                           .bold)),
//                     //                                           Text(
//                     //                                               _formatTimestamp(
//                     //                                                   reply
//                     //                                                       .createdAt),
//                     //                                               style: const TextStyle(
//                     //                                                   color: Colors
//                     //                                                       .grey,
//                     //                                                   fontSize:
//                     //                                                       12.0)),
//                     //                                           Text(reply.content),
//                     //                                         ],
//                     //                                       ),
//                     //                                     ],
//                     //                                   ),
//                     //                                 );
//                     //                               },
//                     //                             ),
//                     //                           ],
//                     //                         ),
//                     //                       ],
//                     //                     ),
//                     //                   ),
//                     //                 ),
//                     //               );
//                     //             },
//                     //           ),
//                     //         ],
//                     //       ],
//                     //     ),
//                     //                        ),
//                     //                      ),
//                     //                    );
//                     //                  },
//                     //                ),
//                     //              ),
//                     //  ),