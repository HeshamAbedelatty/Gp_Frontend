import 'package:final_profile/audio2/audioplayerscreen.dart';
import 'package:final_profile/audio2/audioplayerstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AudioPlayerScreen(),
    );
  }
}
