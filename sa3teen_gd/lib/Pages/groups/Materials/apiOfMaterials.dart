import 'dart:convert';

import 'package:gp_screen/Pages/groups/Materials/Materials.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;


class ApiService {
  Future<List<Materials>> getMaterials(int id, String token) async {
    final response = await http.get(
      Uri.parse('$finalurlforall/groups/$id/materials/'),
      headers: {
        'Authorization': 'Bearer $accesstokenfinal',
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
