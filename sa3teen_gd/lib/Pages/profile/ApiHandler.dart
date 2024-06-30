import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<Map<String, dynamic>> getUserInfo(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<String?> updateProfilePhoto(int userId, File imageFile) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/users/$userId/upload_photo/'));
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final responseJson = jsonDecode(responseData.body);
      return responseJson[
          'image']; // Assuming the API returns the new image URL
    } else {
      throw Exception('Failed to upload profile photo');
    }
  }

  Future<void> updateUser(int userId, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
}
