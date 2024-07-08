//
// import 'dart:convert';
// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import'package:provider/provider.dart';
// class SchedualData extends ChangeNotifier {
//
//
//   List<Map<String, dynamic>> listScheduledetails = [];
//
//
//
//
//
//
//
//   static final Map<String, String> headers = {
//     "Content-Type": "application/json",
//   };
//
//   static final String baseUrl = 'http://$serverIP/';
//   static const localIp = 'localhost:8000';
//
//   //ToDo Change the IP before going LIVE
//   static const serverIP = localIp;
//
//   static Future<http.Response?> postRequest(String apiUrl,
//       Map<String, String> headers, Map<dynamic, dynamic> body) async {
//     try {
//       final res = await http.post(Uri.parse(baseUrl + apiUrl),
//           headers: headers, body: jsonEncode(body));
//       print('Response status: ${res.statusCode}');
//       print('Response body: ${res.body}');
//       return res;
//     } catch (error) {
//       print('Error in post request');
//       print('Error in post request');
//       print('Error in post request');
//       print('Error in post request');
//       print('Error in post request');
//       print('Error in post request');
//       print('Error in post request');
//       print(error);
//     }
//     return null;
//   }
//
//   // dont forget to change the post in line 44 to get and change the provided error cases
//   static Future<http.Response?> getRequest(
//       String apiUrl,
//       Map<String, String> headers,
//       ) async {
//     final res = await http
//         .get(Uri.parse(baseUrl + apiUrl), headers: headers
//       // , body: jsonEncode(body)
//     )
//         .then((value) {
//       print(value.statusCode);
//       print(value.body);
//       return value;
//     }).catchError((error) {
//       print(error);
//       return error;
//     });
//     return res;
//   }
//
//   static Future<http.Response?> deleteRequest(
//       String apiUrl, Map<String, String> headers) async {
//     try {
//       final response = await http.delete(
//         Uri.parse(baseUrl + apiUrl),
//         headers: headers,
//       );
//       print(response.statusCode);
//       print(response.body);
//       return response;
//     } catch (error) {
//       print('Error in HTTP DELETE request: $error');
//       return null;
//     }
//   }
//
//   static Future<http.Response?> putRequest(String apiUrl,
//       Map<String, String> headers, Map<dynamic, dynamic> body) async {
//     try {
//       final response = await http.put(
//         Uri.parse(baseUrl + apiUrl),
//         headers: headers,
//         body: jsonEncode(body),
//       );
//       print(response.statusCode);
//       print(response.body);
//       return response;
//     } catch (error) {
//       print('Error in HTTP PUT request: $error');
//       return null;
//     }
//   }
//
//   static Future<http.Response?> patchRequest(String apiUrl,
//       Map<String, String> headers, Map<dynamic, dynamic> body) async {
//     try {
//       final response = await http.patch(
//         Uri.parse(baseUrl + apiUrl),
//         headers: headers,
//         body: jsonEncode(body),
//       );
//       print(response.statusCode);
//       print(response.body);
//       return response;
//     } catch (error) {
//       print('Error in HTTP PATCH request: $error');
//       return null;
//     }
//   }
//
//
//
//
//
//    Future<bool> addSchedule(
//       String title,
//       String day,
//       TimeOfDay startTime,
//       TimeOfDay endTime,
//       String description,
//       int reminderTime,
//       String color,
//       String accessToken) async {
//     try {
//       // Define your headers including the access token
//       Map<String, String> headers = {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       };
//
//       String timeOfDayToString(TimeOfDay time) {
//         return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
//       }
//
//       String startTimeStr = timeOfDayToString(startTime);
//       String endTimeStr = timeOfDayToString(endTime);
//
//       // Prepare your request body
//       Map<String, dynamic> body = {
//         'title': title,
//         'day': day,
//         'start_time': startTimeStr, // Use converted string here
//         'end_time': endTimeStr, // Use converted string here
//         'description': description,
//         'reminder_time': reminderTime,
//         'color': color,
//       };
//
//       // Make the PATCH request
//       String api = 'schedules/';
//       var response = await postRequest(api, headers, body);
//
//       // Check the response status code
//       if (response != null &&
//           (response.statusCode == 200 || response.statusCode == 201)) {
//         // Status update successful
//         print('Add To Schedule successful');
//         notifyListeners();
//         return true;
//       } else {
//         // Status update failed
//         print(
//             'Add To Schedule failed with status code: ${response!.statusCode}');
//         return false;
//       }
//     } catch (error) {
//       // Exception occurred during HTTP request
//       print('Error during Add To Schedule Status: $error');
//       return false;
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> listSchedule(String accessToken) async {
//     try {
//       Map<String, String> headers = {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       };
//       String api = 'schedules/';
//       var response = await getRequest(api, headers);
//       print('Request sent to $api');
//
//       if (response != null &&
//           (response.statusCode == 200 || response.statusCode == 201)) {
//         List<dynamic> jsonData = jsonDecode(response.body);
//
//         for (dynamic map in jsonData) {
//           listScheduledetails.add({
//             'id': map['id'],
//             'title': map['title'],
//             'day': map['day'],
//             'start_time': map['start_time'],
//             'end_time': map['end_time'],
//             'description': map['description'],
//             'reminder_time': map['reminder_time'],
//             'color': map['color'],
//             'user': map['user'],
//           });
//         }
//
//         print('Schedules returned successfully');
//         return listScheduledetails;
//       } else {
//         print('Failed to fetch schedules');
//         return [];
//       }
//     } catch (error) {
//       print('Error fetching schedules: $error');
//       return [];
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> DeleteSlot(
//       int slotid, String accessToken) async {
//     try {
//       Map<String, String> headers = {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       };
//       String api = 'schedules/$slotid/';
//       var response = await deleteRequest(api, headers);
//
//       if (response != null &&
//           (response.statusCode == 200 ||
//               response.statusCode == 201 ||
//               response.statusCode == 204)) {
//         // Print the response body to understand its structure
//         print('Response body: ${response.body}');
//
//         // Parse JSON response body
//         List<dynamic> jsonData = jsonDecode(response.body);
//         print('Decoded JSON data: $jsonData');
//
//         // Remove the task from _todoList by matching the task ID
//         jsonData.forEach((map) {
//           if (map is Map<String, dynamic>) {
//             listScheduledetails.removeWhere((task) => task['id'] == map['id']);
//           } else {
//             print('Unexpected item in jsonData: $map');
//           }
//         });
//
//
//         print("00000000000000000000000000000");
//         print('Schedules Slot removed successfully');
//         return listScheduledetails;
//       } else {
//         print('Schedules Slot failed');
//         return [];
//       }
//     } catch (error) {
//       print('Delete error: Schedules Slot: $error');
//       return [];
//     }
//   }
//
//   Future<bool> UpdateSlot(
//       int slotid,
//       String title,
//       String day,
//       String startTime,
//       String endTime,
//       String? description,
//       int? reminderTime,
//       String color,
//       String accessToken,
//       ) async {
//     try {
//       // Define your headers including the access token
//       Map<String, String> headers = {
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       };
//
//       // Prepare your request body
//       Map<String, dynamic> body = {
//         'title': title,
//         'day': day,
//         'start_time': startTime,
//         'end_time': endTime,
//         'description': description,
//         'reminder_time': reminderTime,
//         'color': color,
//       };
//
//       // Make the PUT request
//       String api = 'schedules/$slotid/';
//       var response = await putRequest(api, headers, body);
//
//       // Check the response status code
//       if (response != null &&
//           (response.statusCode == 200 || response.statusCode == 201)) {
//         // Slot update successful
//         print('Update Slot successful');
//         return true;
//       } else {
//         // Slot update failed
//         print('Update Slot failed with status code: ${response!.statusCode}');
//         return false;
//       }
//     } catch (error) {
//       // Exception occurred during HTTP request
//       print('Error during Update Slot: $error');
//       return false;
//     }
//   }
//
// }