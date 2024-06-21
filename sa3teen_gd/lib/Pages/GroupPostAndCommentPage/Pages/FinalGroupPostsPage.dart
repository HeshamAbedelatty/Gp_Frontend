import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:like_button/like_button.dart';
import 'package:intl/intl.dart';

class GroupPage extends StatefulWidget {
  final int id;
  final String groupName;
  final String groupImageUrl;
  final List<String> members;
  final String groupState;

  GroupPage(
      {required this.id,
      required this.groupName,
      required this.groupImageUrl,
      required this.members,
      required this.groupState});

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<Post> _posts = [];
  Map<String, TextEditingController> _commentControllers = {};
  Map<String, TextEditingController> _replyControllers = {};
  Map<String, bool> _showReplyFields = {};

  @override
  void initState() {
    super.initState();
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
              creatorImageUrl:
                  'https://example.com/commenter_profile_picture.jpg',
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
                creatorImageUrl:
                    'https://example.com/replier_profile_picture.jpg',
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

  void _showPostDialog() {
    final TextEditingController _postController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: TextField(
            controller: _postController,
            decoration:
                const InputDecoration(hintText: 'What\'s on your mind?'),
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

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
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
      // AppBar(
      //   title: Text(widget.groupName),
      // ),

      body: CustomScrollView(
        slivers: [
          // SizedBox(height: 10,),
          const SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 10,
                ),
              ),
            ),
          ),
          SliverAppBar(
            expandedHeight: 160.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  // top: Radius.circular(15.0),
                  bottom: Radius.circular(20.0),
                ),
                child: Image.asset(
                    'lib/assets/icons/Web_Development_Banner_Image_0e476d1ab6.jpg',
                    fit: BoxFit.cover
                    // clipBehavior: Clip.hardEdge
                    ),
                // child: Image.network(
                //   widget.groupImageUrl,
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            pinned: false,
            title: Text(
              widget.groupName,
              style: TextStyle(color: kprimaryColourWhite),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    // Text(widget.groupState);
                    Text(
                      'Members',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: widget.members.map((member) {
                      return const CircleAvatar(
                        radius: 17,
                        backgroundColor: Color.fromARGB(255, 198, 244, 224),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 14),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          height: 40,
                          width: 175,
                          colory: kprimaryColourGreen,
                          buttonText: 'Group Setting',
                          onPressed: () {
                            // Action to perform when Group Setting button is clicked
                            print('Group Setting button clicked!');
                          },
                        ),
                        SizedBox(
                            width:
                                16), // Adjust spacing between buttons as needed
                        RoundedButton(
                          height: 40,
                          width: 175,
                          colory: kprimaryColourcream,
                          buttonText: 'Share',
                          onPressed: () {
                            // Action to perform when Share Button is clicked
                            print('Share button clicked!');
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          height: 40,
                          width: 100,
                          colory: kprimaryColourcream,
                          buttonText: 'you',
                          onPressed: () {
                            // Action to perform when Group Setting button is clicked
                            print('Group Setting button clicked!');
                          },
                        ),
                        SizedBox(
                            width:
                                16), // Adjust spacing between buttons as needed
                        RoundedButton(
                          height: 40,
                          width: 100,
                          colory: kprimaryColourcream,
                          buttonText: 'favorites',
                          onPressed: () {
                            // Action to perform when Another Button is clicked
                            print('Another button clicked!');
                          },
                        ),
                        SizedBox(
                            width:
                                16), // Adjust spacing between buttons as needed
                        RoundedButton(
                          height: 40,
                          width: 100,
                          colory: kprimaryColourcream,
                          buttonText: 'materials',
                          onPressed: () {
                            // Action to perform when Another Button is clicked
                            print('Another button clicked!');
                            // Add your custom action here
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                )),
          ),
          //  SliverToBoxAdapter(
          //   child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           RoundedButton(
          //             height: 40,
          //             width: 100,
          //             colory: kprimaryColourcream,
          //             buttonText: 'you',
          //             onPressed: () {
          //               // Action to perform when Group Setting button is clicked
          //               print('Group Setting button clicked!');
          //               // Add your custom action here
          //             },
          //           ),
          //           SizedBox(
          //               width: 16), // Adjust spacing between buttons as needed
          //           RoundedButton(height: 40,
          //             width: 100,
          //             colory: kprimaryColourcream,
          //             buttonText: 'favorites',
          //             onPressed: () {
          //               // Action to perform when Another Button is clicked
          //               print('Another button clicked!');
          //               // Add your custom action here
          //             },
          //           ),
          //           SizedBox(
          //               width: 16), // Adjust spacing between buttons as needed
          //           RoundedButton(height: 40,
          //             width: 100,
          //             colory: kprimaryColourcream,
          //             buttonText: 'materials',
          //             onPressed: () {
          //               // Action to perform when Another Button is clicked
          //               print('Another button clicked!');
          //               // Add your custom action here
          //             },
          //           ),
          //           // Add more RoundedButton widgets as needed
          //         ],
          //       )),
          // ),

//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
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
//                               const Spacer(),
//                               PopupMenuButton<String>(
//                                 onSelected: (String value) {
//                                   if (value == 'delete') {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => AlertDialog(
//                                         title: const Text('Delete Post'),
//                                         content: const Text(
//                                             'Are you sure you want to delete this post?'),
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('Cancel'),
//                                           ),
//                                           TextButton(
//                                             onPressed: () {
//                                               _deletePost(post.id);
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: const Text('Delete'),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 itemBuilder: (BuildContext context) {
//                                   return {'delete'}.map((String choice) {
//                                     return PopupMenuItem<String>(
//                                       value: choice,
//                                       child: Text(choice),
//                                     );
//                                   }).toList();
//                                 },
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
//                                     dotPrimaryColor: Color(0xff33b5e5),
//                                     dotSecondaryColor: Color(0xff0099cc)),
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
//                                     dotPrimaryColor: Color(0xff33b5e5),
//                                     dotSecondaryColor: Color(0xff0099cc)),
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
//                                       borderRadius: BorderRadius.circular(35.0),
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
//                                               const Spacer(),
//                                               LikeButton(
//                                                 circleColor: const CircleColor(
//                                                     start: Color(0xff00ddff),
//                                                     end: Color(0xff0099cc)),
//                                                 bubblesColor:
//                                                     const BubblesColor(
//                                                         dotPrimaryColor:
//                                                             Color(0xff33b5e5),
//                                                         dotSecondaryColor:
//                                                             Color(0xff0099cc)),
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
//                                                         dotPrimaryColor:
//                                                             Color(0xff33b5e5),
//                                                         dotSecondaryColor:
//                                                             Color(0xff0099cc)),
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
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   IconButton(
//                                                     icon: Icon(
//                                                       Icons.reply,
//                                                       color:
//                                                           Colors.brown.shade200,
//                                                       size: 18,
//                                                     ),
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         _showReplyFields[
//                                                                 comment.id] =
//                                                             !(_showReplyFields[
//                                                                     comment
//                                                                         .id] ??
//                                                                 false);
//                                                       });
//                                                     },
//                                                   ),
//                                                   const Text('Reply'),
//                                                 ],
//                                               ),
//                                               if (_showReplyFields[
//                                                       comment.id] ??
//                                                   false)
//                                                 Row(
//                                                   children: [
//                                                     Expanded(
//                                                       child: TextFormField(
//                                                         controller:
//                                                             _replyControllers[
//                                                                 comment.id],
//                                                         decoration:
//                                                             InputDecoration(
//                                                           hintText:
//                                                               'Add a reply',
//                                                           border: OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           25)),
//                                                         ),
//                                                         onFieldSubmitted:
//                                                             (text) {
//                                                           if (text.isNotEmpty) {
//                                                             _addReply(
//                                                                 post.id,
//                                                                 comment.id,
//                                                                 text);
//                                                             _replyControllers[
//                                                                     comment.id]
//                                                                 ?.clear();
//                                                           } //dy 48ala 3adi li t7t 3nd l icon li m4 48ala
//                                                         },
//                                                       ),
//                                                     ),
//                                                     IconButton(
//                                                       icon: Icon(
//                                                         Icons.send,
//                                                         color: Colors
//                                                             .brown.shade200,
//                                                       ),
//                                                       onPressed: () {
//                                                         // Ensure _replyControllers[comment.id] exists and its text is not empty
//                                                         if (_replyControllers[
//                                                                     comment.id]
//                                                                 ?.text
//                                                                 .isNotEmpty ??
//                                                             false) {
//                                                           String replyText =
//                                                               _replyControllers[
//                                                                       comment
//                                                                           .id]!
//                                                                   .text;
//                                                           _addReply(
//                                                               post.id,
//                                                               comment.id,
//                                                               replyText);
//                                                           _replyControllers[
//                                                                   comment.id]
//                                                               ?.clear();
//                                                           // Add focus removal logic if needed
//                                                         } else {
//                                                           // Log or handle the case where reply text is empty or controller is null
//                                                           print(
//                                                               "Reply text is empty or _replyControllers[comment.id] is null.");
//                                                           print(
//                                                               "hi ${_replyControllers[comment.id]}");
//                                                         }
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ListView.builder(
//                                                 shrinkWrap: true,
//                                                 physics:
//                                                     const NeverScrollableScrollPhysics(),
//                                                 itemCount:
//                                                     comment.replies.length,
//                                                 itemBuilder:
//                                                     (context, replyIndex) {
//                                                   final reply = comment
//                                                       .replies[replyIndex];
//                                                   return Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         CircleAvatar(
//                                                           radius: 12,
//                                                           backgroundImage:
//                                                               NetworkImage(reply
//                                                                   .creatorImageUrl),
//                                                         ),
//                                                         const SizedBox(
//                                                             width: 10.0),
//                                                         Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                                 reply
//                                                                     .creatorName,
//                                                                 style: const TextStyle(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold)),
//                                                             Text(
//                                                                 _formatTimestamp(
//                                                                     reply
//                                                                         .createdAt),
//                                                                 style: const TextStyle(
//                                                                     color: Colors
//                                                                         .grey,
//                                                                     fontSize:
//                                                                         12.0)),
//                                                             Text(reply.content),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   );
//                                                 },
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
//         backgroundColor: kprimaryColourGreen,
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
          SliverPadding(
            padding: const EdgeInsets.all(10),
            // only(left:10,right: 10,bottom: 30,top: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < _posts.length) {
                    // Check index range
                    final post = _posts[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      shadowColor: Colors.black,
                      color: kprimaryColourWhite,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(post.creatorImageUrl),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.creatorName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(_formatTimestamp(post.createdAt),
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0)),
                                  ],
                                ),
                                const Spacer(),
                                PopupMenuButton<String>(
                                  onSelected: (String value) {
                                    if (value == 'delete') {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Delete Post'),
                                          content: Text(
                                              'Are you sure you want to delete this post?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _deletePost(post.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return {'delete'}.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(post.content,
                                style: const TextStyle(fontSize: 16.0)),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                LikeButton(
                                  circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc)),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.thumb_up,
                                      color: isLiked
                                          ? Colors.green.shade700
                                          : Colors.brown.shade200,
                                    );
                                  },
                                  likeCount: post.likes,
                                ),
                                Text(
                                  ' Likes',
                                  style: TextStyle(
                                    color: Colors.brown.shade200,
                                  ),
                                ),
                                const Spacer(flex: 1),
                                LikeButton(
                                  circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc)),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.thumb_down,
                                      color: isLiked
                                          ? Colors.green.shade700
                                          : Colors.brown.shade200,
                                    );
                                  },
                                  likeCount: post.dislikes,
                                ),
                                Text(
                                  ' Dislikes',
                                  style: TextStyle(
                                    color: Colors.brown.shade200,
                                  ),
                                ),
                                const Spacer(flex: 1),
                                IconButton(
                                  onPressed: () {
                                    _toggleComments(post.id);
                                  },
                                  icon: Icon(
                                    Icons.comment,
                                    color: Colors.brown.shade200,
                                  ),
                                ),
                                Text(
                                  'Comments',
                                  style: TextStyle(
                                    color: Colors.brown.shade200,
                                  ),
                                ),
                                const Spacer(flex: 1),
                                LikeButton(
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.favorite,
                                      color: isLiked
                                          ? Colors.red.shade900
                                          : Colors.brown.shade200,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            if (post.showComments) ...[
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _commentControllers[post.id],
                                      decoration: InputDecoration(
                                        hintText: 'Add a comment',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      onFieldSubmitted: (text) {
                                        if (text.isNotEmpty) {
                                          _addComment(post.id, text);
                                          _commentControllers[post.id]?.clear();
                                        }
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.brown.shade200,
                                    ),
                                    onPressed: () {
                                      if (_commentControllers[post.id]
                                              ?.text
                                              .isNotEmpty ??
                                          false) {
                                        _addComment(post.id,
                                            _commentControllers[post.id]!.text);
                                        _commentControllers[post.id]?.clear();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: post.comments.length,
                                itemBuilder: (context, index) {
                                  final comment = post.comments[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(35.0),
                                      ),
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      comment.creatorImageUrl),
                                                ),
                                                const SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(comment.creatorName,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        _formatTimestamp(
                                                            comment.createdAt),
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12.0)),
                                                    Text(comment.content),
                                                  ],
                                                ),
                                                const Spacer(),
                                                LikeButton(
                                                  circleColor:
                                                      const CircleColor(
                                                          start:
                                                              Color(0xff00ddff),
                                                          end: Color(
                                                              0xff0099cc)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                          dotPrimaryColor:
                                                              Color(0xff33b5e5),
                                                          dotSecondaryColor:
                                                              Color(
                                                                  0xff0099cc)),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      Icons.thumb_up,
                                                      color: isLiked
                                                          ? Colors
                                                              .green.shade700
                                                          : Colors
                                                              .brown.shade200,
                                                      size: 18,
                                                    );
                                                  },
                                                  likeCount: comment.likes,
                                                  onTap: (isLiked) async {
                                                    _toggleCommentLike(post.id,
                                                        comment.id, true);
                                                    return !isLiked;
                                                  },
                                                ),
                                                const SizedBox(width: 8.0),
                                                LikeButton(
                                                  circleColor:
                                                      const CircleColor(
                                                          start:
                                                              Color(0xff00ddff),
                                                          end: Color(
                                                              0xff0099cc)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                          dotPrimaryColor:
                                                              Color(0xff33b5e5),
                                                          dotSecondaryColor:
                                                              Color(
                                                                  0xff0099cc)),
                                                  likeBuilder: (bool isLiked) {
                                                    return Icon(
                                                      Icons.thumb_down,
                                                      color: isLiked
                                                          ? Colors
                                                              .green.shade700
                                                          : Colors
                                                              .brown.shade200,
                                                      size: 18,
                                                    );
                                                  },
                                                  likeCount: comment.dislikes,
                                                  onTap: (isLiked) async {
                                                    _toggleCommentLike(post.id,
                                                        comment.id, false);
                                                    return !isLiked;
                                                  },
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _deleteComment(
                                                        post.id, comment.id);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color:
                                                        Colors.brown.shade200,
                                                    size: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.reply,
                                                        color: Colors
                                                            .brown.shade200,
                                                        size: 18,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showReplyFields[
                                                                  comment.id] =
                                                              !(_showReplyFields[
                                                                      comment
                                                                          .id] ??
                                                                  false);
                                                        });
                                                      },
                                                    ),
                                                    const Text('Reply'),
                                                  ],
                                                ),
                                                if (_showReplyFields[
                                                        comment.id] ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              _replyControllers[
                                                                  comment.id],
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Add a reply',
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                          ),
                                                          onFieldSubmitted:
                                                              (text) {
                                                            if (text
                                                                .isNotEmpty) {
                                                              _addReply(
                                                                  post.id,
                                                                  comment.id,
                                                                  text);
                                                              _replyControllers[
                                                                      comment
                                                                          .id]
                                                                  ?.clear();
                                                            } //dy 48ala 3adi li t7t 3nd l icon li m4 48ala
                                                          },
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.send,
                                                          color: Colors
                                                              .brown.shade200,
                                                        ),
                                                        onPressed: () {
                                                          // Ensure _replyControllers[comment.id] exists and its text is not empty
                                                          if (_replyControllers[
                                                                      comment
                                                                          .id]
                                                                  ?.text
                                                                  .isNotEmpty ??
                                                              false) {
                                                            String replyText =
                                                                _replyControllers[
                                                                        comment
                                                                            .id]!
                                                                    .text;
                                                            _addReply(
                                                                post.id,
                                                                comment.id,
                                                                replyText);
                                                            _replyControllers[
                                                                    comment.id]
                                                                ?.clear();
                                                            // Add focus removal logic if needed
                                                          } else {
                                                            // Log or handle the case where reply text is empty or controller is null
                                                            print(
                                                                "Reply text is empty or _replyControllers[comment.id] is null.");
                                                            print(
                                                                "hi ${_replyControllers[comment.id]}");
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      comment.replies.length,
                                                  itemBuilder:
                                                      (context, replyIndex) {
                                                    final reply = comment
                                                        .replies[replyIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 12,
                                                            backgroundImage:
                                                                NetworkImage(reply
                                                                    .creatorImageUrl),
                                                          ),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  reply
                                                                      .creatorName,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                  _formatTimestamp(
                                                                      reply
                                                                          .createdAt),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12.0)),
                                                              Text(reply
                                                                  .content),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Return an empty SizedBox if index is out of range
                  }
                },
                childCount: _posts.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostDialog,
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}








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
