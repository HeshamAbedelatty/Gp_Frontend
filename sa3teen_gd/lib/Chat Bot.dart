
import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';

// el appbar
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
    if (text.isNotEmpty) {
      _controller.clear();
      setState(() {
        _messages.insert(0, text);
        _isUserMessage = true;
      });
    }
  }

  Widget _buildMessageItem(String message, bool isUserMessage) {
    Color? bubbleColor = isUserMessage ? Colors.greenAccent : Colors.grey[300];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        final bool isUserMessage = index % 2 == 0;
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
      // appBar: AppBar(
      //   title: const Text('Chat with ChatGPT'),
      // ),
      body: Column(
        children: [
          const CustomAppBar(title: 'Chat with ChatBot'),
          Expanded(
            child: _buildMessageList(),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }
}
