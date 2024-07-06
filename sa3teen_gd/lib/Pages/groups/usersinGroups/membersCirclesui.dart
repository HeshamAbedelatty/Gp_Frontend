// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/usersinGroups/usersInGroupsPage.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

class GroupUsersOverviewPage extends StatelessWidget {
  final String token;
  final int id;

  const GroupUsersOverviewPage({required this.id, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GroupUsers>>(
        future: fetchGroupUsers(id, token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            // } else if (snapshot.hasError) {
            //   return Center(child: Text(''));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text(''));
          } else {
            List<GroupUsers> users = snapshot.data!;

            // if (users.length == 1) {
            //   return const Center(
            //     child: Text('Only one user found.'),
            //   );
            // } else {
//               return Stack(
//   children: [
//     ...List.generate(users.take(4).length, (index) {
//       var user = users[index];
//       return Positioned(
//         left: index * 20.0, // Adjust the spacing as needed
//         child: CircleAvatar(
//           backgroundColor: kprimaryColourcream,
//           backgroundImage: user.image != null ? NetworkImage(user.image!) : null,
//           child: user.image == null ? Text(user.username[0]) : null,
//         ),
//       );
//     }),
//     if (users.length > 1)
//       Positioned(
//         left: users.take(4).length * 20.0, // Adjust the position as needed
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => GroupUsersPage(
//                   id: id,
//                   token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU',
//                 ),
//               ),
//             );
//           },
//           child: const CircleAvatar(
//             backgroundColor: kprimaryColourcream,
//             child: Icon(Icons.more_horiz, size: 28,),
//           ),
//         ),
//       ),
//   ],
// );   
              
            return  Stack(
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...users.take(4).map((user) {
                      return Positioned(left: 100 * 20.0,
                        child: CircleAvatar(
                          backgroundColor: kprimaryColourcream,
                          backgroundImage:
                              user.image != null ? NetworkImage(user.image!) : null,
                          child: user.image == null ? Text(user.username[0]) : null,
                        ),
                      );
                    }).toList(),
                    if (users.length > 1)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupUsersPage(
                                  id: id,
                                  token:
                                      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: kprimaryColourcream,
                          child: Icon(Icons.more_horiz,size: 28,),
                        ),
                      ),
                  ],
                ),]
              );
            }
          }
        // },
      ),
    );
  }
}
