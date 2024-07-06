import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/uicomments.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/PostModellll.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/PostProviderrrrr.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class postDetailsPage extends StatelessWidget {
  final int groupId;

  postDetailsPage({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            'Posts:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PostList(groupId: groupId),
          ),
        ],
      ),
    );
  }
}

class PostList extends StatefulWidget {
  final int groupId;

  PostList({required this.groupId});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PostProvider>(context, listen: false)
        .fetchPosts(widget.groupId));
    Future.microtask(() => Provider.of<PostProvider>(context, listen: false)
        .fetchPosts(widget.groupId));
  }

  // Future<void> likePost(int postid, int groupId) async {
  //   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postid/like/';
  //   const accessToken =
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print(response.statusCode);
  //       print(response.body);
  //     } else {
  //       print(response.statusCode);
  //       print(response.body);
  //       print('Failed to like post');
  //     }
  //   } catch (e) {
  //     print('Error liking post: ${e.toString()} ');
  //   }
  // }

  // Future<void> unlikePost(int postid, int groupId) async {
  //   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/${postid}/unlike/';
  //   const accessToken =
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';
  //   // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // setState(() {
  //       //   post.userHasLiked = false;
  //       //   post.likes -= 1;
  //       // });
  //     } else {
  //       print('Failed to unlike post');
  //     }
  //   } catch (e) {
  //     print('Error unliking post: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        if (postProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (postProvider.posts.isEmpty) {
          return const Center(child: Text('No posts available'));
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  Posts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: postProvider.posts.length,
                itemBuilder: (context, index) {
                  Post post = postProvider.posts[index];
                  return Card(
                    color: kprimaryColourWhite,
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              post.user.image != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(post.user.image!),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: kprimaryColourcream,
                                      child: Text(post.user.username[0]),
                                    ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.user.username,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    post.createdAt,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,color: kprimaryColourcream,),
                                onPressed: () async {
                                  await Provider.of<PostProvider>(context,
                                          listen: false)
                                      .deletePost(
                                          context, widget.groupId, post.id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit,color: kprimaryColourcream,),
                                onPressed: () {
                                  _showEditDialog(context, post);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post.description,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          post.image != null
                              ? Center(
                                  child: Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      image: post.image != null
                                          ? DecorationImage(
                                              image: NetworkImage(post.image!),
                                              fit: BoxFit.cover,
                                            )
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  'assets/default_user_image.png'),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                )
                              : const Row(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                width: 5,
                              ),
                              if (!post.userHasLiked)
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  color:
                                      kprimaryColourcream, // Use your preferred color
                                  icon: const Icon(
                                      Icons.thumb_up_off_alt_outlined,color: kprimaryColourcream,),
                                  onPressed: ()async {

                                    await Provider.of<PostProvider>(context,
                                          listen: false)
                                      .likePost(
                                          context, post.id,widget.groupId);
                                           Provider.of<PostProvider>(context, listen: false)
                      .fetchPosts(widget.groupId);
                                    // likePost(post.id, widget.groupId);
                                  },
                                ),
                              if (post.userHasLiked)
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  color:
                                      Colors.green, // Use your preferred color
                                  icon: const Icon(Icons.thumb_up),
                                    onPressed: ()async {

                                    await Provider.of<PostProvider>(context,
                                          listen: false)
                                      .unlikePost(
                                          context, post.id,widget.groupId);

                                           Provider.of<PostProvider>(context, listen: false)
                      .fetchPosts(widget.groupId);
                                    // likePost(post.id, widget.groupId);
                                  },
                                ),
                              Text('${post.likes} likes'),
                              const Spacer(
                                flex: 1,
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              IconButton(
                                color: kprimaryColourcream,
                                icon: const Icon(Icons.comment_outlined),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                          groupId: widget.groupId,
                                          postId: post.id),
                                    ),
                                  );
                                },
                              ),
                              const Text(' comments'),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Post post) {
    final TextEditingController descriptionController =
        TextEditingController(text: post.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final newDescription = descriptionController.text;
              if (newDescription.isNotEmpty) {
                await Provider.of<PostProvider>(context, listen: false)
                    .editPost(ctx, widget.groupId, post.id, newDescription);
                Navigator.of(ctx).pop();
                // Provider.of<PostProvider>(context, listen: false)
                //       .fetchPosts(widget.groupId)
                //                 .then((_) {
                //               Navigator.of(context).pop();
                //             });
              }
            },
          ),
          //  TextButton(
          //   child: Text('Save'),
          //   onPressed: () async {
          //     final newDescription = descriptionController.text;
          //     if (newDescription.isNotEmpty) {
          //     await   Provider.of<PostProvider>(context, listen: false)
          //           .editPost(ctx, widget.groupId, post.id, newDescription);
          //             //   await    Provider.of<PostProvider>(context, listen: false)
          //             // .fetchPosts(widget.groupId)
          //             //           .then((_) {
          //             //         Navigator.of(context).pop();
          //             //       });
          //       Navigator.of(ctx).pop();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}














  // void s_showEditDialog(BuildContext context, Post post) {
  //   final TextEditingController descriptionController =
  //       TextEditingController(text: post.description);

  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Edit Post'),
  //       content: TextField(
  //         controller: descriptionController,
  //         decoration: const InputDecoration(labelText: 'Description'),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Cancel'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         ),
  //         TextButton(
  //           child: const Text('Save'),
  //           onPressed: () async {
  //             final newDescription = descriptionController.text;
  //             if (newDescription.isNotEmpty) {
  //               await Provider.of<PostProvider>(context, listen: false)
  //                   .editPost(ctx, widget.groupId, post.id, newDescription);
  //               Navigator.of(ctx).pop();
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

