// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostModellll.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
// import 'dart:convert';
// // import '../models/post.dart';

// class PostProvider with ChangeNotifier {
//   List<Post> _posts = [];
//   bool _isLoading = false;

//   List<Post> get posts => _posts;
//   bool get isLoading => _isLoading;

//   Future<void> fetchPosts(int groupId) async {
//     _isLoading = true;
//     notifyListeners();

//     final url = 'http://10.0.2.2:8000/groups/$groupId/list_posts/';
//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as List;
//         _posts = data.map((json) => Post.fromJson(json)).toList();
//       } else {
//         print('Failed to load posts');
//       }
//     } catch (e) {
//       print('Error loading posts: $e');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> createPost(int groupId, String accessToken, String description) async {
//     final url = 'http://10.0.2.2:8000/groups/$groupId/posts/';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'description': description,
//           'image': null,
//         }),
//       );

//       if (response.statusCode == 201) {
//         final newPost = Post.fromJson(jsonDecode(response.body));
//         _posts.add(newPost);
//         notifyListeners();
//       } else {
//         print('Failed to create post');
//       }
//     } catch (e) {
//       print('Error creating post: $e');
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/ApiServicepostsssss.dart';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostModellll.dart';
// import 'models/post.dart';
// import 'services/api_service.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts(int groupId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await ApiService().getPosts(groupId,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU');
    } catch (e) {
      // Handle the error appropriately
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  //   Future<void> createPost(int groupId, String accessToken, String description) async {
  //   final url = 'http://10.0.2.2:8000/groups/$groupId/posts/';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'description': description,
  //         'image': null,
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       final newPost = Post.fromJson(jsonDecode(response.body));
  //       _posts.add(newPost);
  //       notifyListeners();
  //     } else {
  //       print('Failed to create post');
  //     }
  //   } catch (e) {
  //     print('Error creating post: $e');
  //   }
  // }
  Future<void> createPost(int groupId, String accessToken, String description, File? image) async {
    final url = 'http://10.0.2.2:8000/groups/$groupId/posts/';
 var request = http.MultipartRequest('POST', Uri.parse(url))
    // ..fields['title'] = title
    ..fields['description'] = description;
    // ..fields['type'] = privacy
    // ..fields['password'] = password
    // ..fields['subject'] = subject;
     
      if (image != null) {
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
  }  request.headers['Authorization'] = 'Bearer $accessToken';

    try {
      // var request = http.MultipartRequest('POST', Uri.parse(url));
      // request.headers['Authorization'] = 'Bearer $accessToken';

      // request.fields['description'] = description;
 

  // Add the access token to the headers
     
      // if (image != null) {
      //   // final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])?.split('/');
      //   final file = await http.MultipartFile.fromPath(
      //     'image',
      //     image.path,
      //     contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
      //   );
      //   request.files.add(file);
      // } else {
      //   request.fields['image'] = 'null';
      // }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final newPost = Post.fromJson(jsonDecode(response.body));
        _posts.add(newPost);
        notifyListeners();
      } else {
        print('Failed to create post');
      }
    } catch (e) {
      print('Error creating post: $e');
    }
  }
}

Future<dynamic?> _sendMessageToBackend(String title, String description,
    String privacy, File? image, String password, String subject, String accessToken) async {
  var uri = Uri.parse('http://10.0.2.2:8000/groups/');
  
  var request = http.MultipartRequest('POST', uri)
    ..fields['title'] = title
    ..fields['description'] = description
    ..fields['type'] = privacy
    ..fields['password'] = password
    ..fields['subject'] = subject;

  // If you need to send an image file
  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
  }

  // Add the access token to the headers
  request.headers['Authorization'] = 'Bearer $accessToken';

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}'); // Log status code
    print('Response body: ${response.body}'); // Log response body

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('Request success with status: ${response.statusCode}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
  return null;
}
