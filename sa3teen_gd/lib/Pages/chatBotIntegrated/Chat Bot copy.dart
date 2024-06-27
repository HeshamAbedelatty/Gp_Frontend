import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Django Integration Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) async {
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _messages.insert(0, 'Me: $text');
      });

      // Send the message to the backend
      var response = await _sendMessageToBackend(text);
      if (response != null) {
        setState(() {
          _messages.insert(0, 'Bot: $response');
        });
      } else {
        setState(() {
          _messages.insert(0, 'Bot: Error receiving response');
        });
      }
    }
  }

  Future<dynamic?> _sendMessageToBackend(String message) async {
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/tg/'),
      body: {
        'user_text': message,
      },
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    // var url = Uri.parse('http://127.0.0.1:8000/tg/'); // Change to your server IP if not using emulator
    try {
      print('Sending message to backend: $message'); // Log message
      // var response = await http.post(
      //   url,
      //   headers: {
      //     'Content-Type': 'application/x-www-form-urlencoded',
      //   },
      //   body: {
      //     'user_text': message,
      //   },
      // );
      print('Response status: ${response.statusCode}'); // Log status code
      print('Response body: ${response.body}'); // Log response body
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Request sucsses with status: ${response.statusCode}');
        return jsonResponse['response'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
    return null;
  }

  Widget _buildMessageItem(String message) {
    bool isUserMessage = message.startsWith('Me: ');
    Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildMessageItem(_messages[index]);
      },
    );
  }

  Widget _buildTextComposer() {
    return Container(
      decoration: BoxDecoration(border: Border.symmetric(),borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Send a message',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon:  Icon(Icons.send,color: Colors.brown.shade200,),
              onPressed: () => _handleSubmitted(_controller.text),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

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
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _messages = [];

//   void _handleSubmitted(String text) async {
//     if (text.isNotEmpty) {
//       _controller.clear();
//       setState(() {
//         _messages.insert(0, 'Me: $text');
//       });

//       // Send the message to the backend
//       var response = await _sendMessageToBackend(text);
//       if (response != null) {
//         setState(() {
//           _messages.insert(0, 'Bot: $response');
//         });
//       } else {
//         setState(() {
//           _messages.insert(0, 'Bot: Error receiving response');
//         });
//       }
//     }
//   }

//   Future<String?> _sendMessageToBackend(String message) async {
//     var url = Uri.parse('http://10.0.2.2:8000/tg/'); // Change to your server IP if not using emulator
//     try {
//       print('Sending message to backend: $message'); // Log message
//       var response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'user_text': message,
//         },
//       );
//       print('Response status: ${response.statusCode}'); // Log status code
//       print('Response body: ${response.body}'); // Log response body
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         return jsonResponse['response'];
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//     return null;
//   }

//   Widget _buildMessageItem(String message) {
//     bool isUserMessage = message.startsWith('Me: ');
//     Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//       decoration: BoxDecoration(
//         color: bubbleColor,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: ListTile(
//         title: Text(
//           message,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 20.0,
//           ),
//         ),
//         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     return ListView.builder(
//       reverse: true,
//       itemCount: _messages.length,
//       itemBuilder: (BuildContext context, int index) {
//         return _buildMessageItem(_messages[index]);
//       },
//     );
//   }

//   Widget _buildTextComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: TextField(
//               controller: _controller,
//               onSubmitted: _handleSubmitted,
//               decoration: const InputDecoration.collapsed(
//                 hintText: 'Send a message',
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: IconButton(
//               icon: const Icon(Icons.send),
//               onPressed: () => _handleSubmitted(_controller.text),
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat with Django Bot'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           _buildTextComposer(),
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
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: ChatScreen(),
// //     );
// //   }
// // }

// // class ChatScreen extends StatefulWidget {
// //   const ChatScreen({Key? key}) : super(key: key);

// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }

// // class _ChatScreenState extends State<ChatScreen> {
// //   final TextEditingController _controller = TextEditingController();
// //   final List<String> _messages = [];

// //   void _handleSubmitted(String text) async {
// //     if (text.isNotEmpty) {
// //       _controller.clear();
// //       setState(() {
// //         _messages.insert(0, 'Me: $text');
// //       });

// //       // Send the message to the backend
// //       var response = await _sendMessageToBackend(text);
// //       if (response != null) {
// //         setState(() {
// //           _messages.insert(0, 'Bot: $response');
// //         });
// //       } else {
// //         setState(() {
// //           _messages.insert(0, 'Bot: Error receiving response');
// //         });
// //       }
// //     }
// //   }

// //   Future<String?> _sendMessageToBackend(String message) async {
// //     var url = Uri.parse('http://10.0.2.2:8000/tg/'); // Change to your server IP if not using emulator
// //     try {
// //       var response = await http.post(
// //         url,
// //         headers: {
// //           'Content-Type': 'application/x-www-form-urlencoded',
// //         },
// //         body: {
// //           'user_text': message,
// //         },
// //       );
// //       print('Response status: ${response.statusCode}'); // Log status code
// //       print('Response body: ${response.body}'); // Log response body
// //       if (response.statusCode == 200) {
// //         var jsonResponse = jsonDecode(response.body);
// //         return jsonResponse['response'];
// //       } else {
// //         print('Request failed with status: ${response.statusCode}');
// //         print('Response body: ${response.body}');
// //       }
// //     } catch (e) {
// //       print('Error sending message: $e');
// //     }
// //     return null;
// //   }

// //   Widget _buildMessageItem(String message) {
// //     bool isUserMessage = message.startsWith('Me: ');
// //     Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

// //     return Container(
// //       margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// //       decoration: BoxDecoration(
// //         color: bubbleColor,
// //         borderRadius: BorderRadius.circular(8.0),
// //       ),
// //       child: ListTile(
// //         title: Text(
// //           message,
// //           style: const TextStyle(
// //             color: Colors.black,
// //             fontSize: 20.0,
// //           ),
// //         ),
// //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// //       ),
// //     );
// //   }

// //   Widget _buildMessageList() {
// //     return ListView.builder(
// //       reverse: true,
// //       itemCount: _messages.length,
// //       itemBuilder: (BuildContext context, int index) {
// //         return _buildMessageItem(_messages[index]);
// //       },
// //     );
// //   }

// //   Widget _buildTextComposer() {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// //       child: Row(
// //         children: <Widget>[
// //           Flexible(
// //             child: TextField(
// //               controller: _controller,
// //               onSubmitted: _handleSubmitted,
// //               decoration: const InputDecoration.collapsed(
// //                 hintText: 'Send a message',
// //               ),
// //             ),
// //           ),
// //           Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// //             child: IconButton(
// //               icon: const Icon(Icons.send),
// //               onPressed: () => _handleSubmitted(_controller.text),
// //               color: Theme.of(context).colorScheme.primary,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Chat with Django Bot'),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: _buildMessageList(),
// //           ),
// //           _buildTextComposer(),
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
// // //   const ChatScreen({Key? key}) : super(key: key);

// // //   @override
// // //   _ChatScreenState createState() => _ChatScreenState();
// // // }

// // // class _ChatScreenState extends State<ChatScreen> {
// // //   final TextEditingController _controller = TextEditingController();
// // //   final List<String> _messages = [];

// // //   void _handleSubmitted(String text) async {
// // //     if (text.isNotEmpty) {
// // //       _controller.clear();
// // //       setState(() {
// // //         _messages.insert(0, 'Me: $text');
// // //       });

// // //       // Send the message to the backend
// // //       var response = await _sendMessageToBackend(text);
// // //       if (response != null) {
// // //         setState(() {
// // //           _messages.insert(0, 'Bot: $response');
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<String?> _sendMessageToBackend(String message) async {
// // //     var url = Uri.parse('http://10.0.2.2:8000/tg/'); // Change to your server IP if not using emulator
// // //     try {
// // //       var response = await http.post(
// // //         url,
// // //         headers: {
// // //           'Content-Type': 'application/x-www-form-urlencoded',
// // //         },
// // //         body: {
// // //           'user_text': message,
// // //         },
// // //       );
// // //       if (response.statusCode == 200) {
// // //         var jsonResponse = jsonDecode(response.body);
// // //         return jsonResponse['response'];
// // //       } else {
// // //         print('Request failed with status: ${response.statusCode}');
// // //         print('Response body: ${response.body}');
// // //       }
// // //     } catch (e) {
// // //       print('Error sending message: $e');
// // //     }
// // //     return null;
// // //   }

// // //   Widget _buildMessageItem(String message) {
// // //     bool isUserMessage = message.startsWith('Me: ');
// // //     Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

// // //     return Container(
// // //       margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // //       decoration: BoxDecoration(
// // //         color: bubbleColor,
// // //         borderRadius: BorderRadius.circular(8.0),
// // //       ),
// // //       child: ListTile(
// // //         title: Text(
// // //           message,
// // //           style: const TextStyle(
// // //             color: Colors.black,
// // //             fontSize: 20.0,
// // //           ),
// // //         ),
// // //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMessageList() {
// // //     return ListView.builder(
// // //       reverse: true,
// // //       itemCount: _messages.length,
// // //       itemBuilder: (BuildContext context, int index) {
// // //         return _buildMessageItem(_messages[index]);
// // //       },
// // //     );
// // //   }

// // //   Widget _buildTextComposer() {
// // //     return Container(
// // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // //       child: Row(
// // //         children: <Widget>[
// // //           Flexible(
// // //             child: TextField(
// // //               controller: _controller,
// // //               onSubmitted: _handleSubmitted,
// // //               decoration: const InputDecoration.collapsed(
// // //                 hintText: 'Send a message',
// // //               ),
// // //             ),
// // //           ),
// // //           Container(
// // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // //             child: IconButton(
// // //               icon: const Icon(Icons.send),
// // //               onPressed: () => _handleSubmitted(_controller.text),
// // //               color: Theme.of(context).colorScheme.primary,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Chat with Django Bot'),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: _buildMessageList(),
// // //           ),
// // //           _buildTextComposer(),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'dart:convert';

// // // // class ChatScreen extends StatefulWidget {
// // // //   const ChatScreen({Key? key}) : super(key: key);

// // // //   @override
// // // //   _ChatScreenState createState() => _ChatScreenState();
// // // // }

// // // // class _ChatScreenState extends State<ChatScreen> {
// // // //   final TextEditingController _controller = TextEditingController();
// // // //   final List<String> _messages = [];

// // // //   void _handleSubmitted(String text) async {
// // // //     if (text.isNotEmpty) {
// // // //       _controller.clear();
// // // //       setState(() {
// // // //         _messages.insert(0, 'Me: $text');
// // // //       });

// // // //       // Send the message to the backend
// // // //       var response = await _sendMessageToBackend(text);
// // // //       if (response != null) {
// // // //         setState(() {
// // // //           _messages.insert(0, 'Bot: $response');
// // // //         });
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<String?> _sendMessageToBackend(String message) async {
// // // //     var url = Uri.parse('http://10.0.2.2:8000/tg/'); // Change to your server IP if not using emulator
// // // //     try {
// // // //       var response = await http.post(
// // // //         url,
// // // //         headers: {
// // // //           'Content-Type': 'application/x-www-form-urlencoded',
// // // //         },
// // // //         body: {
// // // //           'user_text': message,
// // // //         },
// // // //       );
// // // //       if (response.statusCode == 200) {
// // // //         var jsonResponse = jsonDecode(response.body);
// // // //         return jsonResponse['response'];
// // // //       } else {
// // // //         print('Request failed with status: ${response.statusCode}');
// // // //         print('Response body: ${response.body}');
// // // //       }
// // // //     } catch (e) {
// // // //       print('Error sending message: $e');
// // // //     }
// // // //     return null;
// // // //   }

// // // //   Widget _buildMessageItem(String message) {
// // // //     bool isUserMessage = message.startsWith('Me: ');
// // // //     Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

// // // //     return Container(
// // // //       margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // // //       decoration: BoxDecoration(
// // // //         color: bubbleColor,
// // // //         borderRadius: BorderRadius.circular(8.0),
// // // //       ),
// // // //       child: ListTile(
// // // //         title: Text(
// // // //           message,
// // // //           style: const TextStyle(
// // // //             color: Colors.black,
// // // //             fontSize: 20.0,
// // // //           ),
// // // //         ),
// // // //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMessageList() {
// // // //     return ListView.builder(
// // // //       reverse: true,
// // // //       itemCount: _messages.length,
// // // //       itemBuilder: (BuildContext context, int index) {
// // // //         return _buildMessageItem(_messages[index]);
// // // //       },
// // // //     );
// // // //   }

// // // //   Widget _buildTextComposer() {
// // // //     return Container(
// // // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // // //       child: Row(
// // // //         children: <Widget>[
// // // //           Flexible(
// // // //             child: TextField(
// // // //               controller: _controller,
// // // //               onSubmitted: _handleSubmitted,
// // // //               decoration: const InputDecoration.collapsed(
// // // //                 hintText: 'Send a message',
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Container(
// // // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // // //             child: IconButton(
// // // //               icon: const Icon(Icons.send),
// // // //               onPressed: () => _handleSubmitted(_controller.text),
// // // //               color: Theme.of(context).colorScheme.primary,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text('Chat with ChatGPT'),
// // // //       ),
// // // //       body: Column(
// // // //         children: [
// // // //           Expanded(
// // // //             child: _buildMessageList(),
// // // //           ),
// // // //           _buildTextComposer(),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // import 'package:flutter/material.dart';

// // // // // // el appbar
// // // // // class ChatScreen extends StatefulWidget {
// // // // //   const ChatScreen({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   _ChatScreenState createState() => _ChatScreenState();
// // // // // }

// // // // // class _ChatScreenState extends State<ChatScreen> {
// // // // //   final TextEditingController _controller = TextEditingController();
// // // // //   final List<String> _messages = [];
// // // // //   bool _isUserMessage = true; // Variable to track whether the message is from the user

// // // // //   void _handleSubmitted(String text) {
// // // // //     if (text.isNotEmpty) {
// // // // //       _controller.clear();
// // // // //       setState(() {
// // // // //         _messages.insert(0, text);
// // // // //         _isUserMessage = true;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   Widget _buildMessageItem(String message, bool isUserMessage) {
// // // // //     Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

// // // // //     return Container(
// // // // //       margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // // // //       decoration: BoxDecoration(
// // // // //         color: bubbleColor,
// // // // //         borderRadius: BorderRadius.circular(8.0),
// // // // //       ),
// // // // //       child: ListTile(
// // // // //         title: Text(
// // // // //           message,
// // // // //           style: const TextStyle(
// // // // //             color: Colors.black,
// // // // //             fontSize: 20.0,
// // // // //           ),
// // // // //         ),
// // // // //         contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMessageList() {
// // // // //     return ListView.builder(
// // // // //       reverse: true,
// // // // //       itemCount: _messages.length,
// // // // //       itemBuilder: (BuildContext context, int index) {
// // // // //         final bool isUserMessage = index % 2 == 0;
// // // // //         return _buildMessageItem(_messages[index], isUserMessage);
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTextComposer() {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // //       child: Row(
// // // // //         children: <Widget>[
// // // // //           Flexible(
// // // // //             child: TextField(
// // // // //               controller: _controller,
// // // // //               onSubmitted: _handleSubmitted,
// // // // //               decoration: const InputDecoration.collapsed(
// // // // //                 hintText: 'Send a message',
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           Container(
// // // // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // // // //             child: IconButton(
// // // // //               icon: const Icon(Icons.send),
// // // // //               onPressed: () => _handleSubmitted(_controller.text),
// // // // //               color: Theme.of(context).colorScheme.primary,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text('Chat with ChatGPT'),
// // // // //       ),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           Expanded(
// // // // //             child: _buildMessageList(),
// // // // //           ),
// // // // //           _buildTextComposer(),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
