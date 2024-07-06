import 'dart:convert';

import 'package:http/http.dart' as http;

//get function from tharwat samy
class Api {
  Future<List<dynamic>> get(
      {required String url, Map<String, String>? headers}) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> anotherget(
      {required String url, Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
      // throw Exception('Failed to load data');
    }
  }
}

Future<void> joinGroup(
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

  if (response.statusCode == 200) {
    print('Successfully joined the group');
  } else {
    print('Failed to join the group: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

Future<Map<String, dynamic>> post({
  required String url,
  required Map<String, dynamic> body,
  Map<String, String>? headers,
}) async {
  headers ??= {};
  headers.addAll({'Content-Type': 'application/json'});

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: json.encode(body),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to post data: ${response.statusCode}');
  }
}

Future<void> unjoinGroup(int groupId, String token) async {
  final url = Uri.parse('http://10.0.2.2:8000/groups/$groupId/unjoin/');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print('Successfully unjoined the group');
  } else {
    print('Failed to unjoin the group: ${response.statusCode}');
  }
}
