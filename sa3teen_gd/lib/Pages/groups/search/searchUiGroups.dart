import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/ModellistGroups.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
import 'package:gp_screen/Pages/APIsSalma/listGroup/ModellistGroups.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  final String accessToken;

  SearchScreen({required this.accessToken});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final groupProvider = Provider.of<GroupProvider>(context, listen: false);
      groupProvider.searchGroupsByTitle(query, widget.accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      appBar: tabbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                labelText: 'Search',
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 20),
            groupProvider.isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: groupProvider.groups.length,
                      itemBuilder: (context, index) {
                        final group = groupProvider.groups[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupDetailPage(
                                  groupId: group.id,
                                  accessToken: widget.accessToken,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: kprimaryColourWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 5,
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
                                        ? const Icon(Icons.group, size: 30, color: Colors.white)
                                        : null,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                            const SizedBox(width: 5.0),
                                            Text(
                                              ' ${group.members} Members',
                                              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     if (!group.has_joined)
                                  //       ElevatedButton(
                                  //         onPressed: () => _handleJoinGroup(context, group),
                                  //         style: ElevatedButton.styleFrom(backgroundColor: kprimaryColourcream),
                                  //         child: const Text('Join', style: TextStyle(color: Colors.white)),
                                  //       )
                                  //     else
                                  //       ElevatedButton(
                                  //         onPressed: () => _handleUnjoinGroup(context, group),
                                  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                  //         child: const Text('Unjoin', style: TextStyle(color: Colors.white)),
                                  //       ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _handleJoinGroup(BuildContext context, listGroupsModel group) {
    if (group.type == "private") {
      _showPasswordDialog(context, group);
    } else {
      _joinGroup(context, group, null);
    }
  }

  void _handleUnjoinGroup(BuildContext context, listGroupsModel group) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unjoin the group'),
          content: const Text('Are you sure?', style: TextStyle(fontSize: 20)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<ListGroupsProvider>(context, listen: false).unjoinGroup(
                  'groups/list_groups/',
                  group.id,
                  widget.accessToken,
                );
                Provider.of<ListGroupsProvider>(context, listen: false).fetchAllGroups(
                  'groups/list_groups/',
                  widget.accessToken,
                );
              },
              child: const Text('Unjoin', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordDialog(BuildContext context, listGroupsModel group) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Password'),
          content: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kprimaryColourGreen),
              onPressed: () {
                Navigator.of(context).pop();
                _joinGroup(context, group, _passwordController.text);
              },
              child: const Text('Join', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _joinGroup(BuildContext context, listGroupsModel group, String? password) {
    Provider.of<ListGroupsProvider>(context, listen: false).joinGroup(
      'groups/list_groups/',
      group.id,
      widget.accessToken,
      password,
    );
    Provider.of<ListGroupsProvider>(context, listen: false).fetchAllGroups(
      'groups/list_groups/',
      widget.accessToken,
    );
    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupDetailPage(
                                      groupId: group.id,
                                      accessToken: accesstokenfinal),
                                ),
                              );
  }
}

// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, unused_field, prefer_final_fields, avoid_print
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/APIsSalma/ModellistGroups.dart';
// import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
// // import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/tabbars/tabBar.dart';

// import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
// import 'package:gp_screen/Pages/APIsSalma/searchGroupProvider.dart';
// import 'package:gp_screen/Pages/APIsSalma/listGroup/getAPIListGroups.dart';
// import 'package:gp_screen/Pages/APIsSalma/listGroup/ModellistGroups.dart';
// import 'package:gp_screen/Services/API_services.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';

// class SearchScreen extends StatefulWidget {
//   final String accessToken;

//   SearchScreen({required this.accessToken});

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   Timer? _debounce;
//   late Future<List<listGroupsModel>> futureGroups;
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscureText = true;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

// //34an ytl3 l 7aga we ana bktb
//   void _onSearchChanged(String query) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       final groupProvider = Provider.of<GroupProvider>(context, listen: false);
//       groupProvider.searchGroupsByTitle(query, widget.accessToken);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final groupProvider = Provider.of<GroupProvider>(context);

//     return Scaffold(
//       appBar: tabbar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//                 labelText: 'Search',
//               ),
//               onChanged: _onSearchChanged,
//             ),
//             const SizedBox(height: 20),
//             groupProvider.isLoading
//                 ? const CircularProgressIndicator()
//                 : Expanded(
//                     child: ListView.builder(
//                       itemCount: groupProvider.groups.length,
//                       itemBuilder: (context, index) {
//                         final group = groupProvider.groups[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => GroupDetailPage(
//                                     groupId: group.id,
//                                     accessToken:
//                                         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
//                               ),
//                             );
//                             // Navigator.push
//                           },
//                           child: Card(
//                             color: kprimaryColourWhite,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             elevation: 5,
//                             // margin: const EdgeInsets.symmetric(
//                             //     horizontal: 10, vertical: 6),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: group.image != null
//                                         ? NetworkImage(group.image!)
//                                         : null,
//                                     backgroundColor: group.image == null
//                                         ? kprimaryColourcream
//                                         : Colors.transparent,
//                                     child: group.image == null
//                                         ? const Icon(Icons.group,
//                                             size: 30, color: Colors.white)
//                                         : null,
//                                   ),
//                                   const SizedBox(width: 10.0),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           group.title,
//                                           style: const TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5.0),
//                                         Text(group.subject),
//                                         const SizedBox(height: 5.0),
//                                         Row(
//                                           children: [
//                                             Text(group.type),
//                                             const SizedBox(height: 5.0),
//                                             Text(
//                                               ' ${group.members} Members',
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey.shade500),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     children: [
//                                       if (!group.has_joined)
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             var type = group.type;
//                                             print(group.type);
//                                             if (type == "private") {
//                                               showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'Enter Password'),
//                                                     content: TextField(
//                                                       controller:
//                                                           _passwordController,
//                                                       decoration:
//                                                           const InputDecoration(
//                                                         hintText: 'Password',
//                                                       ),
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
//                                                               kprimaryColourGreen,
//                                                         ),
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                           Provider.of<ListGroupsProvider>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .joinGroup(
//                                                             'groups/list_groups/',
//                                                             group.id,
//                                                             accesstokenfinal,
//                                                             _passwordController
//                                                                 .text,
//                                                           );
//                                                           Provider.of<ListGroupsProvider>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .fetchAllGroups(
//                                                                   'groups/list_groups/',
//                                                                   widget
//                                                                       .accessToken);
//                                                           //  await ListGroupsProvider
//                                                           //       .joinGroup(
//                                                           //           widget.url,
//                                                           //           group.id,
//                                                           //           widget
//                                                           //               .accessToken,
//                                                           //           _passwordController
//                                                           //               .text);
//                                                           // joinGroup(
//                                                           //   group.id,
//                                                           //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
//                                                           //   _passwordController
//                                                           //       .text,
//                                                           // );
//                                                         },
//                                                         child: const Text(
//                                                           'Join',
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               );
//                                             } else {
//                                               Provider.of<ListGroupsProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .joinGroup(
//                                                 'groups/list_groups/',
//                                                 group.id,
//                                                 accesstokenfinal,
//                                                 _passwordController.text,
//                                               );
//                                               Provider.of<ListGroupsProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .fetchAllGroups(
//                                                       'groups/list_groups/',
//                                                       widget.accessToken);
//                                               // joinGroup(
//                                               //   group.id,
//                                               //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
//                                               //   null,
//                                               // );
//                                             }
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 kprimaryColourcream,
//                                           ),
//                                           child: const Text(
//                                             'Join',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         )
//                                       else
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: const Text(
//                                                       'unjoin the group '),
//                                                   content: const Text(
//                                                     'Are You Sure ?',
//                                                     style:
//                                                         TextStyle(fontSize: 20),
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                       },
//                                                       child:
//                                                           const Text('Cancel'),
//                                                     ),
//                                                     ElevatedButton(
//                                                       style: ElevatedButton
//                                                           .styleFrom(
//                                                         backgroundColor:
//                                                             Colors.grey,
//                                                       ),
//                                                       onPressed: () {
//                                                         Navigator.of(context)
//                                                             .pop();
//                                                         Provider.of<ListGroupsProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .unjoinGroup(
//                                                           'groups/list_groups/',
//                                                           group.id,
//                                                           accesstokenfinal,
//                                                         );
//                                                         Provider.of<ListGroupsProvider>(
//                                                                 context,
//                                                                 listen: false)
//                                                             .fetchAllGroups(
//                                                                 'groups/list_groups/',
//                                                                 widget
//                                                                     .accessToken);
//                                                       },
//                                                       child: const Text(
//                                                         'UnJoin',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.grey,
//                                           ),
//                                           child: const Text(
//                                             'Unjoin',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
