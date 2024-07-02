import 'dart:convert';
import 'package:gp_screen/Pages/groups/Materials/Materials%20copy.dart';
import 'package:gp_screen/Pages/groups/Materials/Materials.dart';
import 'package:http/http.dart' as http;
// import 'models.dart';

class ApiService {
  Future<List<Materials>> getMaterials(int id, String token) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/groups/$id/materials/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(response.body);

      return data.map((json) => Materials.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load materials');
    }
  }
}
