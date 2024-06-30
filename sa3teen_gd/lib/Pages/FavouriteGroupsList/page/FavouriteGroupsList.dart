// // ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/FavouriteGroupsList/provider/FavoriteGroupsProvider.dart';
// import 'package:provider/provider.dart';
// import '../../GroupPostAndCommentPage/Widgets/tabBar.dart';
// import '../../listofMyGroupsPage/Pages/listofMyGroupsPage.dart';

// class FavoriteGroupsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var favoriteGroupsProvider = Provider.of<FavoriteGroupsProvider>(context);
//     var favoriteGroups = favoriteGroupsProvider.favoriteGroups;

//     return Scaffold(
//       appBar: tabbar(),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(left: 19.0, top: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Your Favorite Groups',
//                   style: TextStyle(
//                     fontSize: 22,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: favoriteGroups.length,
//               itemBuilder: (context, index) {
//                 return GroupCard(
//                   group: favoriteGroups[index],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
