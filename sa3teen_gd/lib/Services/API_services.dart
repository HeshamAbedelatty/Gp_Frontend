import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import'package:http/http.dart'as http;
class Api_services{
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static final String baseUrl = 'http://' + serverIP + '/';
  static const localIp = 'localhost:8000';

  //ToDo Change the IP before going LIVE
  static const serverIP = localIp;

 static Future<http.Response?> postRequest(String apiUrl, Map<String, String> headers,
      Map<dynamic, dynamic> body) async {
   try {
     final res = await http
         .post(Uri.parse(baseUrl + apiUrl),headers: headers, body: jsonEncode(body));
     print ('Response status: ${res.statusCode}');
      print ('Response body: ${res.body}');
     return res;
    } catch (error) {
     print ('Error in post request');
     print ('Error in post request');
     print ('Error in post request');
     print ('Error in post request');
     print ('Error in post request');
     print ('Error in post request');
     print ('Error in post request');
      print(error);
   }
  }





  static Future<http.Response?> getRequest(String apiUrl, Map<String, String> headers,
      Map<dynamic, dynamic> body) async {
    final res = await http
        .post(Uri.parse(baseUrl + apiUrl),
        headers: headers, body: jsonEncode(body))
        .then((value) {
      print(value.statusCode);
      print(value.body);
      return value;
    }).catchError((error) {
      print(error);
      return error;
    });
    return res;
  }



// get methood
// static login(String userName, String password) async {
//     String api = 'api/login/';
//     return await postRequest(api, headers, {
//       'username': userName.trim(),
//       'password': password,
//
//     });
//   }















  static Future<bool> login(String email, String password) async {
    try {
      final response = await postRequest('login/', headers, {
        'username': email.trim(),
        'password': password,
      });

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        // Login successful
        print('Login successful');
        return true;
      } else {
        // Login failed
        print('Login failed');
        return false;
      }
    } catch (error) {
      // Exception occurred during login request
      print('Error during login: $error');
      return false;
    }
  }





  //post methood
  static sginup(String first_name,String last_name, String user_name ,String email,String password , String confirm_pasword,String phoneNumber) async{
   String api = 'signup/';
     var response= await postRequest(api, headers, {
        'first_name': first_name,
        'last_name': last_name,
       'username': user_name,
       'phone_number':phoneNumber.trim(),
       'email':email.trim(),
       'password':password,
       'password_confirm': confirm_pasword
      });
     if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
       // Login successful
       print('Sign up successful');
       return true;
     } else {
       // Login failed
       print('Sign up failed');
       return false;
     }
  }
}