import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/creategroup/creategrouppage.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/FinalGroupPostsPageCopyyy.dart';
import 'package:gp_screen/Pages/groups/finalgroupinside.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/groups/groupinside.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/listGroupsModel.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/old/2ndOld/Pages/GroupDetailPage.dart';
import 'package:gp_screen/Pages/listofMyGroupsPage/getAPI.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

class GroupsScreen extends StatefulWidget {
  final String accessToken;

  GroupsScreen({required this.accessToken});

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late Future<List<listGroupsModel>> futureGroups;

  @override
  void initState() {
    super.initState();
    futureGroups = getAllGroups().getAllProducts(widget.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: tabbar(),
      body: FutureBuilder<List<listGroupsModel>>(
        future: futureGroups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No groups found.'));
          } else {
            List<listGroupsModel> groups = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    children: [
                      const Text(
                        'Groups',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      // Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Align(
                      //       alignment: Alignment.centerRight,
                      //       child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.green,
                      //         ),
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => CreateGroupPage()),
                      //           );
                      //         },
                      //         child: const Text(
                      //           'Create Group',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      listGroupsModel group = groups[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: group.image != null
                                      ? NetworkImage(group.image!)
                                      : null,
                                  backgroundColor: group.image == null
                                      ? kprimaryColourcream
                                      : Colors.transparent,
                                  child: group.image == null
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
                                        group.title,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(group.subject),
                                      const SizedBox(height: 5.0),
                                      Text('${group.members} Members'),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      // Example of how to navigate to the GroupDetailPage
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => GroupDetailPage(groupId: group.id, accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
  ),
);

                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kprimaryColourcream),
                                    child: const Text(
                                      'join',
                                      style: TextStyle(color: Colors.white),
                                    ))
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
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: (){  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateGroupPage()),
                                );},
        backgroundColor: Colors.green,
        child:const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GroupsScreen(
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'),
  ));
}






// The model class
// class listGroupsModel {
//   final dynamic id;
//   final String title;
//   final String description;
//   final String type;
//   final String? image;
//   final String? password;
//   final String subject;
//   final int members;

//   listGroupsModel(
//       {required this.id,
//       required this.title,
//       required this.subject,
//       required this.description,
//       required this.image,
//       required this.type,
//       required this.password,
//       required this.members});

//   factory listGroupsModel.fromJson(jsonData) {
//     return listGroupsModel(
//       id: jsonData['id'],
//       title: jsonData['title'],
//       subject: jsonData['subject'],
//       type: jsonData['type'],
//       description: jsonData['description'],
//       image: jsonData['image'],
//       password: jsonData['password'],
//       members: jsonData['members'],
//     );
//   }

//   @override
//   String toString() {
//     return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members'";
//   }
// }

// // The class responsible for retrieving the data
// class getAllGroups {
//   Future<List<listGroupsModel>> getAllProducts(String accessToken) async {
//     Map<String, String> headers = {
//       'Authorization': 'Bearer $accessToken',
//     };

//     List<dynamic> data = await Api().get(
//       url: 'http://10.0.2.2:8000/groups/',
//       headers: headers,
//     );

//     List<listGroupsModel> productsList = [];
//     for (int i = 0; i < data.length; i++) {
//       productsList.add(
//         listGroupsModel.fromJson(data[i]),
//       );
//     }

//     // Print each object using the overridden toString method
//     for (var product in productsList) {
//       print(product);
//     }

//     return productsList;
//   }
// }


// SizedBox(height: 5),  Text(
                                      //       group.description,
                                      //       style: TextStyle(
                                      //         fontSize: 14,
                                      //       ),
                                      //     ),

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/listofMyGroupsPage/Pages/h.dart';

// // The model class
// class listGroupsModel {
//   final dynamic id;
//   final String title;
//   final String description;
//   final String type;
//   final String? image;
//   final String? password;
//   final String subject;
//   final int members;

//   listGroupsModel(
//       {required this.id,
//       required this.title,
//       required this.subject,
//       required this.description,
//       required this.image,
//       required this.type,
//       required this.password,
//       required this.members});

//   factory listGroupsModel.fromJson(jsonData) {
//     return listGroupsModel(
//       id: jsonData['id'],
//       title: jsonData['title'],
//       subject: jsonData['subject'],
//       type: jsonData['type'],
//       description: jsonData['description'],
//       image: jsonData['image'],
//       password: jsonData['password'],
//       members: jsonData['members'],
//     );
//   }

//   @override
//   String toString() {
//     return "id='$id', title='$title', subject='$subject', description='$description', image='$image', type='$type', password='$password', members='$members'";
//   }
// }

// // The class responsible for retrieving the data
// class getAllGroups {
//   Future<List<listGroupsModel>> getAllProducts(String accessToken) async {
//     Map<String, String> headers = {
//       'Authorization': 'Bearer $accessToken',
//     };

//     List<dynamic> data = await Api().get(
//       url: 'http://10.0.2.2:8000/groups/',
//       headers: headers,
//     );

//     List<listGroupsModel> productsList = [];
//     for (int i = 0; i < data.length; i++) {
//       productsList.add(
//         listGroupsModel.fromJson(data[i]),
//       );
//     }

//     // Print each object using the overridden toString method
//     for (var product in productsList) {
//       print(product);
//     }

//     return productsList;
//   }
// }

// // The widget to display the list of groups
// class GroupsScreen extends StatefulWidget {
//   final String accessToken;

//   GroupsScreen({required this.accessToken});

//   @override
//   _GroupsScreenState createState() => _GroupsScreenState();
// }

// class _GroupsScreenState extends State<GroupsScreen> {
//   late Future<List<listGroupsModel>> futureGroups;

//   @override
//   void initState() {
//     super.initState();
//     futureGroups = getAllGroups().getAllProducts(widget.accessToken);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Groups'),
//       ),
//       body: FutureBuilder<List<listGroupsModel>>(
//         future: futureGroups,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No groups found.'));
//           } else {
//             List<listGroupsModel> groups = snapshot.data!;
//             return ListView.builder(
//               itemCount: groups.length,
//               itemBuilder: (context, index) {
//                 listGroupsModel group = groups[index];
//                 return ListTile(
//                   title: Text(group.title),
//                   subtitle: Text(group.description),
//                   trailing: Text('Members: ${group.members}'),
//                   onTap: () {
//                     // Handle item tap if needed
//                   },
//                 );
//               },
//             );
//                 // return GroupCard(
//                 //   group: groups[index],
//                 // );
//               // },
//           }
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: GroupsScreen(accessToken: 'your_access_token_here'),
//   ));
// }
