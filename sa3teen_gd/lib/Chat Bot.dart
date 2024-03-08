





import 'package:flutter/material.dart';
import 'Chat Bot.dart';
 // Import your ChatBot class here

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  bool _isUserMessage = true; // Variable to track whether the message is from the user

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) { // Check if the text is not empty
      _controller.clear();
      setState(() {
        _messages.insert(0, text);
        _isUserMessage = true; // New message is from the user
      });
      // Call a function to handle the submitted message here
      // For example, you can call a function to send the message to the ChatGPT model
      // and receive a response.
    }
  }

  Widget _buildMessageItem(String message, bool isUserMessage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isUserMessage ? Colors.greenAccent : Colors.grey[200], // Adjust the background color based on user or chatbot message
        borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
      ),
      child: ListTile(
        title: Text(
          message,
          style: const TextStyle(
            color: Colors.black, // Set the font color to black for both user and chatbot messages
            fontSize: 20.0, // Adjust the font size as needed
          ),
        ),
        // Adjust the alignment based on user or chatbot message
        contentPadding: isUserMessage
            ? const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0) // Align user messages to the right
            : const EdgeInsets.fromLTRB(10.0, 10.0, 16.0, 10.0), // Align chatbot messages to the left
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isUserMessage = index % 2 == 0; // Alternate between user and chatbot messages for demonstration
        return _buildMessageItem(_messages[index], isUserMessage);
      },
    );
  }

  Widget _buildTextComposer() {
    return Container(
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
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_controller.text),
              color: Theme.of(context).colorScheme.primary, // Adjust the icon color
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with ChatGPT'),
      ),
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


























// void _handleSubmitted(String text) async {
//   _controller.clear();
//   setState(() {
//     _messages.insert(0, text);
//   });
//
//   // Call your backend API or service here to get the response
//   String response = await _getResponseFromBackend(text);
//
//   // Update the UI with the received response
//   setState(() {
//     _messages.insert(0, response);
//   });
// }
//
// Future<String> _getResponseFromBackend(String message) async {
//   // Send the user's message to your backend and receive the response
//   // You can use libraries like http, dio, websockets, etc., to communicate with your backend
//
//   // For demonstration purposes, return a static response here
//   return "This is a response from ChatGPT.";
// }
