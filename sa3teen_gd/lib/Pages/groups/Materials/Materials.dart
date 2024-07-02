//last working
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/Materials/apiOfMaterials.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class User {
  final String username;
  final String image;

  User({required this.username, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      image: json['image'],
    );
  }
}

class Materials {
  final int id;
  final User user;
  final String title;
  final String mediaPath;
  final String uploadedTime;

  Materials({
    required this.id,
    required this.user,
    required this.title,
    required this.mediaPath,
    required this.uploadedTime,
  });

  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
      id: json['id'],
      user: User.fromJson(json['user']),
      title: json['title'],
      mediaPath: json['media_path'],
      uploadedTime: json['uploaded_Time'],
    );
  }
}

Future<List<Materials>> getMaterials(int id, String token) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/groups/$id/materials/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    print(response.body);

    return data.map((json) => Materials.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load materials');
  }
}
class MaterialsPage extends StatefulWidget {
  final int id;

  const MaterialsPage({required this.id});

  @override
  _MaterialsPageState createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  late Future<List<Materials>> futureMaterials;
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with a valid token

  @override
  void initState() {
    super.initState();
    futureMaterials = ApiService().getMaterials(widget.id, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: FutureBuilder<List<Materials>>(
        future: futureMaterials,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load materials'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No materials available'));
          } else {
            return  Column(
              children: [
               const  Padding(
                   padding:  EdgeInsets.only( left:  10.0,top: 8),
                   child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Group Materials',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ],
                      ),
                 ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final material = snapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
                          final url = material.mediaPath;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:12.0,right: 12,top: 8),
                          child: Card(
                            color: kprimaryColourWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    material.title,
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Uploaded by: '),
                                      CircleAvatar(
                                        radius: 7,
                                        backgroundImage:
                                            NetworkImage(material.user.image),
                                      ),
                                      Text(material.user.username),
                                      //  SizedBox(width: 10,),
                                      const Spacer(
                                        flex: 1,
                                      ),
                  
                                      Text(
                                        material.uploadedTime,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
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
    );
  }
}


// class MaterialsPage extends StatefulWidget {
//   final int id;

//   const MaterialsPage({ required this.id});
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
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Failed to load materials'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No materials available'));
//           } else {
//             return Column(
//               children: [
//                const  Padding(
//                    padding:  EdgeInsets.only( left:  10.0,top: 8),
//                    child: Row(mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text('Group Materials',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                         ],
//                       ),
//                  ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final material = snapshot.data![index];
//                       return GestureDetector(
//                         onTap: () async {
//                           final url = material.mediaPath;
//                           if (await canLaunch(url)) {
//                             await launch(url);
//                           } else {
//                             throw 'Could not launch $url';
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(left:12.0,right: 12,top: 8),
//                           child: Card(
//                             color: kprimaryColourWhite,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     material.title,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Text('Uploaded by: '),
//                                       CircleAvatar(
//                                         radius: 7,
//                                         backgroundImage:
//                                             NetworkImage(material.user.image),
//                                       ),
//                                       Text(material.user.username),
//                                       //  SizedBox(width: 10,),
//                                       const Spacer(
//                                         flex: 1,
//                                       ),
                  
//                                       Text(
//                                         material.uploadedTime,
//                                         style: TextStyle(
//                                             fontSize: 10,
//                                             color: Colors.grey.shade600),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
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

