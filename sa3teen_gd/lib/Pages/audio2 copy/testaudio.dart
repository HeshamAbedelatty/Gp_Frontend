import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'audio.dart';
import 'audioplayerscreen.dart';
import 'audioplayerstate.dart';

void main() async {


  runApp(
    MultiProvider(
      providers: [

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
