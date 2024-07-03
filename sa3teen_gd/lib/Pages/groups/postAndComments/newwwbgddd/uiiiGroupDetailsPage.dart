import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostModellll.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostProviderrrrr.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => PostProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: GroupDetailsPage(groupId: 7),
//     );
//   }
// }

class postDetailsPage extends StatelessWidget {
  final int groupId;

  postDetailsPage({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Group Details'),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Other group details widgets
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
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => Provider.of<PostProvider>(context, listen: false)
  //       .fetchPosts(widget.groupId));
  // }
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PostProvider>(context, listen: false)
        .fetchPosts(widget.groupId));
    Future.microtask(() => Provider.of<PostProvider>(context, listen: false)
        .fetchPosts(widget.groupId));
  }

  Future<void> likePost(int postid, int groupId) async {
    final url = 'http://10.0.2.1:8000/groups/$groupId/posts/${postid}/like/';
    const accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
        print('Failed to like post');
      }
    } catch (e) {
      //  print(response.statusCode);
      // print(response.body);

      print('Error liking post: $e');
    }
  }

  // Future<void> unlikePost(int postid, int groupId) async {
  //   final url = 'http://10.0.2.1:8000/groups/$groupId/posts/${postid}/unlike/';
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

                              // : CircleAvatar(
                              //     backgroundColor: kprimaryColourcream,
                              //     child: Text(post.user.username[0]),
                              //   ),
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
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post.description,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          //  post.image != null
                          //       ?
                          //       CircleAvatar(
                          //           backgroundImage: NetworkImage(post.image!),
                          //         ):
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
                              // Spacer(flex: 1,),
                              // post.userHasLiked=true;
                              const SizedBox(
                                width: 5,
                              ),
                              if (!post.userHasLiked)
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  color:
                                      kprimaryColourcream, // Use your preferred color
                                  icon: const Icon(
                                      Icons.thumb_up_off_alt_outlined),
                                  onPressed: () {
                                    likePost(post.id, widget.groupId);
                                  },
                                ),
                              if (post.userHasLiked)
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  color:
                                      Colors.green, // Use your preferred color
                                  icon: const Icon(Icons.thumb_up),
                                  onPressed: () {
                                    likePost(post.id, widget.groupId);
                                  },
                                ),

                              Text('${post.likes} likes'),
                              const Spacer(
                                flex: 1,
                              ),
                              // IconButton(
                              //   color: kprimaryColourcream,
                              //   icon: const Icon(Icons.thumb_down_off_alt_rounded),
                              //   onPressed: () {
                              //     // Implement dislike functionality
                              //   },
                              // ),
                              // const Text(' dislikes'),
                              const Spacer(
                                flex: 3,
                              ),

                              IconButton(
                                color: kprimaryColourcream,
                                icon: const Icon(Icons.comment_outlined),
                                onPressed: () {
                                  // Implement comment functionality
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
}
