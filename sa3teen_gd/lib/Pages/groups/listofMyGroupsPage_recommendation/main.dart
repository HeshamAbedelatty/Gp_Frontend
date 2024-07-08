// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/CommentsProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
import 'package:gp_screen/Pages/APIsSalma/apiOfMaterials.dart';
import 'package:gp_screen/Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/finalListGroups_recommendation.dart';
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
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 550),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupsScreen(
                            url: 'groups/list_groups/',pageName: 'Groups',
                            accessToken:
                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
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
                          builder: (context) => GroupsScreen(
                            url: 'recommend/',pageName: 'Recommended Groups',
                            accessToken:
                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                          ),
                        ),
                      );
                    },
                    child: Text('recommend'),
                  ),   ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kprimaryColourcream,
                          ),
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
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.group,
                                color: Colors.white,
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
