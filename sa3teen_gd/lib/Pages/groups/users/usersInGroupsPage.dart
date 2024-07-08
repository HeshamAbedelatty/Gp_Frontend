import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/Materials/Materials.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';

// import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;

class GroupUsers {
  final String username;
  final String? image;
  final bool isOwner;
  final bool isAdmin;

  GroupUsers({
    required this.username,
    this.image,
    required this.isOwner,
    required this.isAdmin,
  });

  factory GroupUsers.fromJson(Map<String, dynamic> json) {
    return GroupUsers(
      username: json['user']['username'],
      image: json['user']['image'],
      isOwner: json['is_owner'],
      isAdmin: json['is_admin'],
    );
  }
}

Future<List<GroupUsers>> fetchGroupUsers(int id, String token) async {
  final response = await http.get(
    Uri.parse('$finalurlforall/groups/${id}/users/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    
    return data.map((json) => GroupUsers.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
// Future<List<GroupUsers>> fetchGroupUsers(int id,String token) async {
//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/groups/${id}/users/'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     dynamic jsonData = json.decode(response.body);
//     if (jsonData is List) {
//       List<dynamic> data = jsonData;
//       return data.map((json) => GroupUsers.fromJson(json)).toList();
//     } else if (jsonData is Map && jsonData.containsKey('user')) {
//       // Handle single user response
//       return [GroupUsers.fromJson(jsonData as Map<String, dynamic>)];
//     } else {
//       throw Exception('Invalid response format');
//     }
//   } else {
//     throw Exception('Failed to load users');
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'; // Replace with your actual token
  final int id = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => 
                GroupUsersPage(id: id,token: token,)
                // GetMaterials(id:id, token: token),
              ),
            );
          },
          child: Text('Go to Group Users Page'),
        ),
      ),
    );
  }
}

class GroupUsersPage extends StatelessWidget {
  final String token;
  final int id;

  GroupUsersPage({required this.id, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder<List<GroupUsers>>(
        future: fetchGroupUsers(id, token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            List<GroupUsers> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  color: kprimaryColourWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        users[index].image != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(users[index].image!),
                              )
                            : CircleAvatar(
                                backgroundColor: kprimaryColourcream,
                                child: Text(users[index].username[0]),
                              ),

                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    users[index].username,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(flex: 1,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                                                    '  ${users[index].isAdmin ? 'Admin' : ''}${users[index].isOwner ? ' , Owner' : ''}',
                                                                  ),
                                  ),
                                ],
                              ),
                              // if (users[index].isAdmin){Text('');},

                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
