import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/modelnewpro.dart';
import 'package:gp_screen/Pages/groups/search/searchUiGroups.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class listallgroups extends StatefulWidget {
  final String url;
  final String pageName;

  final String accessToken;

  listallgroups(
      {required this.url, required this.pageName, required this.accessToken});
  @override
  State<listallgroups> createState() => _listallgroupsState();
}

class _listallgroupsState extends State<listallgroups> {
  //  late Future<List<listGroupsModel>> futureGroups;
  final TextEditingController _passwordController = TextEditingController();
  late final String pageNamee;

  @override
  void initState() {
    super.initState();
    Provider.of<ListGroupsProvider>(context, listen: false)
        .fetchAllGroups(widget.url, widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder(
        future: Provider.of<ListGroupsProvider>(context, listen: false)
            .fetchAllGroups(widget.url, widget.accessToken),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to Load Groups!'));
          } else {
            return Consumer<ListGroupsProvider>(
              builder: (ctx, ListGroupsProvider, _) {
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
                        itemCount: ListGroupsProvider.groups.length,
                        itemBuilder: (ctx, index) {
                          final group = ListGroupsProvider.groups[index];
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
                                                    color:
                                                        Colors.grey.shade500),
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
                                                  builder:
                                                      (BuildContext context) {
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
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                kprimaryColourGreen,
                                                          ),
                                                          onPressed: () async{
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .pop();
                                                               
                                                                // Provider.of<ListGroupsProvider>(context, listen: false)
        // .joinGroup(group.id, widget.accessToken, _passwordController
                                                                  // .text,);
                                                            // joinGroup(
                                                            //   group.id,
                                                            //   widget
                                                            //       .accessToken,
                                                            //   // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                            //   _passwordController
                                                            //       .text,
                                                            // );
                                                             await ListGroupsProvider.joinGroup(widget.url,
                                      group.id,widget.accessToken,_passwordController.text);
                                                             await ListGroupsProvider.fetchAllGroups(
                                      widget.url,widget.accessToken,);
                                                            
                                                            //                                                 getAllGroups()
                                                            // .getAllGroupsList_recommendation(widget.url, widget.accessToken);
                                                          },
                                                          child: const Text(
                                                            'Join',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                   ListGroupsProvider.joinGroup(widget.url,
                                      group.id,widget.accessToken,_passwordController.text);
                                                              ListGroupsProvider.fetchAllGroups(
                                      widget.url,widget.accessToken,);
                                                // joinGroup(
                                                //   group.id,
                                                //   widget.accessToken,
                                                //   // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                //   null,
                                                // );
                                                //                                     getAllGroups()
                                                // .getAllGroupsList_recommendation(widget.url, widget.accessToken);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  kprimaryColourcream,
                                            ),
                                            child: const Text(
                                              'Join',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        else
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'unjoin the group '),
                                                    content: const Text(
                                                      'Are You Sure ?',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
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
                                                              ListGroupsProvider.unjoinGroup(widget.url,
                                      group.id,widget.accessToken,);
                                                          // unjoinGroup(group.id,
                                                          //     widget.accessToken
                                                          //     // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
                                                          //     );
                                                               ListGroupsProvider.fetchAllGroups(
                                      widget.url,widget.accessToken,);
                                                          //                                               getAllGroups()
                                                          // .getAllGroupsList_recommendation(widget.url, widget.accessToken);
                                                        },
                                                        child: const Text(
                                                          'UnJoin',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );

                          // return ListTile(
                          //   // leading: Image.network(groups.image),
                          //   title: Text(groups.title),
                          //   subtitle: Text(groups.description),
                          // );
                        },
                      ),
                    ),
                  ],
                );
              },
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















// import 'group_provider.dart';

// class UserGroupsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Joined Groups'),
//       ),
//       body: FutureBuilder(
//         future: Provider.of<MyGroupProvider>(context, listen: false).fetchUserGroups('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('An error occurred!'));
//           } else {
//             return Consumer<MyGroupProvider>(
//               builder: (ctx, groupProvider, _) {
//                 return ListView.builder(
//                   itemCount: groupProvider.userGroups.length,
//                   itemBuilder: (ctx, index) {
//                     final userGroup = groupProvider.userGroups[index];
//                     return ListTile(
//                       leading: Image.network(userGroup.group.image!),
//                       title: Text(userGroup.group.title),
//                       subtitle: Text(userGroup.group.description),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
