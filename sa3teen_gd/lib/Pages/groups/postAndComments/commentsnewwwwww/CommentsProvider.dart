import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/cmodel.dart';
import 'package:http/http.dart' as http;

// class CommentsProvider with ChangeNotifier {
//   final String token;
//   List<Comment> _comments = [];

//   CommentsProvider(this.token);

//   List<Comment> get comments => _comments;
// // Future<List<Comment>> getPosts(int groupId, int postId) async {Map<String, String> headers = {
// //       'Authorization': 'Bearer $token',
// //     };

// //     final response = await http.get(Uri.parse('http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments_replies/'),headers: headers);

// //     if (response.statusCode == 200) {
// //       List jsonResponse = json.decode(response.body);print(response.body);
// //       print(response.statusCode);
// //       return jsonResponse.map((post) => Comment.fromJson(post)).toList();
      
// //     } else {
// //       print(response.body);
// //       print(response.statusCode);
// //       throw Exception('Failed to load posts');
// //     }
//   // Future<void> fetchComments(int groupId, int postId) async {
//   //   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments_replies/';
//   //   final response = await http.get(
//   //     Uri.parse(url),
//   //     headers: {'Authorization': 'Bearer $token'},
//   //   );

//   //   if (response.statusCode == 201) {
//   //     final List<dynamic> responseData = json.decode(response.body);
//   //     _comments = responseData.map((data) => Comment.fromJson(data)).toList();  print(response.statusCode);
//   //     print(response.body);
//   //     notifyListeners();
//   //   } else {  print(response.statusCode);
//   //     print(response.body);
//   //     throw Exception('Failed to load comments');
//   //   }
//   // // }

//   // }
// Future<void> fetchComments(int groupId, int postId) async {
//   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments_replies/';
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {'Authorization': 'Bearer $token'},
//   );

//   if (response.statusCode == 200) {
//     print('Comments fetched successfully');
//     final List<dynamic> responseData = json.decode(response.body);
//     print(responseData);
//     _comments = responseData.map((data) => Comment.fromJson(data)).toList();
//     notifyListeners();
//   } else {
//     print('Failed to load comments');
//     throw Exception('Failed to load comments');
//   }
// }





class CommentsProvider with ChangeNotifier {
  final String token;
  List<Comment> _comments = [];

  CommentsProvider(this.token);

  List<Comment> get comments => _comments;

  Future<void> fetchComments(int groupId, int postId) async {
    final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments_replies/';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _comments = responseData.map((data) => Comment.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load comments');
    }
  }

//   Future<void> postComment(int groupId, int postId, String description) async {
//     final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments/';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: json.encode({
//         'description': description,
//         'image': null,
//       }),
//     );

//     if (response.statusCode == 201) {
//       final newComment = Comment.fromJson(json.decode(response.body));
//       _comments.add(newComment);
//       notifyListeners();  // Notify listeners to update the UI with the new comment
//       await fetchComments(groupId, postId);  // Fetch comments to ensure the list is up-to-date
//     } else {
//       throw Exception('Failed to post comment');
//     }
//   }
// }


  Future<void> postComment(int groupId, int postId, String description) async {
    final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'description': description,
        'image': null,
      }),
    );
try{if (response.statusCode == 200) {
      final newComment = Comment.fromJson(json.decode(response.body));
      _comments.add(newComment);  print(response.statusCode);
       print('New comment added: $newComment');//////???????????
      print(response.body);
      await fetchComments(groupId, postId);
      notifyListeners();
       
    } else {
      print(response.statusCode);
      print(response.body);
      
    }}catch(e){throw Exception('Failed to post comment$e');}
    
  }
  Future<void> posttComment(int groupId, int postId, String description) async {
  final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments/';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({
      'description': description,
      'image': null,
    }),
  );

  if (response.statusCode == 200) {
    final newComment = Comment.fromJson(json.decode(response.body));
    _comments.add(newComment);
    notifyListeners();
    await fetchComments(groupId, postId);   // Notify listeners to update the UI with the new comment
    print('New comment added: $newComment');
  } else {
    print('Failed to post comment');
    throw Exception('Failed to post comment');
  }
}Future<void> postReply(int groupId, int postId, int commentId, String description) async {
    final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments/$commentId/replies/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'description': description,
        'image': null,
      }),
    );

    if (response.statusCode == 201) {
      await fetchComments(groupId, postId);  // Fetch comments to ensure the list is up-to-date
    } else {
      throw Exception('Failed to post reply');
    }
  }

}
