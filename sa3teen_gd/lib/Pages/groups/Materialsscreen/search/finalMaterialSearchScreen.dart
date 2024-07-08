// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';

import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import 'package:gp_screen/Pages/APIsSalma/ProviderMaterial.dart';
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
                  return const Center(child: Text('No materials found'));
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
