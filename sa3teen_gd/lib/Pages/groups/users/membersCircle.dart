import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/users/usersInGroupsPage.dart';
import 'package:http/http.dart' as http;

// class GroupUsers {
//   final String username;
//   final String? image;
//   final bool isOwner;
//   final bool isAdmin;

//   GroupUsers({
//     required this.username,
//     this.image,
//     required this.isOwner,
//     required this.isAdmin,
//   });

//   factory GroupUsers.fromJson(Map<String, dynamic> json) {
//     return GroupUsers(
//       username: json['user']['username'],
//       image: json['user']['image'],
//       isOwner: json['is_owner'],
//       isAdmin: json['is_admin'],
//     );
//   }
// }

// Future<List<GroupUsers>> fetchGroupUsers(String token) async {
//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/groups/7/users/'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => GroupUsers.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load users');
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Group Users',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual token

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => GroupUsersOverviewPage(token: token),
//               ),
//             );
//           },
//           child: Text('Go to Group Users Overview'),
//         ),
//       ),
//     );
//   }
// }

class GroupUsersOverviewPage extends StatelessWidget {
  final String token;
  final int id;

  GroupUsersOverviewPage({required this.id,required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Group Users Overview'),
      // ),
      body: FutureBuilder<List<GroupUsers>>(
        future: fetchGroupUsers(id,token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Center(child: Text(''));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(''));
          } else {

            List<GroupUsers> users = snapshot.data!;


            if (users.length == 1) {
              return Center(
                child: Text('Only one user found.'),
              );
            }else{
 return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...users.take(4).map((user) {
                  return CircleAvatar(
                    backgroundImage: user.image != null
                        ? NetworkImage(user.image!)
                        : null,
                    child: user.image == null ? Text(user.username[0]) : null,
                  );
                }).toList(),
                if (users.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupUsersPage(id:id, token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                  
              ],
            );
            }
           
          }
        },
      ),
    );
  }
}

// class AllMembersPage extends StatelessWidget {
//   final List<GroupUsers> users;

//   AllMembersPage({required this.users});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Members'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: users[index].image != null
//                 ? CircleAvatar(
//                     backgroundImage: NetworkImage(users[index].image!),
//                   )
//                 : CircleAvatar(
//                     child: Text(users[index].username[0]),
//                   ),
//             title: Text(users[index].username),
//             subtitle: Text(
//               'Owner: ${users[index].isOwner}${users[index].isAdmin ? ', Admin' : ''}',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class GroupUsers {
//   final String username;
//   final String? image;
//   final bool isOwner;
//   final bool isAdmin;

//   GroupUsers({
//     required this.username,
//     this.image,
//     required this.isOwner,
//     required this.isAdmin,
//   });

//   factory GroupUsers.fromJson(Map<String, dynamic> json) {
//     return GroupUsers(
//       username: json['user']['username'],
//       image: json['user']['image'],
//       isOwner: json['is_owner'],
//       isAdmin: json['is_admin'],
//     );
//   }
// }

// Future<List<GroupUsers>> fetchGroupUsers(String token) async {
//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/groups/7/users/'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     return data.map((json) => GroupUsers.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load users');
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Group Users',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual token

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => GroupUsersPage(token: token),
//               ),
//             );
//           },
//           child: Text('Go to Group Users Page'),
//         ),
//       ),
//     );
//   }
// }

// class GroupUsersPage extends StatelessWidget {
//   final String token;

//   GroupUsersPage({required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Group Users'),
//       ),
//       body: FutureBuilder<List<GroupUsers>>(
//         future: fetchGroupUsers(token),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No users found.'));
//           } else {
//             List<GroupUsers> users = snapshot.data!;
//             return Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ...users.take(4).map((user) {
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: CircleAvatar(
//                           backgroundImage: user.image != null
//                               ? NetworkImage(user.image!)
//                               : null,
//                           child: user.image == null ? Text(user.username[0]) : null,
//                         ),
//                       );
//                     }).toList(),
//                     if (users.length > 4)
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AllMembersPage(users: users),
//                               ),
//                             );
//                           },
//                           child: CircleAvatar(
//                             child: Icon(Icons.add),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: users[index].image != null
//                             ? CircleAvatar(
//                                 backgroundImage: NetworkImage(users[index].image!),
//                               )
//                             : CircleAvatar(
//                                 child: Text(users[index].username[0]),
//                               ),
//                         title: Text(users[index].username),
//                         subtitle: Text(
//                           'Owner: ${users[index].isOwner}${users[index].isAdmin ? ', Admin' : ''}',
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class AllMembersPage extends StatelessWidget {
//   final List<GroupUsers> users;

//   AllMembersPage({required this.users});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Members'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: users[index].image != null
//                 ? CircleAvatar(
//                     backgroundImage: NetworkImage(users[index].image!),
//                   )
//                 : CircleAvatar(
//                     child: Text(users[index].username[0]),
//                   ),
//             title: Text(users[index].username),
//             subtitle: Text(
//               'Owner: ${users[index].isOwner}${users[index].isAdmin ? ', Admin' : ''}',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
