import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/CommentsProvider.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/cmodel.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final int groupId;
  final int postId;

  CommentsScreen({required this.groupId, required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CommentsProvider>(context, listen: false)
        .fetchComments(widget.groupId, widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CommentsProvider>(
              builder: (context, commentsProvider, _) {
                if (commentsProvider.comments.isEmpty) {
                  return const Center(child: Text('No comments yet.'));
                }
                return ListView.builder(
                  itemCount: commentsProvider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentsProvider.comments[index];
                    return CommentItem(
                      groupId: widget.groupId,
                      postId: widget.postId,
                      comment: comment,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: kprimaryColourcream,
                  ),
                  onPressed: () async {
                    final value = _commentController.text;
                    if (value.isNotEmpty) {
                      await Provider.of<CommentsProvider>(context,
                              listen: false)
                          .postComment(widget.groupId, widget.postId, value);
                      await Provider.of<CommentsProvider>(context,
                              listen: false)
                          .fetchComments(widget.groupId, widget.postId);
                      _commentController.clear();
                    }
                  },
                ),
                labelText: 'Add a comment',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItem extends StatefulWidget {
  final int groupId;
  final int postId;
  final Comment comment;

  CommentItem(
      {required this.groupId, required this.postId, required this.comment});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _showReplies = false;
  final TextEditingController _replyController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            children: [
              widget.comment.user.image != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.comment.user.image!),
                    )
                  : CircleAvatar(
                      backgroundColor: kprimaryColourcream,
                      child: Text(widget.comment.user.username[0]),
                    ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: kprimaryColourWhite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        Text('     ${widget.comment.user.username}'),
                        Row(
                          children: [
                            Text('     ${widget.comment.description}'),
                            const Spacer(
                              flex: 1,
                            ),
                            IconButton(
                              icon: Icon(_showReplies
                                  ? Icons.expand_less
                                  : Icons.expand_more),
                              onPressed: () {
                                setState(() {
                                  _showReplies = !_showReplies;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_showReplies) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.comment.replies.length,
              itemBuilder: (context, replyIndex) {
                final reply = widget.comment.replies[replyIndex];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    children: [
                      reply.user.image != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(reply.user.image!),
                            )
                          : CircleAvatar(
                              backgroundColor: kprimaryColourcream,
                              child: Text(reply.user.username[0]),
                            ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          // color: kprimaryColourWhite,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('  ${reply.user.username}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("  ${reply.description}"),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                   
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 8, bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: kprimaryColourcream,
                    ),
                    onPressed: () async {
                      final value = _replyController.text;
                      if (value.isNotEmpty) {
                        await Provider.of<CommentsProvider>(context,
                                listen: false)
                            .postReply(widget.groupId, widget.postId,
                                widget.comment.id, value);
                        _replyController.clear();
                      }
                    },
                  ),
                  labelText: 'Add a reply',
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// class CommentsScreen extends StatefulWidget {
//   final int groupId;
//   final int postId;

//   CommentsScreen({required this.groupId, required this.postId});

//   @override
//   _CommentsScreenState createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<CommentsProvider>(context, listen: false)
//         .fetchComments(widget.groupId, widget.postId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Comments')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer<CommentsProvider>(
//               builder: (context, commentsProvider, _) {
//                 if (commentsProvider.comments.isEmpty) {
//                   return Center(child: Text('No comments yet.'));
//                 }
//                 return ListView.builder(
//                   itemCount: commentsProvider.comments.length,
//                   itemBuilder: (context, index) {
//                     final comment = commentsProvider.comments[index];
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           title: Text(comment.description),
//                           subtitle: Text('by ${comment.user.username}'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16.0),
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: comment.replies.length,
//                             itemBuilder: (context, replyIndex) {
//                               final reply = comment.replies[replyIndex];
//                               return ListTile(
//                                 title: Text(reply.description),
//                                 subtitle: Text('by ${reply.user.username}'),
//                               );
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
//                           child: TextField(
//                             decoration: InputDecoration(
//                               labelText: 'Add a reply',
//                               border: OutlineInputBorder(),
//                             ),
//                             onSubmitted: (value) async {
//                               if (value.isNotEmpty) {
//                                 await Provider.of<CommentsProvider>(context, listen: false)
//                                     .postReply(widget.groupId, widget.postId, comment.id, value);
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Add a comment',
//                 border: OutlineInputBorder(),
//               ),
//               onSubmitted: (value) async {
//                 if (value.isNotEmpty) {
//                   await Provider.of<CommentsProvider>(context, listen: false)
//                       .postComment(widget.groupId, widget.postId, value);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class CommentsScreen extends StatefulWidget {
// //   final int groupId;
// //   final int postId;

// //   CommentsScreen({required this.groupId, required this.postId});

// //   @override
// //   _CommentsScreenState createState() => _CommentsScreenState();
// // }

// // class _CommentsScreenState extends State<CommentsScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Provider.of<CommentsProvider>(context, listen: false)
// //         .getComments(widget.groupId, widget.postId);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Comments')),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: Consumer<CommentsProvider>(
// //               builder: (context, commentsProvider, _) {
// //                 if (commentsProvider.comments.isEmpty) {
// //                   return Center(child: Text('No comments yet.'));
// //                 }
// //                 return ListView.builder(
// //                   itemCount: commentsProvider.comments.length,
// //                   itemBuilder: (context, index) {
// //                     final comment = commentsProvider.comments[index];
// //                     return Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ListTile(
// //                           title: Text(comment.description),
// //                           subtitle: Text('by ${comment.user.username}'),
// //                         ),
// //                         Padding(
// //                           padding: const EdgeInsets.only(left: 16.0),
// //                           child: ListView.builder(
// //                             shrinkWrap: true,
// //                             physics: NeverScrollableScrollPhysics(),
// //                             itemCount: comment.replies.length,
// //                             itemBuilder: (context, replyIndex) {
// //                               final reply = comment.replies[replyIndex];
// //                               return ListTile(
// //                                 title: Text(reply.description),
// //                                 subtitle: Text('by ${reply.user.username}'),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Add a comment',
// //                 border: OutlineInputBorder(),
// //               ),
// //               onSubmitted: (value) async {
// //                 if (value.isNotEmpty) {
// //                   await Provider.of<CommentsProvider>(context, listen: false)
// //                       .postComment(widget.groupId, widget.postId, value);
// //                   await Provider.of<CommentsProvider>(context, listen: false)
// //                       .getComments(widget.groupId, widget.postId); // Fetch comments again to reload the page
// //                 }
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// // ///////////////workingggggggggggggggggggggggg
// // // class CommentsScreen extends StatefulWidget {
// // //   final int groupId;
// // //   final int postId;

// // //   CommentsScreen({required this.groupId, required this.postId});

// // //   @override
// // //   _CommentsScreenState createState() => _CommentsScreenState();
// // // }

// // // class _CommentsScreenState extends State<CommentsScreen> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     Provider.of<CommentsProvider>(context, listen: false)
// // //         .getComments(widget.groupId, widget.postId);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Comments')),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: Consumer<CommentsProvider>(
// // //               builder: (context, commentsProvider, _) {
// // //                 if (commentsProvider.comments.isEmpty) {
// // //                   return Center(child: Text('No comments yet.'));
// // //                 }
// // //                 return ListView.builder(
// // //                   itemCount: commentsProvider.comments.length,
// // //                   itemBuilder: (context, index) {
// // //                     final comment = commentsProvider.comments[index];
// // //                     return ListTile(
// // //                       title: Text(comment.description),
// // //                       subtitle: Text('by ${comment.user.username}'),
// // //                     );
// // //                   },
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: TextField(
// // //               decoration: InputDecoration(
// // //                 labelText: 'Add a comment',
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //               onSubmitted: (value) async {
// // //                 if (value.isNotEmpty) {
// // //                   await Provider.of<CommentsProvider>(context, listen: false)
// // //                       .postComment(widget.groupId, widget.postId, value);
// // //                   await Provider.of<CommentsProvider>(context, listen: false)
// // //                       .getComments(widget.groupId, widget.postId); // Fetch comments again to reload the page
// // //                 }
// // //               },
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // class CommentsScreen extends StatefulWidget {
// // // //   final int groupId;
// // // //   final int postId;

// // // //   CommentsScreen({required this.groupId, required this.postId});

// // // //   @override
// // // //   _CommentsScreenState createState() => _CommentsScreenState();
// // // // }

// // // // class _CommentsScreenState extends State<CommentsScreen> {
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     Provider.of<CommentsProvider>(context, listen: false)
// // // //         .fetchComments(widget.groupId, widget.postId);
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text('Comments')),
// // // //       body: Column(
// // // //         children: [
// // // //           Expanded(
// // // //             child: Consumer<CommentsProvider>(
// // // //               builder: (context, commentsProvider, _) {
// // // //                 if (commentsProvider.comments.isEmpty) {
// // // //                   return Center(child: Text('No comments yet.'));
// // // //                 }
// // // //                 return ListView.builder(
// // // //                   itemCount: commentsProvider.comments.length,
// // // //                   itemBuilder: (context, index) {
// // // //                     final comment = commentsProvider.comments[index];
// // // //                     return ListTile(
// // // //                       title: Text(comment.description),
// // // //                       subtitle: Text('by ${comment.user.username}'),
// // // //                     );
// // // //                   },
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(8.0),
// // // //             child: TextField(
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'Add a comment',
// // // //                 border: OutlineInputBorder(),
// // // //               ),
// // // //               onSubmitted: (value) {
// // // //                 if (value.isNotEmpty) {
// // // //                   Provider.of<CommentsProvider>(context, listen: false)
// // // //                       .postComment(widget.groupId, widget.postId, value);
// // // //                 }
// // // //               },
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // //import 'comments_provider.dart';
// // // // // class CommentsScreen extends StatefulWidget {
// // // // //   final int groupId;
// // // // //   final int postId;

// // // // //   CommentsScreen({required this.groupId, required this.postId});

// // // // //   @override
// // // // //   _CommentsScreenState createState() => _CommentsScreenState();
// // // // // }

// // // // // class _CommentsScreenState extends State<CommentsScreen> {
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     Provider.of<CommentsProvider>(context, listen: false)
// // // // //         .fetchComments(widget.groupId, widget.postId);
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: Text('Comments')),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           Expanded(
// // // // //             child: Consumer<CommentsProvider>(
// // // // //               builder: (context, commentsProvider, _) {
// // // // //                 if (commentsProvider.comments.isEmpty) {
// // // // //                   return Center(child: Text('No comments yet.'));
// // // // //                 }
// // // // //                 return ListView.builder(
// // // // //                   itemCount: commentsProvider.comments.length,
// // // // //                   itemBuilder: (context, index) {
// // // // //                     final comment = commentsProvider.comments[index];
// // // // //                     return ListTile(
// // // // //                       title: Text(comment.description),
// // // // //                       subtitle: Text('by ${comment.user.username}'),
// // // // //                     );
// // // // //                   },
// // // // //                 );
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(8.0),
// // // // //             child: TextField(
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Add a comment',
// // // // //                 border: OutlineInputBorder(),
// // // // //               ),
// // // // //               onSubmitted: (value) {
// // // // //                 if (value.isNotEmpty) {
// // // // //                   Provider.of<CommentsProvider>(context, listen: false)
// // // // //                       .postComment(widget.groupId, widget.postId, value);
// // // // //                 }
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }



// // // // // // class CommentsScreen extends StatelessWidget {
// // // // // //   final int groupId;
// // // // // //   final int postId;

// // // // // //   CommentsScreen({required this.groupId, required this.postId});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(title: Text('Comments')),
// // // // // //       body: Column(
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             child: Consumer<CommentsProvider>(
// // // // // //               builder: (context, commentsProvider, child) {
// // // // // //         //         if (commentsProvider.isLoading) {
// // // // // //         //   return const Center(child: CircularProgressIndicator());
// // // // // //         // }

// // // // // //         if (commentsProvider.comments.isEmpty) {
// // // // // //           return const Center(child: Text('No comments available'));
// // // // // //         }
// // // // // //                 return ListView.builder(
// // // // // //                   itemCount: commentsProvider.comments.length,
// // // // // //                   itemBuilder: (context, index) {
// // // // // //                     final comment = commentsProvider.comments[index];
// // // // // //                     return ListTile(
// // // // // //                       title: Text(comment.description),
// // // // // //                       subtitle: Text('by ${comment.user.username}'),
// // // // // //                     );
// // // // // //                   },
// // // // // //                 );
// // // // // //               },
// // // // // //             ),
// // // // // //           ),
// // // // // //           Padding(
// // // // // //             padding: const EdgeInsets.all(8.0),
// // // // // //             child: TextField(
// // // // // //               decoration: InputDecoration(
// // // // // //                 labelText: 'Add a comment',
// // // // // //                 border: OutlineInputBorder(),
// // // // // //               ),
// // // // // //               onSubmitted: (value) {
// // // // // //                 if (value.isNotEmpty) {
// // // // // //                   Provider.of<CommentsProvider>(context, listen: false)
// // // // // //                       .postComment(groupId, postId, value);
// // // // // //                 }
// // // // // //               },
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }