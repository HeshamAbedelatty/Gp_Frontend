// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/FavouriteGroupsList/provider/FavoriteGroupsProvider.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/others/old/2ndOld/Pages/GroupDetailPage.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class RecommendedGroupCard extends StatelessWidget {
  final GroupPage group;

  const RecommendedGroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    var favoriteGroupsProvider = Provider.of<FavoriteGroupsProvider>(context);
    // ignore: unused_local_variable
    bool isFavorite = favoriteGroupsProvider.isFavorite(group);

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => GroupDetailPage(group: group),
        //   ),
        // );
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
                // IconButton(
                //   onPressed: () {
                //     favoriteGroupsProvider.toggleFavorite(group);
                //   },
                //   icon: Icon(
                //     isFavorite ? Icons.favorite : Icons.favorite_border,
                //     color: isFavorite ? Colors.red : Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
