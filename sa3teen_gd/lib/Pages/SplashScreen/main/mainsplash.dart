import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/SplashScreen/Page/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyAppName',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),   
       //l mfrod t3ml navigate ll login bgd bs na m4 3ndy l backend f m4 ht48al -_-
      routes: {
        '/login': (context) => LoginPage(),  // Define the login page route
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
