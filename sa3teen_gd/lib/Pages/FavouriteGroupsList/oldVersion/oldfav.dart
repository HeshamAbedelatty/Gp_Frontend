
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/listofMyGroupsPage.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// import '../GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FavoriteGroupsPage(),
//     );
//   }
// }

// List<GroupPage> favoriteGroups = [
//   GroupPage(
//     id: 1,
//     groupState: 'private',
//     groupName: 'favoriteGroup 1',
//     groupImageUrl: 'https://example.com/group_image_1.jpg',
//     members: const ['Member 1', 'Member 2', 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 2,
//     groupState: 'public',
//     groupName: 'favoriteGroup 2',
//     groupImageUrl: 'https://example.com/group_image_2.jpg',
//     members: const ['Member A', 'Member B', 'Member C'],
//   ),
//   GroupPage(
//     id: 3,
//     groupState: 'private',
//     groupName: 'favoriteGroup 3',
//     groupImageUrl: 'https://example.com/group_image_3.jpg',
//     members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 4,
//     groupState: 'private',
//     groupName: 'favoriteGroup 4',
//     groupImageUrl: 'https://example.com/group_image_4.jpg',
//     members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 5,
//     groupState: 'private',
//     groupName: 'favoriteGroup 5',
//     groupImageUrl: 'https://example.com/group_image_4.jpg',
//     members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 5,
//     groupState: 'public',
//     groupName: 'favoriteGroup 6',
//     groupImageUrl: 'https://example.com/group_image_5.jpg',
//     members: const ['Member X', 'Member Y', 'Member Z'],
//   ),
//   GroupPage(
//     id: 6,
//     groupState: 'private',
//     groupName: 'favoriteGroup 7',
//     groupImageUrl: 'https://example.com/group_image_6.jpg',
//     members: const ['Member L', 'Member M'],
//   ),
//   GroupPage(
//     id: 7,
//     groupState: 'private',
//     groupName: 'favoriteGroup 8',
//     groupImageUrl: 'https://example.com/group_image_7.jpg',
//     members: const ['Member N', 'Member O'],
//   ),
//   GroupPage(
//     id: 8,
//     groupState: 'private',
//     groupName: 'favoriteGroup 9',
//     groupImageUrl: 'https://example.com/group_image_7.jpg',
//     members: const ['Member N', 'Member O'],
//   ),
//   GroupPage(
//     id: 9,
//     groupState: 'private',
//     groupName: 'favoriteGroup 10',
//     groupImageUrl: 'https://example.com/group_image_7.jpg',
//     members: const ['Member N', 'Member O'],
//   ),
// ];

// class FavoriteGroupsPage extends StatefulWidget {
//   @override
//   State<FavoriteGroupsPage> createState() => _FavoriteGroupsPageState();
// }

// class _FavoriteGroupsPageState extends State<FavoriteGroupsPage> {
//   final List<GroupPage> groups = favoriteGroups;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16.0, right: 10.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Your Favorite Groups :',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: groups.length,
//               itemBuilder: (context, index) {
//                 return GroupCard(group: groups[index],isFavorite:true, onFavoriteToggle: (GroupPage ) { setState(() {
//                       if (favoriteGroups.contains(groups)) {
//                         favoriteGroups.remove(groups);
//                       } else {
//                         // favoriteGroups.add(groups);
//                       }
//                     }); },);
//               },
//             ),
//           ),
          
          
//         ],
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/listofMyGroupsPage.dart';

// class FavoriteGroupsPage extends StatefulWidget {
//   final List<GroupPage> favoriteGroups;

//   FavoriteGroupsPage({required this.favoriteGroups});

//   @override
//   State<FavoriteGroupsPage> createState() => _FavoriteGroupsPageState();
// }

// class _FavoriteGroupsPageState extends State<FavoriteGroupsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 19.0,top: 8),
//             child: Row(mainAxisAlignment:MainAxisAlignment.start ,
//               children: [
//                 const Text(
//                   'Your Favorite Groups',
//                   style: TextStyle(
//                     fontSize: 22,
//                     // fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.favoriteGroups.length,
//               itemBuilder: (context, index) {
//                 return GroupCard(
//                   group: widget.favoriteGroups[index],
//                   isFavorite: true,
//                   onFavoriteToggle: (GroupPage group) {
//                     // Do nothing here
//                     setState(() {
//                       if (widget.favoriteGroups.contains(group)) {
//                         widget.favoriteGroups.remove(group);
//                       } else {
//                         widget.favoriteGroups.add(group);
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GroupDetailPage extends StatelessWidget {
//   final GroupPage group;

//   GroupDetailPage({required this.group});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(group.groupName),
//       ),
//       body: Center(
//         child: Text(group.groupName),
//       ),
//     );
//   }
// }
