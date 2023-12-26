import 'package:flutter/material.dart';

import 'Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',

      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primaryColor: const Color(0xFF388E3C) // Set your desired primary color
        // You can also set other theme properties here
      ),
      home: const Login(), // Replace with the initial page of your app
    );
  }
}
