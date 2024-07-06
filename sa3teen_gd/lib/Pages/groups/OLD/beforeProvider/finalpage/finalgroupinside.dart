// before provider 

// // ignore_for_file: avoid_print, sized_box_for_whitespace
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/RoundedButtonForGroups.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/oldVersions/lastSucssesBeforeGroups/Models/PostAndCommentModel.dart';
// import 'package:gp_screen/Pages/groups/Materialsscreen/Materials.dart';
// import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/CreatePostScreen.dart';
// import 'package:gp_screen/Pages/groups/postAndComments/newwwbgddd/uiiiGroupDetailsPage.dart';
// import 'package:gp_screen/Pages/groups/usersinGroups/membersCircle.dart';
// import 'package:gp_screen/Pages/groups/usersinGroups/usersInGroupsPage.dart';
// import 'package:gp_screen/Pages/groups/apis/GroupsAPI.dart';
// import 'package:gp_screen/Pages/groups/postAndComments/postsComments.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// class GroupDetailPage extends StatefulWidget {
//   final int groupId;
//   final String accessToken;

//   GroupDetailPage({required this.groupId, required this.accessToken});

//   @override
//   _GroupDetailPageState createState() => _GroupDetailPageState();
// }

// class _GroupDetailPageState extends State<GroupDetailPage> {
//   late Future<ListGroupsModel> futureGroup;
//   List<Post> _posts = [];
//   Map<String, TextEditingController> _commentControllers = {};
//   Map<String, TextEditingController> _replyControllers = {};
//   Map<String, bool> _showReplyFields = {};
//   int? groupIDd;
//   @override
//   void initState() {
//     super.initState();
//     futureGroup =
//         GroupService().getGroupById(widget.accessToken, widget.groupId);
//   }


//   @override
//   void dispose() {
//     _commentControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     _replyControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: FutureBuilder<ListGroupsModel>(
//         future: futureGroup,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data found'));
//           } else {
//             final group = snapshot.data!;
//             groupIDd = group.id;
//             return ListView(
//               children: [
//                 const SizedBox(height: 8),
//                 group.image != null
//                     ? Container(
//                         height: 150,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20)),
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(group.image!),
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 150,
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(20)),
//                             color: kprimaryColourcream),
//                         child: Icon(
//                           Icons.group,
//                           size: 50,
//                           color: Colors.grey.shade800,
//                         ),
//                       ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 12.0, right: 12.0, top: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(group.title,
//                           style: const TextStyle(
//                               fontSize: 26, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 3),
//                       Text(group.subject,
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.grey.shade700)),
//                       Container(
//                         height: 40,
//                         child: GroupUsersOverviewPage(
//                             id: group.id,
//                             token:
//                                 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.lock,
//                             color: Colors.grey,
//                             size: 18,
//                           ),
//                           Text(' ${group.type} group ',
//                               style: TextStyle(
//                                   fontSize: 18, color: Colors.grey.shade700)),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => GroupUsersPage(
//                                       id: group.id,
//                                       token:
//                                           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'),
//                                 ),
//                               );
//                             },
//                             child: Text('(${group.members} members)',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.grey.shade600)),
//                           ),
//                           Spacer(flex: 1),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           RoundedButton(
//                             height: 40,
//                             width: 175,
//                             colory: kprimaryColourGreen,
//                             buttonText: 'Group Setting',
//                             onPressed: () {
//                               print('Group Setting button clicked!');
//                             },
//                           ),
//                           const SizedBox(width: 16),
//                           RoundedButton(
//                             height: 40,
//                             width: 175,
//                             colory: kprimaryColourcream,
//                             buttonText: 'Share',
//                             onPressed: () {
//                               print('Share button clicked!');
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         height: 50,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 RoundedButton(
//                                   height: 40,
//                                   width: 110,
//                                   colory: kprimaryColourcream,
//                                   buttonText: 'Description',
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('Description'),
//                                           content: Text(
//                                             group.description,
//                                             style:
//                                                 const TextStyle(fontSize: 18),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Close'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 const SizedBox(width: 16),
//                                 RoundedButton(
//                                   height: 40,
//                                   width: 110,
//                                   colory: kprimaryColourcream,
//                                   buttonText: 'Materials',
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => MaterialsPage(
//                                             groupID: group.id,
//                                             id: group.id,
//                                           ),
//                                         ));

//                                     print('Files button clicked!');
//                                   },
//                                 ),
//                                 const SizedBox(width: 16),
//                                 RoundedButton(
//                                   height: 40,
//                                   width: 60,
//                                   colory: kprimaryColourcream,
//                                   buttonText: 'You',
//                                   onPressed: () {
//                                     print('Event button clicked!');
//                                   },
//                                 ),
//                                 const SizedBox(width: 16),
//                                 RoundedButton(
//                                   height: 40,
//                                   width: 100,
//                                   colory: kprimaryColourcream,
//                                   buttonText: 'Favorites',
//                                   onPressed: () {
//                                     print('Modules button clicked!');
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Expanded(child: PostList(groupId: group.id)),
//                 Expanded(
//                   child:
//                       Container(height: 600, child: PostList(groupId: group.id)
                 
//                           ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreatePostScreen(
//                 groupId: groupIDd!, // Replace with your actual group ID
//                 accessToken:
//                     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw', // Replace with your actual access token
//               ),
//             ),
//           );
          
//         },
//         //  _showPostDialog,
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
