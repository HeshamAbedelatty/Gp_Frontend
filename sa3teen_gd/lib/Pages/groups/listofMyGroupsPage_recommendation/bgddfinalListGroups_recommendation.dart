// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
// import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';

import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
import 'package:gp_screen/Pages/groups/search/searchUiGroups.dart';
import 'package:gp_screen/Services/API_services.dart';
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to Load Groups!'));
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
                            style: const TextStyle(
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
                                        accessToken: accesstokenfinal),
                                  ),
                                );

                                ListGroupsProvider.fetchAllGroups(
                                  widget.url,
                                  widget.accessToken,
                                );
                              },
                              icon: const Icon(
                                Icons.search,
                                color: kprimaryColourcream,
                              )),
                          ElevatedButton(
                            // style: ,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserGroupsScreen(),
                                  ),
                                );
                              },
                              child: Text('MyGroups'))
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
                                      accessToken: accesstokenfinal),
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                                          onPressed: () async {
                                                            await ListGroupsProvider.joinGroup(
                                                                'groups/list_groups/',
                                                                group.id,
                                                                widget
                                                                    .accessToken,
                                                                _passwordController
                                                                    .text);
                                                            await ListGroupsProvider
                                                                .fetchAllGroups(
                                                              widget.url,
                                                              widget
                                                                  .accessToken,
                                                            );

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
                                                ListGroupsProvider.joinGroup(
                                                    'groups/list_groups/',
                                                    group.id,
                                                    widget.accessToken,
                                                    _passwordController.text);
                                                ListGroupsProvider
                                                    .fetchAllGroups(
                                                  widget.url,
                                                  widget.accessToken,
                                                );
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
                                                          ListGroupsProvider
                                                              .unjoinGroup(
                                                            widget.url,
                                                            group.id,
                                                            widget.accessToken,
                                                          );

                                                          ListGroupsProvider
                                                              .fetchAllGroups(
                                                            widget.url,
                                                            widget.accessToken,
                                                          );
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
        child: Icon(Icons.menu_outlined),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Choose an action'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Show Recommended Groups'),
                      onTap: () {
                        Navigator.pop(context); // Close the dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => listallgroups(
                              url: 'recommend/',
                              pageName: 'Recommended Groups',
                              accessToken: accesstokenfinal,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Create New Group'),
                      onTap: () {
                        Navigator.pop(context); // Close the dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateGroupPage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },

        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   AlertDialog(
        //     title: Text('Choose an action'),
        //     content: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: <Widget>[
        //         ListTile(
        //           title: Text('Show Recommended Groups'),
        //           onTap: () {
        //             Navigator.pop(context); // Close the dialog
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => listallgroups(
        //                   url: 'recommend/',
        //                   pageName: 'Recommended Groups',
        //                   accessToken: accesstokenfinal,
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //         ListTile(
        //           title: Text('Create New Group'),
        //           onTap: () {
        //             Navigator.pop(context); // Close the dialog
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) => CreateGroupPage()),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   );
        // }
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => CreateGroupPage()),
        //   );
        // },
        // backgroundColor: Colors.green,
        // child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
// import 'package:flutter/material.dart';


// // ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
// import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
// import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/bgddfinaLrecommendation%20copy.dart';
// import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
// // import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/tabbars/tabBar.dart';

// import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
// import 'package:gp_screen/Pages/groups/search/searchUiGroups.dart';
// import 'package:gp_screen/Services/API_services.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:provider/provider.dart';

// class listallgroups extends StatefulWidget {
//   final String url;
//   final String pageName;

//   final String accessToken;

//   listallgroups(
//       {required this.url, required this.pageName, required this.accessToken});
//   @override
//   State<listallgroups> createState() => _listallgroupsState();
// }

// class _listallgroupsState extends State<listallgroups> {
//   //  late Future<List<listGroupsModel>> futureGroups;
//   final TextEditingController _passwordController = TextEditingController();
//   late final String pageNamee;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ListGroupsProvider>(context, listen: false)
//         .fetchAllGroups(widget.url, widget.accessToken);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: FutureBuilder(
//         future: Provider.of<ListGroupsProvider>(context, listen: false)
//             .fetchAllGroups(widget.url, widget.accessToken),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Failed to Load Groups!'));
//           } else {
//             return Consumer<ListGroupsProvider>(
//               builder: (ctx, ListGroupsProvider, _) {
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Row(
//                         children: [
//                           ListView(scrollDirection: Axis.horizontal,
//                             children: [Row(
//                               children: [
//                                 Text(
//                                   widget.pageName,
//                                   style: const TextStyle(
//                                       fontSize: 25, fontWeight: FontWeight.bold),
//                                 ),
//                                 const Spacer(
//                                   flex: 1,
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       print(widget.pageName);
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => SearchScreen(
//                                               accessToken: accesstokenfinal),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(
//                                       Icons.search,
//                                       color: kprimaryColourcream,
//                                     )),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => UserGroupsScreen(),
//                                         ),
//                                       );
//                                     },
//                                     child: Text('MyGroups')),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => recom(
//                                     url: 'recommend/',
//                                     pageName: 'Recommended Groups',
//                                     accessToken: accesstokenfinal),
//                               ),
//                             );
//                                     },
//                                     child: Text('Recommended Groups'))
//                               ],
//                             ),]
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: ListGroupsProvider.groups.length,
//                         itemBuilder: (ctx, index) {
//                           final group = ListGroupsProvider.groups[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => GroupDetailPage(
//                                       groupId: group.id,
//                                       accessToken: accesstokenfinal),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               color: kprimaryColourWhite,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                               elevation: 5,
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 6),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 30,
//                                       backgroundImage: group.image != null
//                                           ? NetworkImage(group.image!)
//                                           : null,
//                                       backgroundColor: group.image == null
//                                           ? kprimaryColourcream
//                                           : Colors.transparent,
//                                       child: group.image == null
//                                           ? const Icon(Icons.group,
//                                               size: 30, color: Colors.white)
//                                           : null,
//                                     ),
//                                     const SizedBox(width: 10.0),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             group.title,
//                                             style: const TextStyle(
//                                               fontSize: 18.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 5.0),
//                                           Text(group.subject),
//                                           const SizedBox(height: 5.0),
//                                           Row(
//                                             children: [
//                                               Text(group.type),
//                                               const SizedBox(height: 5.0),
//                                               Text(
//                                                 ' ${group.members} Members',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     color:
//                                                         Colors.grey.shade500),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Column(
//                                       children: [
//                                         if (!group.has_joined)
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               var type = group.type;
//                                               print(group.type);
//                                               if (type == "private") {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) {
//                                                     return AlertDialog(
//                                                       title: const Text(
//                                                           'Enter Password'),
//                                                       content: TextField(
//                                                         controller:
//                                                             _passwordController,
//                                                         decoration:
//                                                             const InputDecoration(
//                                                           hintText: 'Password',
//                                                         ),
//                                                       ),
//                                                       actions: [
//                                                         TextButton(
//                                                           onPressed: () {
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .pop();
//                                                           },
//                                                           child: const Text(
//                                                               'Cancel'),
//                                                         ),
//                                                         ElevatedButton(
//                                                           style: ElevatedButton
//                                                               .styleFrom(
//                                                             backgroundColor:
//                                                                 kprimaryColourGreen,
//                                                           ),
//                                                           onPressed: () async {
//                                                             await ListGroupsProvider
//                                                                 .joinGroup(
//                                                                     widget.url,
//                                                                     group.id,
//                                                                     widget
//                                                                         .accessToken,
//                                                                     _passwordController
//                                                                         .text);
//                                                             await ListGroupsProvider
//                                                                 .fetchAllGroups(
//                                                               widget.url,
//                                                               widget
//                                                                   .accessToken,
//                                                             );

//                                                             //                                                 getAllGroups()
//                                                             // .getAllGroupsList_recommendation(widget.url, widget.accessToken);
//                                                           },
//                                                           child: const Text(
//                                                             'Join',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               } else {
//                                                 ListGroupsProvider.joinGroup(
//                                                     widget.url,
//                                                     group.id,
//                                                     widget.accessToken,
//                                                     _passwordController.text);
//                                                 ListGroupsProvider
//                                                     .fetchAllGroups(
//                                                   widget.url,
//                                                   widget.accessToken,
//                                                 );
//                                               }
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:
//                                                   kprimaryColourcream,
//                                             ),
//                                             child: const Text(
//                                               'Join',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           )
//                                         else
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'unjoin the group '),
//                                                     content: const Text(
//                                                       'Are You Sure ?',
//                                                       style: TextStyle(
//                                                           fontSize: 20),
//                                                     ),
//                                                     actions: [
//                                                       TextButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: const Text(
//                                                             'Cancel'),
//                                                       ),
//                                                       ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           backgroundColor:
//                                                               Colors.grey,
//                                                         ),
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                           ListGroupsProvider
//                                                               .unjoinGroup(
//                                                             widget.url,
//                                                             group.id,
//                                                             widget.accessToken,
//                                                           );

//                                                           ListGroupsProvider
//                                                               .fetchAllGroups(
//                                                             widget.url,
//                                                             widget.accessToken,
//                                                           );
//                                                         },
//                                                         child: const Text(
//                                                           'UnJoin',
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.grey,
//                                             ),
//                                             child: const Text(
//                                               'Unjoin',
//                                               style: TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CreateGroupPage()),
//           );
//         },
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }

// // // ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names

// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
// // import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
// // import 'package:gp_screen/Pages/groups/myGroupsPage/UserGroupsScreen.dart';
// // // import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// // import 'package:gp_screen/Pages/tabbars/tabBar.dart';

// // import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
// // import 'package:gp_screen/Pages/groups/search/searchUiGroups.dart';
// // import 'package:gp_screen/Services/API_services.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import 'package:provider/provider.dart';

// // class listallgroups extends StatefulWidget {
// //   final String url;
// //   final String pageName;

// //   final String accessToken;

// //   listallgroups(
// //       {required this.url, required this.pageName, required this.accessToken});
// //   @override
// //   State<listallgroups> createState() => _listallgroupsState();
// // }

// // class _listallgroupsState extends State<listallgroups> {
// //   //  late Future<List<listGroupsModel>> futureGroups;
// //   final TextEditingController _passwordController = TextEditingController();
// //   late final String pageNamee;

// //   @override
// //   void initState() {
// //     super.initState();
// //     Provider.of<ListGroupsProvider>(context, listen: false)
// //         .fetchAllGroups(widget.url, widget.accessToken);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: tabbar(),
// //       body: FutureBuilder(
// //         future: Provider.of<ListGroupsProvider>(context, listen: false)
// //             .fetchAllGroups(widget.url, widget.accessToken),
// //         builder: (ctx, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return const Center(child: Text('Failed to Load Groups!'));
// //           } else {
// //             return Consumer<ListGroupsProvider>(
// //               builder: (ctx, ListGroupsProvider, _) {
// //                 return Column(
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.only(left: 8.0, right: 8),
// //                       child: Row(
// //                         children: [
// //                           Text(
// //                             widget.pageName,
// //                             style: const TextStyle(
// //                                 fontSize: 25, fontWeight: FontWeight.bold),
// //                           ),
// //                           const Spacer(
// //                             flex: 1,
// //                           ),
                          
// //                           Row(
// //                             children: [
// //                               ElevatedButton(onPressed: (){
                              
// //                                 Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => listallgroups(
// //                               url: 'recommend/',
// //                               pageName: 'Recommended Groups',
// //                               accessToken: accesstokenfinal),
// //                         ),
// //                       );
// //                               }, child: Text('Recommended Groups',style: TextStyle(color: Colors.white),)),
// //                             const Spacer(
// //                             flex: 1,
// //                           ),
// //                             ElevatedButton(onPressed: (){

// //                             Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => UserGroupsScreen(),
// //                           ),
// //                         );
// //                           }, child: Text('MyGroups',style: TextStyle(color: Colors.white),)),
// //                             ],
// //                           ),
                          
// //                           IconButton(
// //                               onPressed: () {
// //                                 print(widget.pageName);
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => SearchScreen(
// //                                         accessToken: accesstokenfinal),
// //                                   ),
// //                                 );
// //                               },
// //                               icon: const Icon(
// //                                 Icons.search,
// //                                 color: kprimaryColourcream,
// //                               )),
// //                         ],
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: ListView.builder(
// //                         itemCount: ListGroupsProvider.groups.length,
// //                         itemBuilder: (ctx, index) {
// //                           final group = ListGroupsProvider.groups[index];
// //                           return GestureDetector(
// //                             onTap: () {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) => GroupDetailPage(
// //                                       groupId: group.id,
// //                                       accessToken: accesstokenfinal),
// //                                 ),
// //                               );
// //                             },
// //                             child: Card(
// //                               color: kprimaryColourWhite,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(20.0),
// //                               ),
// //                               elevation: 5,
// //                               margin: const EdgeInsets.symmetric(
// //                                   horizontal: 10, vertical: 6),
// //                               child: Padding(
// //                                 padding: const EdgeInsets.all(10.0),
// //                                 child: Row(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     CircleAvatar(
// //                                       radius: 30,
// //                                       backgroundImage: group.image != null
// //                                           ? NetworkImage(group.image!)
// //                                           : null,
// //                                       backgroundColor: group.image == null
// //                                           ? kprimaryColourcream
// //                                           : Colors.transparent,
// //                                       child: group.image == null
// //                                           ? const Icon(Icons.group,
// //                                               size: 30, color: Colors.white)
// //                                           : null,
// //                                     ),
// //                                     const SizedBox(width: 10.0),
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             group.title,
// //                                             style: const TextStyle(
// //                                               fontSize: 18.0,
// //                                               fontWeight: FontWeight.bold,
// //                                             ),
// //                                           ),
// //                                           const SizedBox(height: 5.0),
// //                                           Text(group.subject),
// //                                           const SizedBox(height: 5.0),
// //                                           Row(
// //                                             children: [
// //                                               Text(group.type),
// //                                               const SizedBox(height: 5.0),
// //                                               Text(
// //                                                 ' ${group.members} Members',
// //                                                 style: TextStyle(
// //                                                     fontSize: 14,
// //                                                     color:
// //                                                         Colors.grey.shade500),
// //                                               ),
// //                                             ],
// //                                           )
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     Column(
// //                                       children: [
// //                                         if (!group.has_joined)
// //                                           ElevatedButton(
// //                                             onPressed: () {
// //                                               var type = group.type;
// //                                               print(group.type);
// //                                               if (type == "private") {
// //                                                 showDialog(
// //                                                   context: context,
// //                                                   builder:
// //                                                       (BuildContext context) {
// //                                                     return AlertDialog(
// //                                                       title: const Text(
// //                                                           'Enter Password'),
// //                                                       content: TextField(
// //                                                         controller:
// //                                                             _passwordController,
// //                                                         decoration:
// //                                                             const InputDecoration(
// //                                                           hintText: 'Password',
// //                                                         ),
// //                                                       ),
// //                                                       actions: [
// //                                                         TextButton(
// //                                                           onPressed: () {
// //                                                             Navigator.of(
// //                                                                     context)
// //                                                                 .pop();
// //                                                           },
// //                                                           child: const Text(
// //                                                               'Cancel'),
// //                                                         ),
// //                                                         ElevatedButton(
// //                                                           style: ElevatedButton
// //                                                               .styleFrom(
// //                                                             backgroundColor:
// //                                                                 kprimaryColourGreen,
// //                                                           ),
// //                                                           onPressed: () async {
// //                                                             await ListGroupsProvider
// //                                                                 .joinGroup(
// //                                                                     widget.url,
// //                                                                     group.id,
// //                                                                     widget
// //                                                                         .accessToken,
// //                                                                     _passwordController
// //                                                                         .text);
// //                                                             await ListGroupsProvider
// //                                                                 .fetchAllGroups(
// //                                                               widget.url,
// //                                                               widget
// //                                                                   .accessToken,
// //                                                             );

// //                                                             //                                                 getAllGroups()
// //                                                             // .getAllGroupsList_recommendation(widget.url, widget.accessToken);
// //                                                           },
// //                                                           child: const Text(
// //                                                             'Join',
// //                                                             style: TextStyle(
// //                                                                 color: Colors
// //                                                                     .white),
// //                                                           ),
// //                                                         ),
// //                                                       ],
// //                                                     );
// //                                                   },
// //                                                 );
// //                                               } else {
// //                                                 ListGroupsProvider.joinGroup(
// //                                                     widget.url,
// //                                                     group.id,
// //                                                     widget.accessToken,
// //                                                     _passwordController.text);
// //                                                 ListGroupsProvider
// //                                                     .fetchAllGroups(
// //                                                   widget.url,
// //                                                   widget.accessToken,
// //                                                 );
// //                                               }
// //                                             },
// //                                             style: ElevatedButton.styleFrom(
// //                                               backgroundColor:
// //                                                   kprimaryColourcream,
// //                                             ),
// //                                             child: const Text(
// //                                               'Join',
// //                                               style: TextStyle(
// //                                                   color: Colors.white),
// //                                             ),
// //                                           )
// //                                         else
// //                                           ElevatedButton(
// //                                             onPressed: () {
// //                                               showDialog(
// //                                                 context: context,
// //                                                 builder:
// //                                                     (BuildContext context) {
// //                                                   return AlertDialog(
// //                                                     title: const Text(
// //                                                         'unjoin the group '),
// //                                                     content: const Text(
// //                                                       'Are You Sure ?',
// //                                                       style: TextStyle(
// //                                                           fontSize: 20),
// //                                                     ),
// //                                                     actions: [
// //                                                       TextButton(
// //                                                         onPressed: () {
// //                                                           Navigator.of(context)
// //                                                               .pop();
// //                                                         },
// //                                                         child: const Text(
// //                                                             'Cancel'),
// //                                                       ),
// //                                                       ElevatedButton(
// //                                                         style: ElevatedButton
// //                                                             .styleFrom(
// //                                                           backgroundColor:
// //                                                               Colors.grey,
// //                                                         ),
// //                                                         onPressed: () {
// //                                                           Navigator.of(context)
// //                                                               .pop();
// //                                                           ListGroupsProvider
// //                                                               .unjoinGroup(
// //                                                             widget.url,
// //                                                             group.id,
// //                                                             widget.accessToken,
// //                                                           );

// //                                                           ListGroupsProvider
// //                                                               .fetchAllGroups(
// //                                                             widget.url,
// //                                                             widget.accessToken,
// //                                                           );
// //                                                         },
// //                                                         child: const Text(
// //                                                           'UnJoin',
// //                                                           style: TextStyle(
// //                                                               color:
// //                                                                   Colors.white),
// //                                                         ),
// //                                                       ),
// //                                                     ],
// //                                                   );
// //                                                 },
// //                                               );
// //                                             },
// //                                             style: ElevatedButton.styleFrom(
// //                                               backgroundColor: Colors.grey,
// //                                             ),
// //                                             child: const Text(
// //                                               'Unjoin',
// //                                               style: TextStyle(
// //                                                   color: Colors.white),
// //                                             ),
// //                                           ),
// //                                       ],
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                   ],
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (context) => CreateGroupPage()),
// //           );
// //         },
// //         backgroundColor: Colors.green,
// //         child: const Icon(Icons.add, color: Colors.white),
// //       ),
// //     );
// //   }
// // }
