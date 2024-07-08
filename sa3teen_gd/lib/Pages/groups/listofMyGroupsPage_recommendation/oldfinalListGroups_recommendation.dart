// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/CommentsProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
import 'package:gp_screen/Pages/APIsSalma/GroupsAPIfinal.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
import 'package:gp_screen/Pages/APIsSalma/apiOfMaterials.dart';
import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
import 'package:gp_screen/Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'package:gp_screen/Pages/groups/search/searchUiGroups.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/ModellistGroups.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class GroupsScreen extends StatefulWidget {
  final String url;
  final String pageName;

  final String accessToken;

  GroupsScreen(
      {required this.url, required this.pageName, required this.accessToken});

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late Future<List<listGroupsModel>> futureGroups;
  final TextEditingController _passwordController = TextEditingController();
  late final String pageNamee;

  @override
  void initState() {
    super.initState();
    pageNamee = widget.pageName;
    futureGroups = getAllGroups()
        .getAllGroupsList_recommendation(widget.url, widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tabbar(),
      body: FutureBuilder<List<listGroupsModel>>(
        future: futureGroups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No groups found.'));
          } else {
            List<listGroupsModel> groups = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    children: [
                      Text(
                        widget.pageName,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      IconButton(
                          onPressed: () {
                            print(widget.pageName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                    accessToken:
                                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.search,
                            color: kprimaryColourcream,
                          )),
                    
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      listGroupsModel group = groups[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupDetailPage(
                                  groupId: group.id,
                                  accessToken:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                            ),
                          );
                        },
                        child: Card(
                          color: kprimaryColourWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: group.image != null
                                      ? NetworkImage(group.image!)
                                      : null,
                                  backgroundColor: group.image == null
                                      ? kprimaryColourcream
                                      : Colors.transparent,
                                  child: group.image == null
                                      ? const Icon(Icons.group,
                                          size: 30, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        group.title,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(group.subject),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          Text(group.type),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            ' ${group.members} Members',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    if (!group.has_joined)
                                      ElevatedButton(
                                        onPressed: () {
                                          var type = group.type;
                                          print(group.type);
                                          if (type == "private") {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Enter Password'),
                                                  content: TextField(
                                                    controller:
                                                        _passwordController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'Password',
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            kprimaryColourGreen,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        joinGroup(
                                                          group.id,
                                                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                          _passwordController
                                                              .text,
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Join',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            joinGroup(
                                              group.id,
                                              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                              null,
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kprimaryColourcream,
                                        ),
                                        child: const Text(
                                          'Join',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    else
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'unjoin the group '),
                                                content: const Text(
                                                  'Are You Sure ?',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      unjoinGroup(
                                                        group.id,
                                                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                      );
                                                    },
                                                    child: const Text(
                                                      'UnJoin',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                        ),
                                        child: const Text(
                                          'Unjoin',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateGroupPage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => CommentsProvider(
//               'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'
//               //rightup khalil
//               // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'
//               ),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => GroupsProvider(
//               'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
//         ),
//         ChangeNotifierProvider(create: (_) => PostProvider()),
//         ChangeNotifierProvider(create: (_) => GroupProvider()),
//         ChangeNotifierProvider(create: (_) => MaterialProvider()),
//         ChangeNotifierProvider(create: (_) => MyGroupProvider()),
//         ChangeNotifierProvider(
//           create: (context) => MaterialsProvider(),
//           // child: MyApp(),
//         ),
//       ],
//       child: MaterialApp(
//         home: GroupsScreen(url: 'groups/list_groups/',
//           accessToken:
//               'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
//         ),
//       ),
//     );
//   }
// }
