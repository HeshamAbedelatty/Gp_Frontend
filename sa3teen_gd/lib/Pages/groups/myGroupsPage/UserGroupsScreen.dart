// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'package:gp_screen/Pages/groups/GroupsfinalPage_edit/Finalgroupinside.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class UserGroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder(
        future: Provider.of<MyGroupProvider>(context, listen: false)
            .fetchUserGroups(
          // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
        ),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred!'));
          } else {
            return Consumer<MyGroupProvider>(
              builder: (ctx, groupProvider, _) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            ' My Groups',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: groupProvider.userGroups.length,
                        itemBuilder: (ctx, index) {
                          final userGroup = groupProvider.userGroups[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupDetailPage(
                                      groupId: userGroup.group.id,
                                      accessToken:
                                          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                                ),
                              );
                            },
                            child: Card(
                              color: kprimaryColourWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: userGroup.group.image !=
                                              null
                                          ? NetworkImage(userGroup.group.image!)
                                          : null,
                                      backgroundColor:
                                          userGroup.group.image == null
                                              ? kprimaryColourcream
                                              : Colors.transparent,
                                      child: userGroup.group.image == null
                                          ? const Icon(Icons.group,
                                              size: 30, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userGroup.group.title,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(userGroup.group.subject),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              Text(userGroup.group.type),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                ' ${userGroup.group.members} Members',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
