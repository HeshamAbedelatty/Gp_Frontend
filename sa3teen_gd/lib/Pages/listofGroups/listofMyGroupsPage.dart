import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

import '../GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupListPage(),
    );
  }
}

List<GroupPage> sampleGroups = [
  GroupPage(
    id: 1,
    groupState: 'private',
    groupName: 'Group Name 1',
    groupImageUrl: 'https://example.com/group_image_1.jpg',
    members: const ['Member 1', 'Member 2', 'Member 3', 'Member 4'],
  ),
  GroupPage(
    id: 2,
    groupState: 'public',
    groupName: 'Group Name 2',
    groupImageUrl: 'https://example.com/group_image_2.jpg',
    members: const ['Member A', 'Member B', 'Member C'],
  ),
  GroupPage(
    id: 3,
    groupState: 'private',
    groupName: 'Group Name 3',
    groupImageUrl: 'https://example.com/group_image_3.jpg',
    members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
  ),
  GroupPage(
    id: 4,
    groupState: 'private',
    groupName: 'Group Name 4',
    groupImageUrl: 'https://example.com/group_image_4.jpg',
    members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
  ),
  GroupPage(
    id: 5,
    groupState: 'private',
    groupName: 'Group Name 5',
    groupImageUrl: 'https://example.com/group_image_4.jpg',
    members: const ['Member A', 'Member B', 'Member C', 'Member 3', 'Member 4'],
  ),
];

List<GroupPage> recommendedGroups = [
  GroupPage(
    id: 5,
    groupState: 'public',
    groupName: 'Recommended Group 1',
    groupImageUrl: 'https://example.com/group_image_5.jpg',
    members: const ['Member X', 'Member Y', 'Member Z'],
  ),
  GroupPage(
    id: 6,
    groupState: 'private',
    groupName: 'Recommended Group 2',
    groupImageUrl: 'https://example.com/group_image_6.jpg',
    members: const ['Member L', 'Member M'],
  ),
  GroupPage(
    id: 7,
    groupState: 'private',
    groupName: 'Recommended Group 3',
    groupImageUrl: 'https://example.com/group_image_7.jpg',
    members: const ['Member N', 'Member O'],
  ),
  GroupPage(
    id: 8,
    groupState: 'private',
    groupName: 'Recommended Group 4',
    groupImageUrl: 'https://example.com/group_image_7.jpg',
    members: const ['Member N', 'Member O'],
  ),
  GroupPage(
    id: 9,
    groupState: 'private',
    groupName: 'Recommended Group 5',
    groupImageUrl: 'https://example.com/group_image_7.jpg',
    members: const ['Member N', 'Member O'],
  ),
];

class GroupListPage extends StatelessWidget {
  final List<GroupPage> groups = sampleGroups;
  final List<GroupPage> group = recommendedGroups;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GroupCard(group: groups[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Recommended For You',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      'see all',
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedGroups.length,
              itemBuilder: (context, index) {
                return RecommendedGroupCard(group: recommendedGroups[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final GroupPage group;

  GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupDetailPage(group: group),
            ),
          );
        },
        child: Card(
          color: kprimaryColourWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(group.groupImageUrl),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.groupName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text('${group.members.length} Members'),
                      const SizedBox(height: 5.0),
                      Text(group.groupState),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class RecommendedGroupCard extends StatelessWidget {
  final GroupPage group;

  RecommendedGroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupDetailPage(group: group),
          ),
        );
      },
      child: Container(
        width: 200,
        child: Card(
          color: kprimaryColourWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40, // Increased radius for the avatar
                  backgroundImage: NetworkImage(group.groupImageUrl),
                ),
                SizedBox(height: 5.0),
                Text(
                  group.groupName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 5.0),
                Text(
                  '${group.members.length} Members',
                  textAlign: TextAlign.center,
                ),
                Text(
                  group.groupState,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupDetailPage extends StatelessWidget {
  final GroupPage group;

  GroupDetailPage({required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.groupName),
      ),
      body: Center(
        child: Text(group.groupName),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/fortheGroup/tabBar.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// import '../GroupPostAndCommentPage/myAttemptForGroups/Pages/groups2.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: GroupListPage(),
//     );
//   }
// }

// List<GroupPage> sampleGroups = [
//   GroupPage(
//     id: 1,
//     groupState: 'private',
//     groupName: 'Group Name 1',
//     groupImageUrl: 'https://example.com/group_image_1.jpg',
//     members: const ['Member 1', 'Member 2', 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 2,
//     groupState: 'public',
//     groupName: 'Group Name 2',
//     groupImageUrl: 'https://example.com/group_image_2.jpg',
//     members: const ['Member A', 'Member B', 'Member C'],
//   ),GroupPage(
//     id: 2,
//     groupState: 'private',
//     groupName: 'Group Name 3',
//     groupImageUrl: 'https://example.com/group_image_2.jpg',
//     members: const ['Member A', 'Member B', 'Member C' 'Member 3', 'Member 4'],
//   ),
//   GroupPage(
//     id: 2,
//     groupState: 'private',
//     groupName: 'Group Name 3',
//     groupImageUrl: 'https://example.com/group_image_2.jpg',
//     members: const ['Member A', 'Member B', 'Member C' 'Member 3', 'Member 4'],
//   ),GroupPage(
//     id: 2,
//     groupState: 'private',
//     groupName: 'Group Name 3',
//     groupImageUrl: 'https://example.com/group_image_2.jpg',
//     members: const ['Member A', 'Member B', 'Member C' 'Member 3', 'Member 4'],
//   ),
//   // Add more groups as needed
// ];

// List<GroupPage> recommendedGroups = [
//   GroupPage(
//     id: 3,
//     groupState: 'public',
//     groupName: 'Recommended Group 1',
//     groupImageUrl: 'https://example.com/group_image_3.jpg',
//     members: const ['Member X', 'Member Y', 'Member Z'],
//   ),
//   GroupPage(
//     id: 4,
//     groupState: 'private',
//     groupName: 'Recommended Group 2',
//     groupImageUrl: 'https://example.com/group_image_4.jpg',
//     members: const ['Member L', 'Member M'],
//   ),
//   GroupPage(
//     id: 4,
//     groupState: 'private',
//     groupName: 'Recommended Group 2',
//     groupImageUrl: 'https://example.com/group_image_4.jpg',
//     members: const ['Member L', 'Member M'],
//   ),GroupPage(
//     id: 4,
//     groupState: 'private',
//     groupName: 'Recommended Group 2',
//     groupImageUrl: 'https://example.com/group_image_4.jpg',
//     members: const ['Member L', 'Member M'],
//   ),
// ];


// class GroupListPage extends StatelessWidget {
//   final List<GroupPage> groups = sampleGroups;
//   final List<GroupPage> group = recommendedGroups;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:tabbar(),
//       body: Column(
//         children: [Expanded(
//             child: ListView.builder(
//               itemCount: groups.length,
//               itemBuilder: (context, index) {
//                 return GroupCard(group: groups[index]);
//               },
//             ),
//           ),
//          const Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0,right: 10.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Recommended For You',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Spacer(flex: 1,),
//                      Text(
//                       'see all',
//                       style: TextStyle(
//                         fontSize: 18,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 150,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: recommendedGroups.length,
//               itemBuilder: (context, index) {
//                 return RecommendedGroupCard(group: recommendedGroups[index]);
//               },
//             ),
//           ),
          
//         ],
//       ),
//     );
//   }
// }

// class GroupCard extends StatelessWidget {
//   final GroupPage group;

//   GroupCard({required this.group});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0,right: 8.0),
//       child: Card(
//         color: kprimaryColourWhite,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         margin:const EdgeInsets.all(10.0),
//         child: Padding(
//           padding:const EdgeInsets.all(10.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // CircleAvatar(),
//               CircleAvatar(
//                 radius: 30,
//                                   backgroundImage:
//                                       NetworkImage( group.groupImageUrl,),
//                                 ),
//              const SizedBox(width: 10.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       group.groupName,
//                       style:const TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   const  SizedBox(height: 5.0),
//                     Text( group.groupState),
//                    const SizedBox(height: 5.0),
//                     Text(' ${group.members.length} Members'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RecommendedGroupCard extends StatelessWidget {
//   final GroupPage group;

//   RecommendedGroupCard({required this.group});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Padding(
//           padding:const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                Center(
//                  child: CircleAvatar(
//                   radius: 30,
//                                     backgroundImage:
//                                         NetworkImage( group.groupImageUrl,),
//                                   ),
//                ),
//               Center(
//                 child: Text(
//                   group.groupName,
//                   style:const TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Center(child: Text('${group.members.length} Members')),
//               Center(child: Text(group.groupState)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
