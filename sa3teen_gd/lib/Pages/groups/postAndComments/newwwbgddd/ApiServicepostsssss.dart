import 'dart:convert';
import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/PostModellll.dart';
import 'package:http/http.dart' as http;
// import 'models/post.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/groups/";

  Future<List<Post>> getPosts(int groupId,String accessToken) async {Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(Uri.parse('$baseUrl$groupId/list_posts/'),headers: headers);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);print(response.body);
      print(response.statusCode);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
      
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to load posts');
    }
  }
}
