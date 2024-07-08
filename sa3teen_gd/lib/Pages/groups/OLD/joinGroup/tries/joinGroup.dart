// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class JoinGroupPage extends StatelessWidget {
//   final int groupId;
//   final String accessToken;
//   final bool isPrivate;
//   final TextEditingController passwordController = TextEditingController();

//   JoinGroupPage({
//     required this.groupId,
//     required this.accessToken,
//     this.isPrivate = false,
//   });

//   Future<void> joinGroup(int groupId,String accessToken,{String? password}) async {
//     final url = Uri.parse('http://10.0.2.2:8000/groups/$groupId/join/');
    
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $accessToken',
//     };
    
//     Map<String, dynamic> body = {};
//     if (password != null && password.isNotEmpty) {
//       body['password'] = password;
//     }
    
//     final response = await http.post(
//       url,
//       headers: headers,
//       body: json.encode(body),
//     );
    
//     if (response.statusCode == 200) {
//       print('Successfully joined the group');
//     } else {
//       print('Failed to join the group: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Join Group'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (isPrivate)
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final password = isPrivate ? passwordController.text : null;
//                 joinGroup(password: password);
//               },
//               child: Text('Join Group'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: JoinGroupPage(
//       groupId: 7,
//       accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
//       isPrivate: true, // Set to false if the group is public
//     ),
//   ));
// }
