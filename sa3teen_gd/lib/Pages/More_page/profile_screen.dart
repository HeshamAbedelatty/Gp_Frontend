import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/BottomAppBar/BottomBar.dart';
import 'package:gp_screen/Pages/tabbars/MorePageTabBar.dart';

import 'body.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //  title: 'Flutter Demo',

      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  //const ProfileScreen extends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Appbar(),
      body: Body(),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
