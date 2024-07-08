// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/CommentsProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
import 'package:gp_screen/Pages/APIsSalma/apiOfMaterials.dart';
import 'package:gp_screen/Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/bgddfinalListGroups_recommendation.dart';
import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
import 'package:gp_screen/Services/API_services.dart';
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
          create: (context) => CommentsProvider(accesstokenfinal),
        ),
        ChangeNotifierProvider(
          create: (context) => GroupsProvider(accesstokenfinal),
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
                  const SizedBox(height: 400),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listallgroups(
                              url: 'groups/list_groups/',
                              pageName: 'Groups',
                              accessToken: accesstokenfinal),
                        ),
                      );
                    },
                    child: const Text('list'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => listallgroups(
                              url: 'recommend/',
                              pageName: 'Recommended Groups',
                              accessToken: accesstokenfinal),
                        ),
                      );
                    },
                    child: const Text('recommend'),
                  ),
                  ElevatedButton(
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
