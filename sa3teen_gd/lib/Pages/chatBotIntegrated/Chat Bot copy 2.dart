//LAST VERSIONN
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../BottomAppBar/BottomBar.dart';


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
          _messages
              .insert(0, {'sender': 'Bot', 'text': 'Error receiving response'});
        });
      }
    }
  }

  Future<dynamic?> _sendMessageToBackend(String message) async {
    http.Response response = await http.post(
      Uri.parse('https://aisa3teengd.azurewebsites.net//tg/'),
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
            .replaceAll('\n', '\n ')
            .replaceAll(RegExp(r"[^a-zA-Z0-9\s.,'+\-*/=]"), '');

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
    Color? bubbleColor = isUserMessage
        ? Color.fromARGB(255, 160, 209, 185)
        : kprimaryColourcream;
    TextStyle? textStyle = isUserMessage
        ? TextStyle(color: Colors.black)
        : TextStyle(color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: SelectableText(
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
      decoration: BoxDecoration(
          border: Border.symmetric(), borderRadius: BorderRadius.circular(20)),
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
