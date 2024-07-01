// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> joinGroup({
//   required int groupId,
//   required String accessToken,
//   String? password,
// }) async {
//   final url = Uri.parse('http://10.0.2.2:8000/groups/$groupId/join/');
  
//   // Create the headers
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $accessToken',
//   };
  
//   // Create the body
//   Map<String, dynamic> body = {};
//   if (password != null && password.isNotEmpty) {
//     body['password'] = password;
//   }
  
//   // Send the POST request
//   final response = await http.post(
//     url,
//     headers: headers,
//     body: json.encode(body),
//   );
  
//   // Check the response status
//   if (response.statusCode == 200) {
//     print('Successfully joined the group');
//   } else {
//     print('Failed to join the group: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }
// }
