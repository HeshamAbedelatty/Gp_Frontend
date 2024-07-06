import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
// import 'package:gp_screen/Pages/groups/myGroups/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyGroupProvider with ChangeNotifier {
  List<UserGroup> _userGroups = [];

  List<UserGroup> get userGroups => _userGroups;

  Future<void> fetchUserGroups(String accessToken) async {
    final url = Uri.parse('http://10.0.2.2:8000/groups/user_joined_groups/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _userGroups = responseData.map((data) => UserGroup.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load groups');
    }
  }
}
