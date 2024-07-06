import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/Materials.dart';
import 'package:http/http.dart' as http;


class User {
  final String username;
  final String image;

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
      Uri.parse('http://10.0.2.2:8000/groups/$id/materials/'),
      headers: {
        'Authorization': 'Bearer $token',
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
