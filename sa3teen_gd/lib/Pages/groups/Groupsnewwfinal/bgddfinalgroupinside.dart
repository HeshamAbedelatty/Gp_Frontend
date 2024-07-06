import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/Groupsnewwfinal/EditGroupScreenfinal.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/uiiiGroupDetailsPage.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/membersCircle.dart';
import 'package:provider/provider.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postnewwwbgddd/CreatePostScreen.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/usersInGroupsPage.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/Materials.dart';
import 'package:gp_screen/Pages/groups/postAndComments/postsComments.dart';
import 'package:gp_screen/Pages/groups/OLD/beforeProvider/apis/GroupsAPI.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/cmodel.dart';
import 'package:gp_screen/Pages/groups/Groupsnewwfinal/GroupsAPIfinal.dart';

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
      // AppBar(
      //   title: Text('Group Details'),
      // ),
      body: FutureBuilder<void>(
        future: _futureGroup,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final group = groupProvider.selectedGroup;
            if (group == null) {
              return Center(child: Text('No data found'));
            } else {
              groupIDd = group.id;
              return ListView(
                children: [
                  SizedBox(height: 8),
                  group.image != null
                      ? Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
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
                          decoration: BoxDecoration(
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
                    padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(group.title,
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold)),
                            Spacer(
                              flex: 1,
                            ),
                            IconButton(
                                icon: Icon(
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
                        // SizedBox(height: 3),
                        Text(group.subject,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700)),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 40,
                          child: GroupUsersOverviewPage(
                              id: group.id, token: widget.accessToken),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
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
                            Spacer(),
                          ],
                        ),
                        // SizedBox(height: 8),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // RoundedButton(
                        //     //   height: 40,
                        //     //   width: 175,
                        //     //   colory: kprimaryColourGreen,
                        //     //   buttonText: 'Group Setting',
                        //     //   onPressed: () {
                        //     //     print('Group Setting button clicked!');
                        //     //   },
                        //     // ),
                        //     SizedBox(width: 16),
                        //     // RoundedButton(
                        //     //   height: 40,
                        //     //   width: 175,
                        //     //   colory: kprimaryColourcream,
                        //     //   buttonText: 'Share',
                        //     //   onPressed: () {
                        //     //     print('Share button clicked!');
                        //     //   },
                        //     // ),
                        //   ],
                        // ),
                        SizedBox(height: 12),
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
                                            title: Text('Description'),
                                            content: Text(
                                              group.description,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(width: 16),
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
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => MaterialsPage(
                                      //         groupID: group.id,
                                      //         id: group.id,
                                      //       ),
                                      //     ));

                                      print('Files button clicked!');
                                    },
                                  ),

                                  SizedBox(width: 16),
                                  //                       IconButton(
                                  //         icon: Icon(Icons.delete, color: kprimaryColourcream),
                                  //         onPressed: () async {
                                  //           // await Provider.of<GroupsProvider>(context, listen: false)
                                  //           //     .deleteGroup(context,group.id,
                                  //           //    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'
                                  //           //     // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'
                                  //           //     );
                                  //                bool isDeleted = await Provider.of<GroupsProvider>(context, listen: false)
                                  //     .deleteGroup(context,group.id,
                                  //                              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'

                                  //     );
                                  // if (isDeleted) {
                                  //   Navigator.pop(context);
                                  // } else {
                                  //   // Handle failure
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text('Failed to delete group')),
                                  //   );
                                  // }
                                  //         },
                                  //       ),
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
                                          SnackBar(
                                              content: Text(
                                                  'Failed to delete group')),
                                        );
                                      }

                                      print('Event button clicked!');
                                    },
                                  ),
                                  SizedBox(width: 16),
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
                                              // id: group.id,
                                              // token: widget.accessToken,
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
                        SizedBox(height: 12),
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
                groupId: groupIDd!, // Replace with your actual group ID
                accessToken:
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw', // Replace with your actual access token
              ),
            ),
          );
        },
        //  _showPostDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
// }

// }
