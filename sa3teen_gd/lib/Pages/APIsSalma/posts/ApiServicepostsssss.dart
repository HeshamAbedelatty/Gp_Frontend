import 'dart:convert';
import 'package:gp_screen/Pages/groups/postAndComments/post/PostModel.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;
// import 'models/post.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/groups/";
// String accesstokenfinal=
//    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjg0MDk2LCJpYXQiOjE3MjAzODgwOTYsImp0aSI6IjIyMTE2MWZjZGI0ODQwZmU5YTE2NTEyMTI4ZWQ2YTZiIiwidXNlcl9pZCI6MjJ9.inlHVejYMF8YE-_TZYOJtOTiKYwpgq5uP-xhqPub1ws";


  Future<List<Post>> getPosts(int groupId,String accessToken) async {Map<String, String> headers = {
      'Authorization': 'Bearer $accesstokenfinal',
    };

    final response = await http.get(Uri.parse('$baseUrl$groupId/list_posts/'),headers: headers);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);print(response.body);
      print(response.statusCode);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
      
    } else {
      
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load posts');
    }
  }
}
