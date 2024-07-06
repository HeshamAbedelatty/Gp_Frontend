import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/MaterialsSearch/finalMaterialSearchScreen.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/apiOfMaterials.dart';
// import 'package:gp_screen/Pages/groups/Materialsscreen/materials_provider.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialsScreen extends StatefulWidget {
  final int groupId;
  final String token;

  MaterialsScreen({required this.groupId, required this.token});

  @override
  _MaterialsScreenState createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MaterialsProvider>(context, listen: false)
          .fetchMaterials(widget.groupId, widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final materialsProvider = Provider.of<MaterialsProvider>(context);

    return Scaffold(
      appBar: tabbar(),
      body: materialsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : materialsProvider.materials.isEmpty
              ? const Center(child: Text('No materials found'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:  10.0, right: 10,top: 4),
                      child: Row(
                        children: [
                          const Text(
                            ' Materials',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                      const Spacer(flex: 1,),
                       IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {

               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => MaterialSearchScreen()),
                                  builder: (context) =>
                                      MaterialSearchScreen(groupId:widget.groupId ),
                                ));
              // Implement your search functionality here
            },
          ), ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: materialsProvider.materials.length,
                        itemBuilder: (context, index) {
                          final material = materialsProvider.materials[index];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        material.title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text('Uploaded by: '),
                                          CircleAvatar(
                                            radius: 7,
                                            backgroundImage: NetworkImage(
                                                material.user.image),
                                          ),
                                          Text(material.user.username),
                                          const Spacer(flex: 1),
                                          Text(
                                            material.uploadedTime,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
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
                ),
    );
  }
}
