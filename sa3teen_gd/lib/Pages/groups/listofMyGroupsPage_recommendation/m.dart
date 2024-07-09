import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/bgddfinalListGroups_recommendation.dart';

class YourPage extends StatelessWidget {
  final String accessTokenFinal;

  YourPage({required this.accessTokenFinal});

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Show Recommended Groups'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => listallgroups(
                        url: 'recommend/',
                        pageName: 'Recommended Groups',
                        accessToken: accessTokenFinal,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Create New Group'),
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateGroupPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // Your other widget code goes here
    );
  }
}
