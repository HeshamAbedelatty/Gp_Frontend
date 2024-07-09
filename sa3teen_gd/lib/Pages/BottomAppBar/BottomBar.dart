import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/More_page/profile_screen.dart';
import 'package:gp_screen/Pages/profile/library/folder.dart';
import 'package:gp_screen/pages/chatBotIntegrated/Chat Bot copy 2.dart';

import '../../HomePage.dart';
import '../../Services/API_services.dart';
import '../groups/listofMyGroupsPage_recommendation/bgddfinalListGroups_recommendation.dart';
import '../toDoListPage/ThePage/ToDoListFinal.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(75, 0, 0, 0).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5), // Adjust the offset to lift the bar
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const HomePage(); // Return the ChatScreen widget here
                        },
                      ),
                    );
                    // Handle home icon press
                  },
                  icon: Image.asset(
                    "lib/assets/icons/home (3).png", // Replace with your home icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ChatScreen(); // Return the ChatScreen widget here
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/chatbot.png', // Replace with your chat icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the chat icon
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          // return GroupPage(
                          //   id: 1,
                          //   groupName: 'Example Group',
                          //   groupImageUrl: 'url_to_image',
                          //   members: ['Member 1', 'Member 2'],
                          //   groupState: 'Active',
                          // );
                          return listallgroups(
                              url: 'groups/list_groups/',
                              pageName: 'Groups',
                              accessToken: accesstokenfinal);
                          // GroupsScreen(
                          //   url: 'groups/list_groups/',pageName: 'Groups',
                          //   accessToken:
                          //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjU0MDA0LCJpYXQiOjE3MjAzNTgwMDQsImp0aSI6Ijg4ZTY5OTBlM2VhOTQ4NGU5ZGZjYzhhNTkzYjIyY2U1IiwidXNlcl9pZCI6NX0.WRNsW-YpHTPqUcYaUjicWi0IQ3GzAkL5ZrhPEXFnbWg',
                          // );
                          // Return the GroupPage widget here
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/pngwing.com2.png', // Replace with your group icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the group icon
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ToDoListScreen(); // Return the ChatScreen widget here
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/pngwing.com (6).png', // Replace with your notification icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the notification icon
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return  Library(); // Return the ChatScreen widget here
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/library.png', // Replace with your profile icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the profile icon
              ],
            ),
          ],
        ),
      ),
    );
  }
}
