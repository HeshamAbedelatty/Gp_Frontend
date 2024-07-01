import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
//get function from tharwat samy
class Api {
  Future<List<dynamic>> get({required String url, Map<String, String>? headers}) async {
    var response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
 Future<dynamic> anotherget({required String url, Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

}
  Future<void> joinGroup(int groupId,String accessToken,String? password) async {
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
    // Successfully unjoined the group
    print('Successfully unjoined the group');
  } else {
    // Failed to unjoin the group
    print('Failed to unjoin the group: ${response.statusCode}');
  }
}


// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class Api {
//   Future<dynamic> get({required String url, @required String? token}) async {
//     Map<String, String> headers = {};

//     if (token != null) {
//       headers.addAll({'Authorization': 'Bearer $token'});
//     }
//     http.Response response = await http.get(Uri.parse(url), headers: headers);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception(
//           'there is a problem with status code ${response.statusCode}');
//     }
//   }

//   Future<dynamic> post(
//       {required String url,
//       @required dynamic body,
//       @required String? token}) async {
//     Map<String, String> headers = {};

//     if (token != null) {
//       headers.addAll({'Authorization': 'Bearer $token'});
//     }
//     http.Response response =
//         await http.post(Uri.parse(url), body: body, headers: headers);
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);

//       return data;
//     } else {
//       throw Exception(
//           'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
//     }
//   }

//   Future<dynamic> put(
//       {required String url,
//       @required dynamic body,
//       @required String? token}) async {
//     Map<String, String> headers = {};
//     headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
//     if (token != null) {
//       headers.addAll({'Authorization': 'Bearer $token'});
//     }

//     print('url = $url body = $body token = $token ');
//     http.Response response =
//         await http.put(Uri.parse(url), body: body, headers: headers);
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       print(data);
//       return data;
//     } else {
//       throw Exception(
//           'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
//     }
//   }
// }

// class Api {
//   Future<dynamic> get({required String url, 
//   // String? token
//   }) async {
//     Map<String, String> headers = {};

//     // if (token != null) {
//     //   headers.addAll({'Authorization': 'Bearer $token'});
//     // }

//     print('Sending GET request to $url with headers: $headers'); // Log the request

//     http.Response response = await http.get(Uri.parse(url), headers: headers);

//     print('Response status: ${response.statusCode}'); // Log the response status
//     print('Response body: ${response.body}'); // Log the response body

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception(
//           'There is a problem with status code ${response.statusCode}');
//     }
//   }
// }