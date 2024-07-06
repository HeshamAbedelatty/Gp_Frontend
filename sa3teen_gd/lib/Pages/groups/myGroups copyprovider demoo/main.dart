import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/myGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/groups/myGroups/UserGroupsScreen.dart';
import 'package:provider/provider.dart';
// import 'group_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyGroupProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Joined Groups',
      home: UserGroupsScreen(),
    );
  }
}
