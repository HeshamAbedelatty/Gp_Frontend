import 'dart:convert';

import 'package:http/http.dart' as http;

import 'profilemodel.dart';

class ProfileService {
  Future<ProfileModel> getProfile(String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/user/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      throw e;
    }
  }

  Future<void> updateProfile(String accessToken, ProfileModel profile) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/user/${profile.id}/'),
        headers: headers,
        body: jsonEncode(profile.toJson()), // Use toJson method of ProfileModel
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
      throw e;
    }
  }
}
