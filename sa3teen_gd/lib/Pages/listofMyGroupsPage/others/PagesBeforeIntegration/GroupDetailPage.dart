import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'listofMyGroupsPage.dart';
//mogrd mnzr l7d ma yb2a fy groups bgd
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
