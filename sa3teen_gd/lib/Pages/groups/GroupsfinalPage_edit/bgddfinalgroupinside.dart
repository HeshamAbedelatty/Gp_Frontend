// ignore_for_file: sized_box_for_whitespace, avoid_print, use_build_context_synchronously, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Widgets/RoundedButtonForGroups.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/EditGroupScreenfinal.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/postDetailsPageuiFinal.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/membersCirclesui.dart';
import 'package:provider/provider.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/CreatePostScreen.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/usersInGroupsPage.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/ui/Materials.dart';
import 'package:gp_screen/Pages/apis/GroupsAPIfinal.dart';

class GroupDetailPage extends StatefulWidget {
  final int groupId;
  final String accessToken;

  GroupDetailPage({required this.groupId, required this.accessToken});

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  late Future<void> _futureGroup;
  late int groupIDd;
  @override
  void initState() {
    super.initState();
    _futureGroup = Provider.of<GroupsProvider>(context, listen: false)
        .getGroupById(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupsProvider>(context);

    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder<void>(
        future: _futureGroup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final group = groupProvider.selectedGroup;
            if (group == null) {
              return const Center(child: Text('No data found'));
            } else {
              groupIDd = group.id;
              return ListView(
                children: [
                  const SizedBox(height: 8),
                  group.image != null
                      ? Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(group.image!),
                            ),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20)),
                              color: kprimaryColourcream),
                          child: Icon(
                            Icons.group,
                            size: 50,
                            color: Colors.grey.shade800,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(group.title,
                                style: const TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold)),
                            const Spacer(
                              flex: 1,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: kprimaryColourcream,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditGroupScreen(group: group),
                                    ),
                                  );
                                }),
                          ],
                        ),
                        Text(group.subject,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700)),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 40,
                          child: GroupUsersOverviewPage(
                              id: group.id, token: widget.accessToken),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                              size: 18,
                            ),
                            Text(' ${group.type} group ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey.shade700)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GroupUsersPage(
                                        id: group.id,
                                        token: widget.accessToken),
                                  ),
                                );
                              },
                              child: Text('(${group.members} members)',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600)),
                            ),
                            const Spacer(),
                          ],
                        ),
                       
                        const SizedBox(height: 12),
                        Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedButton(
                                    height: 40,
                                    width: 110,
                                    colory: kprimaryColourGreen,
                                    buttonText: 'Description',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Description'),
                                            content: Text(
                                              group.description,
                                              style: const TextStyle(fontSize: 18),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  RoundedButton(
                                    height: 40,
                                    width: 110,
                                    colory: kprimaryColourcream,
                                    buttonText: 'Materials',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MaterialsScreen(
                                              groupId: group.id,
                                              token:
                                                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                                        ),
                                      );
                              

                                      print('Files button clicked!');
                                    },
                                  ),

                                  const SizedBox(width: 16),
                              
                                  RoundedButton(
                                    height: 40,
                                    width: 75,
                                    colory: kprimaryColourGreen,
                                    buttonText: 'delete',
                                    onPressed: () async {
                                      bool isDeleted = await Provider.of<
                                                  GroupsProvider>(context,
                                              listen: false)
                                          .deleteGroup(context, group.id,
                                              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU');
                                      if (isDeleted) {
                                        Navigator.pop(context);
                                      } else {
                                        // Handle failure
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Failed to delete group')),
                                        );
                                      }

                                      print('Event button clicked!');
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  RoundedButton(
                                    height: 40,
                                    width: 110,
                                    colory: kprimaryColourcream,
                                    buttonText: 'Posts',
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PostList(
                                             
                                              groupId: widget.groupId,
                                            ),
                                          ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 600, child: PostList(groupId: group.id)),
                  ),
                ],
              );
            }
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(
                groupId: groupIDd, // Replace with your actual group ID !
                accessToken:
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw', // Replace with your actual access token
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
