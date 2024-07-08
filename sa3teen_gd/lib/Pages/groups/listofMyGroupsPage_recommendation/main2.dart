// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/CommentsProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
import 'package:gp_screen/Pages/APIsSalma/apiOfMaterials.dart';
import 'package:gp_screen/Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/modelnewpro.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/myGroups%20copyprovider%20demoo/UserGroupsScreen.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/tryproviderListGroups_recommendation%20copy.dart';
// import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/finalListGroups_recommendation.dart';
import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
        ChangeNotifierProvider(create: (_) => ListGroupsProvider()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 400),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listallgroups(
                            url: 'groups/list_groups/',pageName: 'Groups',
                            accessToken:
                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                          // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
// "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE"
     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjg0MDk2LCJpYXQiOjE3MjAzODgwOTYsImp0aSI6IjIyMTE2MWZjZGI0ODQwZmU5YTE2NTEyMTI4ZWQ2YTZiIiwidXNlcl9pZCI6MjJ9.inlHVejYMF8YE-_TZYOJtOTiKYwpgq5uP-xhqPub1ws",
                          ),
                        ),
                      );
                    },
                    child: Text('list'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listallgroups(
                            url: 'recommend/',pageName: 'Recommended Groups',
                            accessToken:
                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjg0MDk2LCJpYXQiOjE3MjAzODgwOTYsImp0aSI6IjIyMTE2MWZjZGI0ODQwZmU5YTE2NTEyMTI4ZWQ2YTZiIiwidXNlcl9pZCI6MjJ9.inlHVejYMF8YE-_TZYOJtOTiKYwpgq5uP-xhqPub1ws",
                       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjg0MDk2LCJpYXQiOjE3MjAzODgwOTYsImp0aSI6IjIyMTE2MWZjZGI0ODQwZmU5YTE2NTEyMTI4ZWQ2YTZiIiwidXNlcl9pZCI6MjJ9.inlHVejYMF8YE-_TZYOJtOTiKYwpgq5uP-xhqPub1ws",

                          ),
                        ),
                      );
                    },
                    child: Text('recommend'),
                  ),   ElevatedButton(
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: kprimaryColourcream,
                          // ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserGroupsScreen(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                'My Groups ',
                                // style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.black,
                              ),
                            ],
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
