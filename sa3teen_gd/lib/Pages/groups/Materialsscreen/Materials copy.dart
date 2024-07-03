// //last working
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/groups/Materials/apiOfMaterials.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Materials',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MaterialsPage(),
//     );
//   }
// }

// class MaterialsPage extends StatefulWidget {
//   @override
//   _MaterialsPageState createState() => _MaterialsPageState();
// }

// class _MaterialsPageState extends State<MaterialsPage> {
//   late Future<List<Materials>> futureMaterials;
//   final int groupId = 6; // Example group ID
//   final String token =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with a valid token

//   @override
//   void initState() {
//     super.initState();
//     futureMaterials = ApiService().getMaterials(groupId, token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: FutureBuilder<List<Materials>>(
//         future: futureMaterials,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Failed to load materials'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No materials available'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final material = snapshot.data![index];
//                 return GestureDetector(
//                   onTap: () async {
//                     final url = material.mediaPath;
//                     if (await canLaunch(url)) {
//                       await launch(url);
//                     } else {
//                       throw 'Could not launch $url';
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Card(
//                       color: kprimaryColourWhite,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               material.title,
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Text('Uploaded by: '),
//                                 CircleAvatar(
//                                   radius: 7,
//                                   backgroundImage:
//                                       NetworkImage(material.user.image),
//                                 ),
//                                 Text(" ${material.user.username}"),
//                                 //  SizedBox(width: 10,),
//                                 Spacer(
//                                   flex: 1,
//                                 ),

//                                 Text(
//                                   '${material.uploadedTime}',
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Colors.grey.shade600),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//                 // ListTile(
//                 //   title: Text(material.title),
//                 //   subtitle: Text('Uploaded by: ${material.user.username}'),
//                 //   onTap: () async {
//                 //     final url = material.mediaPath;
//                 //     if (await canLaunch(url)) {
//                 //       await launch(url);
//                 //     } else {
//                 //       throw 'Could not launch $url';
//                 //     }
//                 //   },
//                 // );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class User {
//   final String username;
//   final String image;

//   User({required this.username, required this.image});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       username: json['username'],
//       image: json['image'],
//     );
//   }
// }

// class Materials {
//   final int id;
//   final User user;
//   final String title;
//   final String mediaPath;
//   final String uploadedTime;

//   Materials({
//     required this.id,
//     required this.user,
//     required this.title,
//     required this.mediaPath,
//     required this.uploadedTime,
//   });

//   factory Materials.fromJson(Map<String, dynamic> json) {
//     return Materials(
//       id: json['id'],
//       user: User.fromJson(json['user']),
//       title: json['title'],
//       mediaPath: json['media_path'],
//       uploadedTime: json['uploaded_Time'],
//     );
//   }
// }

// Future<List<Materials>> getMaterials(int id, String token) async {
//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/groups/$id/materials/'),
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     print(response.body);

//     return data.map((json) => Materials.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load materials');
//   }
// }


// // void main() async {
// //   int groupId = 6;
// //   String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU ';

// //   try {
// //     List<Materials> materials = await getMaterials(groupId, token);
// //     materials.forEach((material) {
// //       print('Title: ${material.title}');
// //       print('Uploaded by: ${material.user.username}');
// //       print('Media Path: ${material.mediaPath}');
// //       print('Uploaded Time: ${material.uploadedTime}');
// //       print('---');
// //     });
// //   } catch (e) {
// //     print(e);
// //   }
// // }


// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import 'package:http/http.dart' as http;

// // class Materials {
// //   final int id;
// //   final String title;
// //   final String username;
// //   final String? image;
// //   final String media_path;
// //   // final bool isOwner;
// //   // final bool isAdmin;
// //   final String uploaded_Time;

// //   Materials({
// //     required this.id,
// //     required this.title,
// //     required this.username,
// //     this.image,
// //     required this.media_path,
// //     // required this.isOwner,
// //     // required this.isAdmin,
// //     required this.uploaded_Time,

// //   });

// //   factory Materials.fromJson(Map<String, dynamic> json) {
// //     return Materials(
// //       id: json['id'],
// //       title: json['title'],
// //       username: json['user']['username'],
// //       image: json['user']['image'],
// //       media_path: json['media_path'],
// //       // isOwner/: json['is_owner'],
// //       // isAdmin: json['is_admin'],
// //       uploaded_Time: json['uploaded_Time'],
// //     );
// //   }
// // }

// // Future<List<Materials>> getMaterials(int id, String token) async {
// //   final response = await http.get(
// //     Uri.parse('http://10.0.2.2:8000/groups/${id}/materials/'),
// //     headers: {
// //       'Authorization': 'Bearer $token',
// //     },
// //   );

// //   if (response.statusCode == 200) {
// //     List<dynamic> data = json.decode(response.body);
// //     print(response.body);
    
// //     return data.map((json) => Materials.fromJson(json)).toList();
// //   } else {
// //     throw Exception('Failed to load users');
// //   }
// // }

// // class GetMaterials extends StatelessWidget {
// //   final String token;
// //   final int id;

// //   GetMaterials({required this.id, required this.token});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: tabbar(),
// //       body: FutureBuilder<List<Materials>>(
// //         future: getMaterials( id,token),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No users found.'));
// //           } else {
// //             List<Materials> materials = snapshot.data!;
// //             print(snapshot.data);
// //             return ListView.builder(
// //               itemCount: materials.length,
// //               itemBuilder: (context, index) {
// //                 return Card(
// //                   color: kprimaryColourWhite,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20.0),
// //                   ),
// //                   elevation: 5,
// //                   margin:
// //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(10.0),
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
                        


// //                         materials.image != null
// //                             ? CircleAvatar(
// //                                 backgroundImage:
// //                                     NetworkImage(materials[index].image!),
// //                               )
// //                             : CircleAvatar(
// //                                 backgroundColor: kprimaryColourcream,
// //                                 child: Text(materials[index].username[0]),
// //                               ),

// //                         const SizedBox(width: 10.0),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   // Text(materials.title),
// //                                   Text(
// //                                     materials[index].username,
// //                                     style: const TextStyle(
// //                                       fontSize: 18.0,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
                                  
// //                                   Spacer(flex: 1,),
// //                                   // Padding(
// //                                   //   padding: const EdgeInsets.all(8.0),
// //                                   //   child: Text(
// //                                   //                                   '  ${users[index].isAdmin ? 'Admin' : ''}${users[index].isOwner ? ' , Owner' : ''}',
// //                                   //                                 ),
// //                                   // ),
// //                                 ],
// //                               ),
// //                               // if (users[index].isAdmin){Text('');},

// //                             //  Text(users.) 
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }







// //  // return ListTile(
// //                         //   leading: users[index].image != null
// //                         //       ? Image.network(users[index].image!)
// //                         //       : null,
// //                         //   title: Text(users[index].username),
// //                         //   subtitle: Text(
// //                         //     'Owner: ${users[index].isOwner}, Admin: ${users[index].isAdmin}',
// //                         //   ),
// //                         // );