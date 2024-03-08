import 'package:flutter/cupertino.dart';

import 'Chat Bot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];
  bool _isUserMessage = true; // Variable to track whether the message is from the user

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) { // Check if the text is not empty
      _controller.clear();
      setState(() {
        messages.insert(0, text);
        _isUserMessage = true; // New message is from the user
      });
      // Call a function to handle the submitted message here
      // For example, you can call a function to send the message to the ChatGPT model
      // and receive a response.
    }
  }
}


Future<void> sendData() async {
  final Map<String, dynamic> requestData = {'text': 'Hello from Flutter!'};

  final response = await http.post(
    'http://your-django-server/api/receive-input/' as Uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData); // Handle the response as needed
  } else {
    print('Failed to send data. Error ${response.statusCode}');
  }
}






































//
// void fetchData() async {
//   // Replace the URL with your API endpoint
//   final url = Uri.parse('https://api.example.com/data');
//
//   try {
//     // Make a GET request
//     final response = await http.get(url);
//
//     // Check if the request was successful
//     if (response.statusCode == 200) {
//       // Decode the response JSON
//       final jsonData = json.decode(response.body);
//
//       // Process the data
//       print(jsonData);
//     } else {
//       // Handle error
//       print('Request failed with status: ${response.statusCode}');
//     }
//   } catch (error) {
//     // Handle network errors
//     print('Network error: $error');
//   }
// }
