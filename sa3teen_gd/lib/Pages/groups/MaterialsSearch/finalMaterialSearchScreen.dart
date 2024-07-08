import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
// import 'material_provider.dart';
// import 'material_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/MaterialsSearch/ProviderMaterial.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialSearchScreen extends StatefulWidget {
  final int groupId;

  MaterialSearchScreen({required this.groupId});

  @override
  _MaterialSearchScreenState createState() => _MaterialSearchScreenState();
}

class _MaterialSearchScreenState extends State<MaterialSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                labelText: 'Search',
              ),
              onChanged: (value) {
                Provider.of<MaterialProvider>(context, listen: false)
                    .fetchMaterials(widget.groupId, value, token);
              },
            ),
          ),
          Expanded(
            child: Consumer<MaterialProvider>(
              builder: (context, provider, child) {
                if (provider.errorMessage != null) {
                  return Center(child: Text('Error: ${provider.errorMessage}'));
                } else if (provider.materials.isEmpty) {
                  return Center(child: Text('No materials found'));
                } else {
                  return ListView.builder(
                    itemCount: provider.materials.length,
                    itemBuilder: (context, index) {
                      final material = provider.materials[index];
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
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 8),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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

                                      // Text(
                                      //   material.uploadedTime as String,
                                      //   style: TextStyle(
                                      //       fontSize: 10,
                                      //       color: Colors.grey.shade600),
                                      // ),
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
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


// class MaterialSearchScreen extends StatefulWidget {
//   @override
//   _MaterialSearchScreenState createState() => _MaterialSearchScreenState();
// }

// class _MaterialSearchScreenState extends State<MaterialSearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   int _groupId =6; // Replace with actual groupId as needed
// String token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Materials'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//               ),
//               onChanged: (value) {
//                 Provider.of<MaterialProvider>(context, listen: false)
//                     .fetchMaterials(_groupId, value,token);
//               },
//             ),
//           ),
         
//           Expanded(
//             child: Consumer<MaterialProvider>(
//               builder: (context, provider, child) {
//                 if (provider.errorMessage != null) {
//                   return Center(child: Text('Error: ${provider.errorMessage}'));
//                 } else if (provider.materials.isEmpty) {
//                   return Center(child: Text('No materials found'));
//                 } else {
//                   return ListView.builder(
//                     itemCount: provider.materials.length,
//                     itemBuilder: (context, index) {
//                       final material = provider.materials[index];
//                       return ListTile(
//                         title: Text(material.title),
//                         subtitle: Text('Uploaded by ${material.user.username}'),
//                         trailing: Image.network(material.user.image),
//                         onTap: () {
//                           // Handle tap, e.g., open material
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/groups/MaterialsSearch/new/MaterialProvider.dart';
// // import 'package:provider/app_state.dart';


// // class MaterialSearchScreen extends StatefulWidget {
// //   @override
// //   _MaterialSearchScreenState createState() => _MaterialSearchScreenState();
// // }

// // class _MaterialSearchScreenState extends State<MaterialSearchScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //   int _groupId = 6; // Replace with actual groupId as needed
// // String token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Search Materials'),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 labelText: 'Search',
// //                 suffixIcon: IconButton(
// //                   icon: Icon(Icons.search),
// //                   onPressed: () {
// //                     final title = _searchController.text;
// //                     Provider.of<MaterialProvider>(context, listen: false)
// //                         .fetchMaterials(_groupId, title, token);
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: Consumer<MaterialProvider>(
// //               builder: (context, provider, child) {
// //                 if (provider.materials.isEmpty) {
// //                   return Center(child: Text('No materials found'));
// //                 } else {
// //                   return ListView.builder(
// //                     itemCount: provider.materials.length,
// //                     itemBuilder: (context, index) {
// //                       final material = provider.materials[index];
// //                       return ListTile(
// //                         title: Text(material.title),
// //                         subtitle: Text('Uploaded by ${material.user.username}'),
// //                         trailing: Image.network(material.user.image),
// //                         onTap: () {
// //                           // Handle tap, e.g., open material
// //                         },
// //                       );
// //                     },
// //                   );
// //                 }
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
