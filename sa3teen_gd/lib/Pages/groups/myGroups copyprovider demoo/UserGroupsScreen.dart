import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/myGroups/GroupListProvider.dart';
import 'package:provider/provider.dart';
// import 'group_provider.dart';

class UserGroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Joined Groups'),
      ),
      body: FutureBuilder(
        future: Provider.of<MyGroupProvider>(context, listen: false).fetchUserGroups('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<MyGroupProvider>(
              builder: (ctx, groupProvider, _) {
                return ListView.builder(
                  itemCount: groupProvider.userGroups.length,
                  itemBuilder: (ctx, index) {
                    final userGroup = groupProvider.userGroups[index];
                    return ListTile(
                      leading: Image.network(userGroup.group.image),
                      title: Text(userGroup.group.title),
                      subtitle: Text(userGroup.group.description),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
