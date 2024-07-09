import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/comments/Commentmodel.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;

class CommentsProvider with ChangeNotifier {
  final String token;
  List<Comment> _comments = [];

  CommentsProvider(this.token);

  List<Comment> get comments => _comments;
///////////////////token2
  Future<void> fetchComments(context,int groupId, int postId) async {
  String  token2=        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

    final url =
        '$finalurlforall/groups/$groupId/posts/$postId/comments_replies/';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accesstokenfinal'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _comments = responseData.map((data) => Comment.fromJson(data)).toList();
      notifyListeners();
    } else {
      _showErrorDialog(context, response.body);

      // throw Exception('Failed to load comments');
    }
  }

//   import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> postComment(BuildContext context, int groupId, int postId, String description) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accesstokenfinal',
    },
    body: json.encode({
      'description': description,
      'image': null,
    }),
  );

  if (response.statusCode == 200) {
    final newComment = Comment.fromJson(json.decode(response.body));
    _comments.add(newComment);
    print('New comment added: $newComment');
    await fetchComments(context, groupId, postId);
    notifyListeners();
  } else {
    print('Failed to post comment: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}

Future<void> postReply(BuildContext context, int groupId, int postId, int commentId, String description) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accesstokenfinal',
    },
    body: json.encode({
      'description': description,
      'image': null,
    }),
  );

  if (response.statusCode == 201) {
    await fetchComments(context, groupId, postId);
  } else {
    print('Failed to post reply: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}

Future<void> deleteComment(BuildContext context, int groupId, int postId, int commentId) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/';
  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accesstokenfinal',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    _comments.removeWhere((comment) => comment.id == commentId);
    await fetchComments(context, groupId, postId);
    notifyListeners();
  } else {
    print('Failed to delete comment: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}

Future<void> deleteReply(BuildContext context, int groupId, int postId, int commentId, int replyId) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/$replyId/';
  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accesstokenfinal',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    final comment = _comments.firstWhere((comment) => comment.id == commentId);
    comment.replies.removeWhere((reply) => reply.id == replyId);
    await fetchComments(context, groupId, postId);
    notifyListeners();
  } else {
    print('Failed to delete reply: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}

Future<void> editComment(BuildContext context, int groupId, int postId, int commentId, String description) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/';
  final response = await http.patch(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accesstokenfinal',
    },
    body: json.encode({
      'description': description,
    }),
  );

  if (response.statusCode == 200) {
    final updatedComment = Comment.fromJson(json.decode(response.body));
    final commentIndex = _comments.indexWhere((comment) => comment.id == commentId);
    if (commentIndex != -1) {
      _comments[commentIndex] = updatedComment;
      await fetchComments(context, groupId, postId);
      notifyListeners();
    }
  } else {
    print('Failed to edit comment: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}

Future<void> editReply(BuildContext context, int groupId, int postId, int commentId, int replyId, String description) async {
  final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/$replyId/';
  final response = await http.patch(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accesstokenfinal',
    },
    body: json.encode({
      'description': description,
      'image': null,
    }),
  );

  if (response.statusCode == 200) {
    final updatedReply = Reply.fromJson(json.decode(response.body));
    final commentIndex = _comments.indexWhere((comment) => comment.id == commentId);
    if (commentIndex != -1) {
      final replyIndex = _comments[commentIndex].replies.indexWhere((reply) => reply.id == replyId);
      if (replyIndex != -1) {
        _comments[commentIndex].replies[replyIndex] = updatedReply;
        notifyListeners();
      }
    }
  } else {
    print('Failed to edit reply: ${response.body}');
    _showErrorDialog(context, response.body);
  }
}


  // Future<void> postComment(context,int groupId, int postId, String description) async {
  //   final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/';
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //     body: json.encode({
  //       'description': description,
  //       'image': null,
  //     }),
  //   );
  //   // try {
  //     if (response.statusCode == 200) {
  //       final newComment = Comment.fromJson(json.decode(response.body));
  //       _comments.add(newComment);
  //       print(response.statusCode);
  //       print('New comment added: $newComment'); //////???????????
  //       print(response.body);
  //       await fetchComments(context,groupId, postId);
  //       notifyListeners();
  //           _showErrorDialog(context, response.body);
  //     } else if (response.statusCode==403){
  //       print(response.statusCode);
  //       print(response.body);
  //     }
  //   // } 
  //   // catch (e) {
  //           // _showErrorDialog(context, response.body);

  //     // throw Exception('Failed to post comment$e');
  //   // }
  // }

  // // Future<void> posttComment(context,int groupId, int postId, String description) async {
  // //   final url = '$finalurlforall/groups/$groupId/posts/$postId/comments/';
  // //   final response = await http.post(
  // //     Uri.parse(url),
  // //     headers: {
  // //       'Content-Type': 'application/json',
  // //       'Authorization': 'Bearer $accesstokenfinal',
  // //     },
  // //     body: json.encode({
  // //       'description': description,
  // //       'image': null,
  // //     }),
  // //   );

  // //   if (response.statusCode == 200) {
  // //     final newComment = Comment.fromJson(json.decode(response.body));
  // //     _comments.add(newComment);
  // //     notifyListeners();
  // //     await fetchComments(context,groupId,
  // //         postId); // Notify listeners to update the UI with the new comment
  // //     print('New comment added: $newComment');
  // //   } else {
  // //     print('Failed to post comment');
  // //           _showErrorDialog(context, response.body);

  // //     // throw Exception('Failed to post comment');
  // //   }
  // // }

  // Future<void> postReply(context,
  //     int groupId, int postId, int commentId, String description) async {
  //   final url =
  //       '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/';
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //     body: json.encode({
  //       'description': description,
  //       'image': null,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     await fetchComments(context,
  //         groupId, postId); // Fetch comments to ensure the list is up-to-date
  //   } else {
  //           _showErrorDialog(context, response.body);

  //     // throw Exception('Failed to post reply');
  //   }
  // }

  // Future<void> deleteComment(
  //     BuildContext context, int groupId, int postId, int commentId) async {
  //   final url =
  //       '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/';
  //   final response = await http.delete(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //   );
  //   print(response.statusCode);
  //   print(response.body);
  //   //  try {
  //   if (response.statusCode == 200 ||
  //       response.statusCode == 201 ||
  //       response.statusCode == 204) {
  //     _comments.removeWhere((comment) => comment.id == commentId);
  //     print(response.statusCode);
  //     print(response.body);
  //     await fetchComments(context,groupId, postId);
  //     notifyListeners();
  //   } else if (response.statusCode == 403) {
  //     print(response.statusCode);
  //     print(response.body);
  //     _showErrorDialog(context, '${response.body}');

  //     // throw Exception('Failed to delete comment');
  //   }
  //   //  } catch (e) {  print(response.statusCode);
  //   //   print(response.body);          _showErrorDialog(context, 'Failed to delete comment');

  //   //  throw Exception('Failed to delete comment$e');
  //   //  }{}
  // }

  // Future<void> deleteReply(BuildContext context, int groupId, int postId,
  //     int commentId, int replyId) async {
  //   final url =
  //       '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/$replyId/';
  //   final response = await http.delete(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //   );

  //   if (response.statusCode == 200 ||
  //       response.statusCode == 201 ||
  //       response.statusCode == 204) {
  //     final comment =
  //         _comments.firstWhere((comment) => comment.id == commentId);
  //     comment.replies.removeWhere((reply) => reply.id == replyId);
  //     await fetchComments(context,groupId, postId);
  //     notifyListeners();
  //   } else {
  //     _showErrorDialog(context, '${response.body}');
  //   }
  // }

  // Future<void> editComment(BuildContext context, int groupId, int postId,
  //     int commentId, String description) async {
  //   final url =
  //       '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/';
  //   final response = await http.patch(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //     body: json.encode({
  //       'description': description,
  //     }),
  //   );
  //   print(response.statusCode);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final updatedComment = Comment.fromJson(json.decode(response.body));
  //     final commentIndex =
  //         _comments.indexWhere((comment) => comment.id == commentId);
  //     if (commentIndex != -1) {
  //       print(response.statusCode);
  //       print(response.body);
  //       _comments[commentIndex] = updatedComment;
  //       await fetchComments(context,groupId, postId);
  //       notifyListeners();
  //     }
  //   } else {
  //     print(response.statusCode);
  //     print(response.body);
  //     _showErrorDialog(context, response.body);

  //     // _showErrorDialog(context, 'Failed to edit comment');
  //   }
  // }
  // // Future<void> editReply(BuildContext context, int groupId, int postId, int commentId, int replyId, String description) async {
  // //   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/$postId/comments/$commentId/replies/$replyId';
  // //   final response = await http.patch(
  // //     Uri.parse(url),
  // //     headers: {
  // //       'Content-Type': 'application/json',
  // //       'Authorization': 'Bearer $accessToken',
  // //     },
  // //     body: json.encode({
  // //       'description': description,
  // //       'image': null,
  // //     }),
  // //   );

  // //   if (response.statusCode == 200) {
  // //     final updatedReply = Reply.fromJson(json.decode(response.body));
  // //     final commentIndex = _comments.indexWhere((comment) => comment.id == commentId);
  // //     if (commentIndex != -1) {
  // //       final replyIndex = _comments[commentIndex].replies.indexWhere((reply) => reply.id == replyId);
  // //       if (replyIndex != -1) {
  // //         _comments[commentIndex].replies[replyIndex] = updatedReply;
  // //         notifyListeners();
  // //       }
  // //     }
  // //   } else {
  // //     _showErrorDialog(context, 'Failed to edit reply');
  // //   }
  // // }
  // Future<void> editReply(BuildContext context, int groupId, int postId,
  //     int commentId, int replyId, String description) async {
  //   final url =
  //       '$finalurlforall/groups/$groupId/posts/$postId/comments/$commentId/replies/$replyId/';
  //   final response = await http.patch(
  //     Uri.parse(url),
  //     // headers: {
  //     //   'Content-Type': 'application/json',
  //     //   'Authorization': 'Bearer $accessToken',
  //     // },
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accesstokenfinal',
  //     },
  //     body: json.encode({
  //       'description': description,
  //       'image': null,
  //     }),
  //   );

  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     final updatedReply = Reply.fromJson(json.decode(response.body));
  //     final commentIndex =
  //         _comments.indexWhere((comment) => comment.id == commentId);
  //     if (commentIndex != -1) {
  //       final replyIndex = _comments[commentIndex]
  //           .replies
  //           .indexWhere((reply) => reply.id == replyId);
  //       if (replyIndex != -1) {
  //         _comments[commentIndex].replies[replyIndex] = updatedReply;
  //         notifyListeners();
  //       }
  //     }
  //   } else {
  //     _showErrorDialog(context, response.body);
  //   }
  // }

// void _showErrorDialog(BuildContext context, String message) {
//   showDialog(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       title: Text('Error'),
//       content: Text(message),
//       actions: <Widget>[
//         TextButton(
//           child: Text('Okay'),
//           onPressed: () {
//             Navigator.of(ctx).pop();
//           },
//         ),
//       ],
//     ),
//   );
// }
  // void _showErrorDialog(BuildContext context, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Error'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// }
