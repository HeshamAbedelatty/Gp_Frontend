import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/postAndComments/comments/Commentmodel.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:http/http.dart' as http;

class ListGroupsModel {
  final dynamic id;
  final String title;
  final String description;
  final String type;
  final String? image;
  final String? password;
  final String subject;
  final int members;
  final bool has_joined;

  ListGroupsModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.image,
    required this.type,
    required this.password,
    required this.members,
    required this.has_joined,
  });

  factory ListGroupsModel.fromJson(jsonData) {
    return ListGroupsModel(
      id: jsonData['id'],
      title: jsonData['title'],
      subject: jsonData['subject'],
      type: jsonData['type'],
      description: jsonData['description'],
      image: jsonData['image'],
      password: jsonData['password'],
      members: jsonData['members'],
      has_joined: jsonData['has_joined'],
    );
  }

  @override
  String toString() {
    return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members', has_joined='$has_joined'";
  }
}

class ListGroupsProvider with ChangeNotifier {
  List<ListGroupsModel> _groups = [];
  List<ListGroupsModel> get groups => _groups;

Future<void> joinGroup(String urll,
    int groupId, String accessToken, String? password) async {
  final url = Uri.parse('http://10.0.2.2:8000/groups/$groupId/join/');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  Map<String, dynamic> body = {};
  if (password != null && password.isNotEmpty) {
    body['password'] = password;
  }

  final response = await http.post(
    url,
    headers: headers,
    body: json.encode(body),
  );

// fetchAllGroups(url, accessToken);
fetchAllGroups(urll, accessToken);
//     notifyListeners();

    notifyListeners();
  if (response.statusCode == 200) {
    print('Successfully joined the group');
  } else {
    print('Failed to join the group: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<void> unjoinGroup(String urll,int groupId, String token) async {
  final url = Uri.parse('http://10.0.2.2:8000/groups/$groupId/unjoin/');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    fetchAllGroups(urll, token);
    notifyListeners();
    print('Successfully unjoined the group');
  } else {
    print('Failed to unjoin the group: ${response.statusCode}');
  }
}

  Future<void> fetchAllGroups(String url, String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    List<dynamic> data = await Api().get(
      url: 'http://10.0.2.2:8000/$url',
      headers: headers,
    );

    _groups = data.map((json) => ListGroupsModel.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> searchGroupsByTitle(String title, String accessToken) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    List<dynamic> data = await Api().get(
      url: 'http://10.0.2.2:8000/groups/search/$title/',
      headers: headers,
    );

    _groups = data.map((json) => ListGroupsModel.fromJson(json)).toList();
    notifyListeners();
  }
}
