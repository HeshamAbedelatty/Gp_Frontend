import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/FavouriteGroupsList/provider/FavoriteGroupsProvider.dart';
import 'package:gp_screen/Pages/FavouriteGroupsList/page/FavouriteGroupsList.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/Pages/GroupDetailPage.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/RecommendeCard/RecommendedGroupCard.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import '../../GroupPostAndCommentPage/Widgets/tabBar.dart';

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
  final List<GroupPage> recommendedGroupsList = recommendedGroups;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My groups',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteGroupsPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Go to your favorite groups',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GroupCard(
                  group: groups[index],
                );
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
              itemCount: recommendedGroupsList.length,
              itemBuilder: (context, index) {
                return RecommendedGroupCard(
                  group: recommendedGroupsList[index],
                );
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
    var favoriteGroupsProvider = Provider.of<FavoriteGroupsProvider>(context);
    bool isFavorite = favoriteGroupsProvider.isFavorite(group);

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
                IconButton(
                  onPressed: () {
                    favoriteGroupsProvider.toggleFavorite(group);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
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
