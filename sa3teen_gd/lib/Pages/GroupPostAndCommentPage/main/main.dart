import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
// import 'GroupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: GroupPage(
        id: 1,
        groupState: 'private',
        groupName: 'Group Name',
        groupImageUrl: 'https://example.com/group_image.jpg',
        members: const ['Member 1', 'Member 2', 'Member 3','Member 4',],
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sliver Widget Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text("Sliver App Bar"),
//               background: Image.network(
//                 "https://via.placeholder.com/350x150",
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int indexa) {
//                 return ListTile(
//                   title: Text("Item #$index"),
//                 );
//               },
//               childCount: 50, // Number of items in the list
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }