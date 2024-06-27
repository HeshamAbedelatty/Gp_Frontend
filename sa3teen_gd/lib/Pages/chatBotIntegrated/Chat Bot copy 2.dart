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
  final List<Map<String, dynamic>> _messages = [];

  void _handleSubmitted(String text) async {
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _messages.insert(0, {'sender': 'Me', 'text': text});
      });

      // Send the message to the backend
      var response = await _sendMessageToBackend(text);
      if (response != null) {
        setState(() {
          _messages.insert(0, {'sender': 'Bot', 'text': response});
        });
      } else {
        setState(() {
          _messages.insert(0, {'sender': 'Bot', 'text': 'Error receiving response'});
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
    try {
      print('Sending message to backend: $message'); // Log message
      
      print('Response status: ${response.statusCode}'); // Log status code
      print('Response body: ${response.body}'); // Log response body
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Request success with status: ${response.statusCode}');
        
        // Clean up the response text
        String cleanedResponse = jsonResponse['response']
          .replaceAll('\n', ' ')
          .replaceAll(RegExp(r'[^\w\s]+'), ''); // Remove special characters
        
        return cleanedResponse;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
    return null;
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    bool isUserMessage = message['sender'] == 'Me';
    Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;
    TextStyle? textStyle = isUserMessage ? TextStyle(color: Colors.black) : TextStyle(color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: Text(
            message['text'],
            style: textStyle,
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
      decoration: BoxDecoration(border: Border.symmetric(), borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.brown.shade200),
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
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
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
//   final List<Map<String, dynamic>> _messages = [];

//   void _handleSubmitted(String text) async {
//     if (text.isNotEmpty) {
//       _controller.clear();
//       setState(() {
//         _messages.insert(0, {'sender': 'Me', 'text': text});
//       });

//       // Send the message to the backend
//       var response = await _sendMessageToBackend(text);
//       if (response != null) {
//         setState(() {
//           _messages.insert(0, {'sender': 'Bot', 'text': response});
//         });
//       } else {
//         setState(() {
//           _messages.insert(0, {'sender': 'Bot', 'text': 'Error receiving response'});
//         });
//       }
//     }
//   }

//   Future<dynamic?> _sendMessageToBackend(String message) async {
//     http.Response response = await http.post(
//       Uri.parse('http://10.0.2.2:8000/tg/'),
//       body: {
//         'user_text': message,
//       },
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//     );
//     try {
//       print('Sending message to backend: $message'); // Log message
      
//       print('Response status: ${response.statusCode}'); // Log status code
//       print('Response body: ${response.body}'); // Log response body
//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         print('Request success with status: ${response.statusCode}');
        
//         // Clean up the response text
//         String cleanedResponse = jsonResponse['response']
//           .replaceAll('\n', ' ');
        
//         return cleanedResponse;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//     return null;
//   }

//   Widget _buildMessageItem(Map<String, dynamic> message) {
//     bool isUserMessage = message['sender'] == 'Me';
//     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;
//     TextStyle? textStyle = isUserMessage ? TextStyle(color: Colors.black) : TextStyle(color: Colors.black);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: bubbleColor,
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: ListTile(
//           title: Text.rich(
//             _formatMessageText(message['text']),
//             style: textStyle,
//           ),
//         ),
//       ),
//     );
//   }

//   TextSpan _formatMessageText(String message) {
//     List<TextSpan> spans = [];
//     RegExp exp = RegExp(r'(\*\*.*?\*\*\**)');
//     Iterable<RegExpMatch> matches = exp.allMatches(message);
//     int lastMatchEnd = 0;

//     for (var match in matches) {
//       if (match.start > lastMatchEnd) {
//         spans.add(TextSpan(text: message.substring(lastMatchEnd, match.start)));
//       }
//       spans.add(TextSpan(
//         text: message.substring(match.start + 2, match.end - 2),
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ));
//       lastMatchEnd = match.end;
//     }

//     if (lastMatchEnd < message.length) {
//       spans.add(TextSpan(text: message.substring(lastMatchEnd)));
//     }

//     return TextSpan(children: spans);
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
//       decoration: BoxDecoration(border: Border.symmetric(), borderRadius: BorderRadius.circular(20)),
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
//               icon: Icon(Icons.send, color: Colors.brown.shade200),
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
//       appBar: tabbar(),
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
// // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
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

// //   Future<dynamic?> _sendMessageToBackend(String message) async {
// //     http.Response response = await http.post(
// //       Uri.parse('http://10.0.2.2:8000/tg/'),
// //       body: {
// //         'user_text': message,
// //       },
// //       headers: {
// //         'Content-Type': 'application/x-www-form-urlencoded',
// //       },
// //     );
// //     try {
// //       print('Sending message to backend: $message'); // Log message
      
// //       print('Response status: ${response.statusCode}'); // Log status code
// //       print('Response body: ${response.body}'); // Log response body
// //       if (response.statusCode == 200) {
// //         var jsonResponse = jsonDecode(response.body);
// //         print('Request success with status: ${response.statusCode}');
        
// //         // Clean up the response text
// //         String cleanedResponse = jsonResponse['response']
// //           .replaceAll('**', '')
// //           .replaceAll('\n', ' ');
        
// //         return cleanedResponse;
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
// //     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: bubbleColor,
// //           borderRadius: BorderRadius.circular(30.0),
// //         ),
// //         child: ListTile(
// //           title: Text(
// //             message,
// //             style: const TextStyle(
// //               color: Colors.black,
// //               fontSize: 20.0,
// //             ),
// //           ),
// //         ),
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
// //       decoration: BoxDecoration(border: Border.symmetric(), borderRadius: BorderRadius.circular(20)),
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
// //               icon: Icon(Icons.send, color: Colors.brown.shade200),
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
// //       appBar: tabbar(),
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
// // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:convert';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
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
// // //       } else {
// // //         setState(() {
// // //           _messages.insert(0, 'Bot: Error receiving response');
// // //         });
// // //       }
// // //     }
// // //   }

// // //   Future<dynamic?> _sendMessageToBackend(String message) async {
// // //     http.Response response = await http.post(
// // //       Uri.parse('http://10.0.2.2:8000/tg/'),
// // //       body: {
// // //         'user_text': message,
// // //       },
// // //       headers: {
// // //         'Content-Type': 'application/x-www-form-urlencoded',
// // //       },
// // //     );
// // //     try {
// // //       print('Sending message to backend: $message'); // Log message
      
// // //       print('Response status: ${response.statusCode}'); // Log status code
// // //       print('Response body: ${response.body}'); // Log response body
// // //       if (response.statusCode == 200) {
// // //         var jsonResponse = jsonDecode(response.body);
// // //         print('Request sucsses with status: ${response.statusCode}');
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

// // //   String _convertMarkdownToPlainText(String markdownText) {
// // //     // Replace newline characters
// // //     String plainText = markdownText.replaceAll('\\n', '\n');
    
// // //     // Remove Markdown formatting symbols
// // //     plainText = plainText.replaceAll(RegExp(r'\*\*'), '');
// // //     plainText = plainText.replaceAll(RegExp(r'\*'), '');
    
// // //     return plainText;
// // //   }

// // //   Widget _buildMessageItem(String message) {
// // //     bool isUserMessage = message.startsWith('Me: ');
// // //     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // //       child: Container(
// // //         decoration: BoxDecoration(
// // //           color: bubbleColor,
// // //           borderRadius: BorderRadius.circular(30.0),
// // //         ),
// // //         child: ListTile(
// // //           title: Text(
// // //             isUserMessage ? message : _convertMarkdownToPlainText(message.replaceFirst('Bot: ', '')),
// // //             style: const TextStyle(
// // //               color: Colors.black,
// // //               fontSize: 20.0,
// // //             ),
// // //           ),
// // //         ),
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
// // //       decoration: BoxDecoration(border: Border.symmetric(),borderRadius: BorderRadius.circular(20)),
// // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // //       child: Row(
// // //         children: <Widget>[
// // //           Flexible(
// // //             child: TextField(
// // //               controller: _controller,
// // //               onSubmitted: _handleSubmitted,
// // //               decoration: const InputDecoration.collapsed(
// // //                 // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
// // //                 hintText: 'Send a message',
// // //               ),
// // //             ),
// // //           ),
// // //           Container(
// // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // //             child: IconButton(
// // //               icon:  Icon(Icons.send,color: Colors.brown.shade200,),
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
// // //       appBar: tabbar(),
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
// // // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:markdown/markdown.dart' as md;
// // // // import 'dart:convert';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       debugShowCheckedModeBanner: false,
// // // //       title: 'Django Integration Demo',
// // // //       theme: ThemeData(
// // // //         primarySwatch: Colors.blue,
// // // //       ),
// // // //       home: ChatScreen(),
// // // //     );
// // // //   }
// // // // }

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
// // // //       } else {
// // // //         setState(() {
// // // //           _messages.insert(0, 'Bot: Error receiving response');
// // // //         });
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<dynamic?> _sendMessageToBackend(String message) async {
// // // //     http.Response response = await http.post(
// // // //       Uri.parse('http://10.0.2.2:8000/tg/'),
// // // //       body: {
// // // //         'user_text': message,
// // // //       },
// // // //       headers: {
// // // //         'Content-Type': 'application/x-www-form-urlencoded',
// // // //       },
// // // //     );
// // // //     try {
// // // //       print('Sending message to backend: $message'); // Log message
      
// // // //       print('Response status: ${response.statusCode}'); // Log status code
// // // //       print('Response body: ${response.body}'); // Log response body
// // // //       if (response.statusCode == 200) {
// // // //         var jsonResponse = jsonDecode(response.body);
// // // //         print('Request sucsses with status: ${response.statusCode}');
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

// // // //   String _convertMarkdownToPlainText(String markdownText) {
// // // //     // Convert Markdown to HTML
// // // //     String htmlText = md.markdownToHtml(markdownText);
    
// // // //     // Use a regular expression to remove HTML tags and decode HTML entities
// // // //     final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
// // // //     return htmlText.replaceAll(exp, "").replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&');
// // // //   }

// // // //   Widget _buildMessageItem(String message) {
// // // //     bool isUserMessage = message.startsWith('Me: ');
// // // //     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // // //       child: Container(
// // // //         decoration: BoxDecoration(
// // // //           color: bubbleColor,
// // // //           borderRadius: BorderRadius.circular(30.0),
// // // //         ),
// // // //         child: ListTile(
// // // //           title: Text(
// // // //             isUserMessage ? message : _convertMarkdownToPlainText(message.replaceFirst('Bot: ', '')),
// // // //             style: const TextStyle(
// // // //               color: Colors.black,
// // // //               fontSize: 20.0,
// // // //             ),
// // // //           ),
// // // //         ),
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
// // // //       decoration: BoxDecoration(border: Border.symmetric(),borderRadius: BorderRadius.circular(20)),
// // // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // // //       child: Row(
// // // //         children: <Widget>[
// // // //           Flexible(
// // // //             child: TextField(
// // // //               controller: _controller,
// // // //               onSubmitted: _handleSubmitted,
// // // //               decoration: const InputDecoration.collapsed(
// // // //                 // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
// // // //                 hintText: 'Send a message',
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           Container(
// // // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // // //             child: IconButton(
// // // //               icon:  Icon(Icons.send,color: Colors.brown.shade200,),
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
// // // //       appBar: tabbar(),
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
// // // // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:flutter_markdown/flutter_markdown.dart';
// // // // // import 'dart:convert';

// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }

// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       debugShowCheckedModeBanner: false,
// // // // //       title: 'Django Integration Demo',
// // // // //       theme: ThemeData(
// // // // //         primarySwatch: Colors.blue,
// // // // //       ),
// // // // //       home: ChatScreen(),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class ChatScreen extends StatefulWidget {
// // // // //   const ChatScreen({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   _ChatScreenState createState() => _ChatScreenState();
// // // // // }

// // // // // class _ChatScreenState extends State<ChatScreen> {
// // // // //   final TextEditingController _controller = TextEditingController();
// // // // //   final List<String> _messages = [];

// // // // //   void _handleSubmitted(String text) async {
// // // // //     if (text.isNotEmpty) {
// // // // //       _controller.clear();
// // // // //       setState(() {
// // // // //         _messages.insert(0, 'Me: $text');
// // // // //       });

// // // // //       // Send the message to the backend
// // // // //       var response = await _sendMessageToBackend(text);
// // // // //       if (response != null) {
// // // // //         setState(() {
// // // // //           _messages.insert(0, 'Bot: $response');
// // // // //         });
// // // // //       } else {
// // // // //         setState(() {
// // // // //           _messages.insert(0, 'Bot: Error receiving response');
// // // // //         });
// // // // //       }
// // // // //     }
// // // // //   }

// // // // //   Future<dynamic?> _sendMessageToBackend(String message) async {
// // // // //     http.Response response = await http.post(
// // // // //       Uri.parse('http://10.0.2.2:8000/tg/'),
// // // // //       body: {
// // // // //         'user_text': message,
// // // // //       },
// // // // //       headers: {
// // // // //         'Content-Type': 'application/x-www-form-urlencoded',
// // // // //       },
// // // // //     );
// // // // //     try {
// // // // //       print('Sending message to backend: $message'); // Log message
      
// // // // //       print('Response status: ${response.statusCode}'); // Log status code
// // // // //       print('Response body: ${response.body}'); // Log response body
// // // // //       if (response.statusCode == 200) {
// // // // //         var jsonResponse = jsonDecode(response.body);
// // // // //         print('Request sucsses with status: ${response.statusCode}');
// // // // //         return jsonResponse['response'];
// // // // //       } else {
// // // // //         print('Request failed with status: ${response.statusCode}');
// // // // //         print('Response body: ${response.body}');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       print('Error sending message: $e');
// // // // //     }
// // // // //     return null;
// // // // //   }

// // // // //   Widget _buildMessageItem(String message) {
// // // // //     bool isUserMessage = message.startsWith('Me: ');
// // // // //     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // // // //       child: Container(
// // // // //         decoration: BoxDecoration(
// // // // //           color: bubbleColor,
// // // // //           borderRadius: BorderRadius.circular(30.0),
// // // // //         ),
// // // // //         child: ListTile(
// // // // //           title: isUserMessage
// // // // //               ? Text(
// // // // //                   message,
// // // // //                   style: const TextStyle(
// // // // //                     color: Colors.black,
// // // // //                     fontSize: 20.0,
// // // // //                   ),
// // // // //                 )
// // // // //               : MarkdownBody(
// // // // //                   data: message.replaceFirst('Bot: ', '','**' as int), // Remove 'Bot: ' prefix
// // // // //                   styleSheet: MarkdownStyleSheet(
// // // // //                     p: const TextStyle(fontSize: 20.0),
// // // // //                   ),
// // // // //                 ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildMessageList() {
// // // // //     return ListView.builder(
// // // // //       reverse: true,
// // // // //       itemCount: _messages.length,
// // // // //       itemBuilder: (BuildContext context, int index) {
// // // // //         return _buildMessageItem(_messages[index]);
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   Widget _buildTextComposer() {
// // // // //     return Container(
// // // // //       decoration: BoxDecoration(border: Border.symmetric(),borderRadius: BorderRadius.circular(20)),
// // // // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // //       child: Row(
// // // // //         children: <Widget>[
// // // // //           Flexible(
// // // // //             child: TextField(
// // // // //               controller: _controller,
// // // // //               onSubmitted: _handleSubmitted,
// // // // //               decoration: const InputDecoration.collapsed(
// // // // //                 // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
// // // // //                 hintText: 'Send a message',
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           Container(
// // // // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // // // //             child: IconButton(
// // // // //               icon:  Icon(Icons.send,color: Colors.brown.shade200,),
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
// // // // //       appBar: tabbar(),
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

// // // // // // import 'package:flutter_markdown/flutter_markdown.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // // // // // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'dart:convert';

// // // // // // void main() {
// // // // // //   runApp(MyApp());
// // // // // // }

// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       debugShowCheckedModeBanner: false,
// // // // // //       title: 'Django Integration Demo',
// // // // // //       theme: ThemeData(
// // // // // //         primarySwatch: Colors.blue,
// // // // // //       ),
// // // // // //       home: ChatScreen(),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class ChatScreen extends StatefulWidget {
// // // // // //   const ChatScreen({Key? key}) : super(key: key);

// // // // // //   @override
// // // // // //   _ChatScreenState createState() => _ChatScreenState();
// // // // // // }

// // // // // // class _ChatScreenState extends State<ChatScreen> {
// // // // // //   final TextEditingController _controller = TextEditingController();
// // // // // //   final List<String> _messages = [];

// // // // // //   void _handleSubmitted(String text) async {
// // // // // //     if (text.isNotEmpty) {
// // // // // //       _controller.clear();
// // // // // //       setState(() {
// // // // // //         _messages.insert(0, 'Me: $text');
// // // // // //       });

// // // // // //       // Send the message to the backend
// // // // // //       var response = await _sendMessageToBackend(text);
// // // // // //       if (response != null) {
// // // // // //         setState(() {
// // // // // //           _messages.insert(0, 'Bot: $response');
// // // // // //         });
// // // // // //       } else {
// // // // // //         setState(() {
// // // // // //           _messages.insert(0, 'Bot: Error receiving response');
// // // // // //         });
// // // // // //       }
// // // // // //     }
// // // // // //   }

// // // // // //   Future<dynamic?> _sendMessageToBackend(String message) async {
// // // // // //     http.Response response = await http.post(
// // // // // //       Uri.parse('http://10.0.2.2:8000/tg/'),
// // // // // //       body: {
// // // // // //         'user_text': message,
// // // // // //       },
// // // // // //       headers: {
// // // // // //         'Content-Type': 'application/x-www-form-urlencoded',
// // // // // //       },
// // // // // //     );
// // // // // //     try {
// // // // // //       print('Sending message to backend: $message'); // Log message
      
// // // // // //       print('Response status: ${response.statusCode}'); // Log status code
// // // // // //       print('Response body: ${response.body}'); // Log response body
// // // // // //       if (response.statusCode == 200) {
// // // // // //         var jsonResponse = jsonDecode(response.body);
// // // // // //         print('Request sucsses with status: ${response.statusCode}');
// // // // // //         return jsonResponse['response'];
// // // // // //       } else {
// // // // // //         print('Request failed with status: ${response.statusCode}');
// // // // // //         print('Response body: ${response.body}');
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print('Error sending message: $e');
// // // // // //     }
// // // // // //     return null;
// // // // // //   }

// // // // // //   Widget _buildMessageItem(String message) {
// // // // // //     bool isUserMessage = message.startsWith('Me: ');
// // // // // //     Color? bubbleColor = isUserMessage ? Color.fromARGB(255, 160, 209, 185) : kprimaryColourcream;

// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
// // // // // //       child: Container(
// // // // // //         decoration: BoxDecoration(
// // // // // //           color: bubbleColor,
// // // // // //           borderRadius: BorderRadius.circular(30.0),
// // // // // //         ),
// // // // // //         child: ListTile(
// // // // // //           title: Text(
// // // // // //             message,
// // // // // //             style: const TextStyle(
// // // // // //               color: Colors.black,
// // // // // //               fontSize: 20.0,
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildMessageList() {
// // // // // //     return ListView.builder(
// // // // // //       reverse: true,
// // // // // //       itemCount: _messages.length,
// // // // // //       itemBuilder: (BuildContext context, int index) {
// // // // // //         return _buildMessageItem(_messages[index]);
// // // // // //       },
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildTextComposer() {
// // // // // //     return Container(
// // // // // //       decoration: BoxDecoration(border: Border.symmetric(),borderRadius: BorderRadius.circular(20)),
// // // // // //       margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // // //       child: Row(
// // // // // //         children: <Widget>[
// // // // // //           Flexible(
// // // // // //             child: TextField(
// // // // // //               controller: _controller,
// // // // // //               onSubmitted: _handleSubmitted,
// // // // // //               decoration: const InputDecoration.collapsed(
// // // // // //                 // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
// // // // // //                 hintText: 'Send a message',
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           Container(
// // // // // //             margin: const EdgeInsets.symmetric(horizontal: 4.0),
// // // // // //             child: IconButton(
// // // // // //               icon:  Icon(Icons.send,color: Colors.brown.shade200,),
// // // // // //               onPressed: () => _handleSubmitted(_controller.text),
// // // // // //               color: Theme.of(context).colorScheme.primary,
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: tabbar(),
// // // // // //       body: Column(
// // // // // //         children: [
// // // // // //           Expanded(
// // // // // //             child: _buildMessageList(),
// // // // // //           ),
// // // // // //           _buildTextComposer(),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }