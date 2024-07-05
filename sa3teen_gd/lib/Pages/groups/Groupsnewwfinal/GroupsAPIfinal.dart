import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';

class ListGroupsModel {
  final int id;
  final String title;
  final String description;
  final String type;
  final String? image;
  final String? password;
  final String subject;
  final int members;

  ListGroupsModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.image,
    required this.type,
    required this.password,
    required this.members,
  });

  factory ListGroupsModel.fromJson(Map<String, dynamic> jsonData) {
    return ListGroupsModel(
      id: jsonData['id'],
      title: jsonData['title'],
      subject: jsonData['subject'],
      type: jsonData['type'],
      description: jsonData['description'],
      image: jsonData['image'],
      password: jsonData['password'],
      members: jsonData['members'],
    );
  }

  @override
  String toString() {
    return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members'";
  }
}

class GroupsProvider with ChangeNotifier {
  final String token;
  List<ListGroupsModel> _groups = [];
  ListGroupsModel? _selectedGroup;

  GroupsProvider(this.token);

  List<ListGroupsModel> get groups => _groups;
  ListGroupsModel? get selectedGroup => _selectedGroup;

  Future<void> getAllGroups() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    List<dynamic> data = await Api().get(
      url: 'http://10.0.2.2:8000/groups/',
      headers: headers,
    );

    _groups = data.map((json) => ListGroupsModel.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> getGroupById(
    int id,
  ) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    dynamic data = await Api().anotherget(
      url: 'http://10.0.2.2:8000/groups/$id/',
      headers: headers,
    );

    _selectedGroup = ListGroupsModel.fromJson(data);
    notifyListeners();
  }

  Future<int> editGroup(BuildContext context, int groupId,
      Map<String, dynamic> updatedData) async {
    var token2 =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';
    Map<String, String> headers = {
      'Authorization': 'Bearer $token2',
      'Content-Type': 'application/json',
    };

    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/groups/patch_update/$groupId/'),
      headers: headers,
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      final updatedGroup = ListGroupsModel.fromJson(json.decode(response.body));
      _groups = _groups.map((group) {
        return group.id == groupId ? updatedGroup : group;
      }).toList();
      getGroupById(groupId);
      print(response.statusCode);
      print(response.body);
      notifyListeners();
    } else if (response.statusCode == 403) {
      print(response.statusCode);
      print(response.body);
      _showErrorDialog(context, response.statusCode, response.body);
    }
    return response.statusCode;
  }
}

void _showErrorDialog(
    BuildContext context, int statusCode, String responseBody) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('u can not edit this info'),
      content: Text(responseBody),
      actions: <Widget>[
        TextButton(
          child: Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
