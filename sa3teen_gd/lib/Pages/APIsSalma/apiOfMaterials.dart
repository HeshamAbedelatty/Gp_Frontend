import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/ui/Materials.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;


class User {
  final String username;
  final String ?image;

  User({required this.username, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      image: json['image'],
    );
  }
}

class Materials {
  final int id;
  final User user;
  final String title;
  final String mediaPath;
  final String uploadedTime;

  Materials({
    required this.id,
    required this.user,
    required this.title,
    required this.mediaPath,
    required this.uploadedTime,
  });

  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
      id: json['id'],
      user: User.fromJson(json['user']),
      title: json['title'],
      mediaPath: json['media_path'],
      uploadedTime: json['uploaded_Time'],
    );
  }
}
class MaterialsProvider with ChangeNotifier {
  List<Materials> _materials = [];
  bool _isLoading = false;

  List<Materials> get materials => _materials;
  bool get isLoading => _isLoading;

  Future<void> fetchMaterials(int id, String token) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('$finalurlforall/groups/$id/materials/'),
      headers: {
        'Authorization': 'Bearer $accesstokenfinal',
      },
    );

    if (response.statusCode == 200) { print(response.statusCode);
      print(response.body);
      List<dynamic> data = json.decode(response.body);
      _materials = data.map((json) => Materials.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      print(response.body);
      // throw Exception('Failed to load materials');
    }

    _isLoading = false;
    notifyListeners();
  }



Future<dynamic?> uploadMat(String title,
     File? image,int groupid,  String accessToken) async {
  var uri = Uri.parse('$finalurlforall/groups/$groupid/materials/upload/');
  
  var request = http.MultipartRequest('POST', uri)
    ..fields['title'] = title;

  // If you need to send an image file
  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath('media_path', image.path));
  }

  // Add the access token to the headers
  request.headers['Authorization'] = 'Bearer $accesstokenfinal';

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}'); // Log status code
    print('Response body: ${response.body}'); // Log response body

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      fetchMaterials(groupid,  accessToken);
      notifyListeners();
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
 Future<void> deleteMaterial(context,int groupId, int materialId, String token) async {
    final response = await http.delete(
      Uri.parse('$finalurlforall/groups/$groupId/materials/delete/$materialId/'),
      headers: {
        'Authorization': 'Bearer $accesstokenfinal',
      },
    );

    if (response.statusCode == 204) {
      _materials.removeWhere((material) => material.id == materialId);
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.body);
            _showErrorDialog(context, '${response.body}');

      // throw Exception('Failed to delete material');
    }
  }
   void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
}
}

// import 'dart:convert';
// import 'package:gp_screen/Pages/groups/Materialsscreen/Materials%20copy.dart';
// import 'package:gp_screen/Pages/groups/Materialsscreen/Materials.dart';
// import 'package:http/http.dart' as http;
// // import 'models.dart';

// class ApiService {
//   Future<List<Materials>> getMaterials(int id, String token) async {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8000/groups/$id/materials/'),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       print(response.body);

//       return data.map((json) => Materials.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load materials');
//     }
//   }
// }
