import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Chat Bot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import'package:gp_screen/pages/chatBotIntegrated/Chat Bot copy 2.dart';
abstract class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];
  bool _isUserMessage =
      true; // Variable to track whether the message is from the user

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      // Check if the text is not empty
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

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
      _isPlaying = _videoPlayerController.value.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: _togglePlayPause,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
