import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/CommentsProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
import 'package:gp_screen/Pages/APIsSalma/apiOfMaterials.dart';
import 'package:gp_screen/Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/modelnewpro.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/myGroups%20copyprovider%20demoo/UserGroupsScreen.dart';
import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
// import 'package:gp_screen/Pages/groups/myGroups/GroupListProvider.dart';
import 'package:provider/provider.dart';
// import 'group_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyGroupProvider()),
        ChangeNotifierProvider(create: (_) => ListGroupsProvider()),
          ChangeNotifierProvider(
          create: (context) => CommentsProvider(
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'),
        ),
        ChangeNotifierProvider(
          create: (context) => GroupsProvider(
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
        ),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => MaterialProvider()),
        ChangeNotifierProvider(create: (_) => MyGroupProvider()),
        ChangeNotifierProvider(create: (context) => MaterialsProvider()),
        // ChangeNotifierProvider(create: (_) => ListGroupsProvider()),
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
      home: listallgroups(url:'recommend/' ,pageName: 'g',accessToken: 
      // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU',                            
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE"
),
    );
  }
}
