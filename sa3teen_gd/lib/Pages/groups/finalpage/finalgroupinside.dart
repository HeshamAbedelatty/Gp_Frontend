// ignore_for_file: avoid_print, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/Materials.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/membersCircle.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/usersInGroupsPage.dart';
import 'package:gp_screen/Pages/groups/apis/GroupsAPI.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postsComments.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

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
    futureGroup =
        GroupService().getGroupById(widget.accessToken, widget.groupId);
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
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
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
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                            color: kprimaryColourcream),
                        child: Icon(
                          Icons.group,
                          size: 50,
                          color: Colors.grey.shade800,
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
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
                      Container(
                        height: 40,
                        child: GroupUsersOverviewPage(
                            id: group.id,
                            token:
                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                      ),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupUsersPage(
                                      id: group.id,
                                      token:
                                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'),
                                ),
                              );
                            },
                            child: Text('(${group.members} members)',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade600)),
                          ),
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
                                            style:
                                                const TextStyle(fontSize: 18),
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
                                  width: 110,
                                  colory: kprimaryColourcream,
                                  buttonText: 'Materials',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MaterialsPage(
                                            groupID: group.id,
                                            id: group.id,
                                          ),
                                        ));

                                    print('Files button clicked!');
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
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
