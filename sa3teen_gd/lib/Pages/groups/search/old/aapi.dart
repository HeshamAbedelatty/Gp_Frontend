// import 'dart:convert';
// import 'package:http/http.dart' as http;
// class Group {
//   final int id;
//   final String title;
//   final String description;
//   final String type;
//   final String image;
//   final String? password;
//   final String subject;
//   final int members;

//   Group({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.type,
//     required this.image,
//     this.password,
//     required this.subject,
//     required this.members,
//   });

//   factory Group.fromJson(Map<String, dynamic> json) {
//     return Group(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       type: json['type'],
//       image: json['image'],
//       password: json['password'],
//       subject: json['subject'],
//       members: json['members'],
//     );
//   }
// }


// class ApiService {
//   static const String apiUrl = "http://10.0.2.2:8000/groups/search/";

//   Future<List<Group>> searchGroups(String title ,String token) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         // headers: {
//         'Authorization': 'Bearer $token',
//       // },
//       },
//       body: jsonEncode({"title": title}),
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       List<Group> groups = body.map((dynamic item) => Group.fromJson(item)).toList();
//       return groups;
//     } else {

//       throw Exception('Failed to load groups${response.statusCode}   ${response.body}');
//     }
//   }
// }
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'group_model.dart';

// class ApiService {
//   static const String baseUrl = "http://10.0.2.2:8000/groups/search/";

//   Future<List<Group>> searchGroups(String title, String accessToken) async {
//     final response = await http.get(
//       Uri.parse("$baseUrl?title=$title"),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       List<Group> groups = body.map((dynamic item) => Group.fromJson(item)).toList();
//       return groups;
//     } else {
//       throw Exception('Failed to load groups');
//     }
//   }
// }
