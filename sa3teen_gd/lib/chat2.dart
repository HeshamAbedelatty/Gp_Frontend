// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Django Integration Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController _controller = TextEditingController();
//   List<String> messages = [];

//   void _sendMessage(String message) async {
//     var url = Uri.parse('http://10.0.2.2:8000/tg/'); // Change to your server IP if not using emulator
//     print('Sending message: $message to $url');
//     try {
//       var response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'user_text': message,
//         },
//       );
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         setState(() {
//           messages.add('Me: $message');
//           messages.add('Bot: ${jsonResponse['response']}');
//         });
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Django Bot'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(messages[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_controller.text.isNotEmpty) {
//                       _sendMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Django Integration Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.red,
// //       ),
// //       home: ChatScreen(),
// //     );
// //   }
// // }

// // class ChatScreen extends StatefulWidget {
// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }

// // class _ChatScreenState extends State<ChatScreen> {
// //   TextEditingController _controller = TextEditingController();
// //   List<String> messages = [];

// //   // void _sendMessage(String message) async {
// //   //   var url = Uri.parse('http://127.0.0.1:8000/tg/');
// //   //   try {
// //   //     var response = await http.post(
// //   //       url,
// //   //       headers: {
// //   //         'Content-Type': 'application/x-www-form-urlencoded',
// //   //       },
// //   //       body: {
// //   //         'user_text': message,
// //   //       },
// //   //     );
// //   //     if (response.statusCode == 200) {
// //   //       var jsonResponse = jsonDecode(response.body);
// //   //       setState(() {
// //   //         messages.add(message);
// //   //         messages.add(jsonResponse['response']);
// //   //       });
// //   //     } else {
// //   //       print('Request failed with status: ${response.statusCode}');
// //   //       print('Response body: ${response.body}');
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error sending message: $e');
// //   //   }
// //   // }

// // // void _sendMessage(String message) async {
// // //   var url = Uri.parse('http://127.0.0.1:8000/tg/');
// // //   try {
// // //     var response = await http.post(
// // //       url,
// // //       headers: {
// // //         'Content-Type': 'application/x-www-form-urlencoded',
// // //       },
// // //       body: {
// // //         'user_text': message,
// // //       },
// // //     );
// // //     if (response.statusCode == 200) {
// // //       var jsonResponse = jsonDecode(response.body);
// // //       setState(() {
// // //         messages.add(message);
// // //         messages.add(jsonResponse['response']);
// // //       });
// // //     } else {
// // //       print('Request failed with status: ${response.statusCode}');
// // //       print('Response body: ${response.body}');
// // //     }
// // //   } catch (e) {
// // //     print('Error sending message: $e');
// // //   }
// // // }
// // void _sendMessage(String message) async {
// //   var url = Uri.parse('http://192.168.1.100:8000/tg/');
// //   try {
// //     var response = await http.post(
// //       url,
// //       headers: {
// //         'Content-Type': 'application/x-www-form-urlencoded',
// //       },
// //       body: {
// //         'user_text': message,
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       var jsonResponse = jsonDecode(response.body);
// //       setState(() {
// //         messages.add(message);
// //         messages.add(jsonResponse['response']);
// //       });
// //     } else {
// //       print('Request failed with status: ${response.statusCode}');
// //       print('Response body: ${response.body}');
// //     }
// //   } catch (e) {
// //     print('Error sending message: $e');
// //   }
// // }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Chat with Django Bot'),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: messages.length,
// //               itemBuilder: (context, index) {
// //                 return ListTile(
// //                   title: Text(messages[index]),
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: Row(
// //               children: <Widget>[
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _controller,
// //                     decoration: InputDecoration(
// //                       hintText: 'Enter your message...',
// //                     ),
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.send),
// //                   onPressed: () {
// //                     if (_controller.text.isNotEmpty) {
// //                       _sendMessage(_controller.text);
// //                       _controller.clear();
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Django Integration Demo',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.blue,
// // //       ),
// // //       home: ChatScreen(),
// // //     );
// // //   }
// // // }

// // // class ChatScreen extends StatefulWidget {
// // //   @override
// // //   _ChatScreenState createState() => _ChatScreenState();
// // // }

// // // class _ChatScreenState extends State<ChatScreen> {
// // //   TextEditingController _controller = TextEditingController();
// // //   List<String> messages = [];

// // //   // void _sendMessage(String message) async {
// // //   //   var url = 'http://your-django-backend-url/bot_response/';
// // //   //   try {
// // //   //     var response = await http.post(url, body: {'user_text': message});
// // //   //     if (response.statusCode == 200) {
// // //   //       var jsonResponse = jsonDecode(response.body);
// // //   //       setState(() {
// // //   //         messages.add(message);
// // //   //         messages.add(jsonResponse['response']);
// // //   //       });
// // //   //     } else {
// // //   //       print('Request failed with status: ${response.statusCode}');
// // //   //     }
// // //   //   } catch (e) {
// // //   //     print('Error sending message: $e');
// // //   //   }
// // //   // }

// // // void _sendMessage(String message) async {
// // //   var url = Uri.parse('http://your-django-backend-url/bot_response/');
// // //   try {
// // //     var response = await http.post(url, body: {'user_text': message});
// // //     if (response.statusCode == 200) {
// // //       var jsonResponse = jsonDecode(response.body);
// // //       setState(() {
// // //         messages.add(message);
// // //         messages.add(jsonResponse['response']);
// // //       });
// // //     } else {
// // //       print('Request failed with status: ${response.statusCode}');
// // //     }
// // //   } catch (e) {
// // //     print('Error sending message: $e');
// // //   }
// // // }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Chat with Django Bot'),
// // //       ),
// // //       body: Column(
// // //         children: <Widget>[
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: messages.length,
// // //               itemBuilder: (context, index) {
// // //                 return ListTile(
// // //                   title: Text(messages[index]),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: EdgeInsets.all(8.0),
// // //             child: Row(
// // //               children: <Widget>[
// // //                 Expanded(
// // //                   child: TextField(
// // //                     controller: _controller,
// // //                     decoration: InputDecoration(
// // //                       hintText: 'Enter your message...',
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 IconButton(
// // //                   icon: Icon(Icons.send),
// // //                   onPressed: () {
// // //                     if (_controller.text.isNotEmpty) {
// // //                       _sendMessage(_controller.text);
// // //                       _controller.clear();
// // //                     }
// // //                   },
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
