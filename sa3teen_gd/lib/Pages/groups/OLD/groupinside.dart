// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/Gapi.dart';

// class GroupDetailPage extends StatefulWidget {
//   final int groupId;
//   final String accessToken;

//   GroupDetailPage({required this.groupId, required this.accessToken});

//   @override
//   _GroupDetailPageState createState() => _GroupDetailPageState();
// }

// class _GroupDetailPageState extends State<GroupDetailPage> {
//   late Future<ListGroupsModel> futureGroup;

//   @override
//   void initState() {
//     super.initState();
//     futureGroup = GroupService().getGroupById(widget.accessToken, widget.groupId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Group Details'),
//       ),
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
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('ID: ${group.id}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Title: ${group.title}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Description: ${group.description}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Type: ${group.type}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Subject: ${group.subject}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Members: ${group.members}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   group.image != null
//                       ? Image.network(group.image!)
//                       : Text('No image available', style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
// // import 'package:gp_screen/Pages/listofMyGroupsPage/groups/Gapi.dart';

// // class GroupDetailPage extends StatefulWidget {
// //   final int groupId;
// //   final String accessToken;

// //   GroupDetailPage({required this.groupId, required this.accessToken});

// //   @override
// //   _GroupDetailPageState createState() => _GroupDetailPageState();
// // }

// // class _GroupDetailPageState extends State<GroupDetailPage> {
// //   late Future<ListGroupsModel> futureGroup;

// //   @override
// //   void initState() {
// //     super.initState();
// //     futureGroup = GroupService().getGroupById(widget.accessToken, widget.groupId);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Group Details'),
// //       ),
// //       body: FutureBuilder<ListGroupsModel>(
// //         future: futureGroup,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData) {
// //             return Center(child: Text('No data found'));
// //           } else {
// //             final group = snapshot.data!;
// //             return Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('ID: ${group.id}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   Text('Title: ${group.title}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   Text('Description: ${group.description}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   Text('Type: ${group.type}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   Text('Subject: ${group.subject}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   Text('Members: ${group.members}', style: TextStyle(fontSize: 18)),
// //                   SizedBox(height: 8),
// //                   group.image != null
// //                       ? Image.network(group.image!)
// //                       : Text('No image available', style: TextStyle(fontSize: 18)),
// //                 ],
// //               ),
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// // class GroupService {
// //   Future<ListGroupsModel> getGroupById(String accessToken, int id) async {
// //     Map<String, String> headers = {
// //       'Authorization': 'Bearer $accessToken',
// //     };

// //     dynamic data = await Api().get(
// //       url: 'http://10.0.2.2:8000/groups/$id/',
// //       headers: headers,
// //     );

// //     ListGroupsModel group = ListGroupsModel.fromJson(data);

// //     // Print the retrieved object using the overridden toString method
// //     print(group);

// //     return group;
// //   }
// // }
