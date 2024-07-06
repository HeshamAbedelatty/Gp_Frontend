import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:gp_screen/Pages/groups/Materialsscreen/search/finalMaterialSearchScreen.dart';
import 'package:gp_screen/Pages/apis/apiOfMaterials.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
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
  final _titleController = TextEditingController();
  File? _pickedFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MaterialsProvider>(context, listen: false)
          .fetchMaterials(widget.groupId, widget.token);
    });
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    }
  }

  // Future<void> _uploadMaterial() async {
  //   if (_titleController.text.isNotEmpty && _pickedFile != null) {
  //     await Provider.of<MaterialsProvider>(context, listen: false).uploadMat(
  //       _titleController.text,
  //       _pickedFile,
  //       widget.groupId,
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw',
  //     );
  //     _titleController.clear();
  //     Provider.of<MaterialsProvider>(context, listen: false).fetchMaterials(
  //         widget.groupId,
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'

  //         // widget.token
  //         );
  //     _titleController.clear();
  //     setState(() {
  //       _pickedFile = null;
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please enter a title and pick a file')),
  //     );
  //   }
  // }

  Future<void> _uploadMaterial() async {
    if (_titleController.text.isNotEmpty && _pickedFile != null) {
      await Provider.of<MaterialsProvider>(context, listen: false).uploadMat(
        _titleController.text,
        _pickedFile,
        widget.groupId,
        widget.token,
      );
      Provider.of<MaterialsProvider>(context, listen: false).fetchMaterials(
          widget.groupId,
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw');
      _titleController.clear();
      setState(() {
        _pickedFile = null;
      });
      Navigator.pop(context); // Close the dialog after upload
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and pick a file')),
      );
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
              ),
              // ElevatedButton(
              //   onPressed: _pickFile,
              //   child: Text('Pick File'),
              // ),
              _pickedFile != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            'Selected File: ${_pickedFile!.path.split('/').last}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 200,
                            child: PDFView(
                              filePath: _pickedFile!.path,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: false,
                              pageFling: false,
                              onRender: (pages) {
                                setState(() {});
                              },
                              onError: (error) {
                                print(error.toString());
                              },
                              onPageError: (page, error) {
                                print('$page: ${error.toString()}');
                              },
                              onViewCreated:
                                  (PDFViewController pdfViewController) {},
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
             
               Row(
                children: [
                  ElevatedButton(style: ElevatedButton.styleFrom(
                                          backgroundColor: kprimaryColourcream,
                                        ),
                    onPressed: _pickFile,
                    child: const Text('Pick File',style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton(style: ElevatedButton.styleFrom(
                                          backgroundColor: kprimaryColourcream,
                                        ),
                    onPressed: _uploadMaterial,
                    child: const Text('Upload Material',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _sshowUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
              ),
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text('Pick File'),
              ),
              ElevatedButton(
                onPressed: _uploadMaterial,
                child: const Text('Upload Material'),
              ),
            ],
          ),
        );
      },
    );
  }

  // void _showUploadDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Upload Material'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: TextField(
  //                 controller: _titleController,
  //                 decoration: InputDecoration(labelText: 'Title'),
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: _pickFile,
  //               child: Text('Pick File'),
  //             ),
  //             _pickedFile != null
  //                 ? Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //                     child: Row(
  //                       children: [
  //                         Text(
  //                           'Selected File: ${_pickedFile!.path.split('/').last}',
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 : Container(),

  //             ElevatedButton(
  //               onPressed: _uploadMaterial,
  //               child: Text('Upload Material'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final materialsProvider = Provider.of<MaterialsProvider>(context);

    return Scaffold(
      appBar: tabbar(),
     
      body: Column(
        children: [
        
          Expanded(
            child: materialsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : materialsProvider.materials.isEmpty
                    ? const Center(child: Text('No materials found'))
                    : Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                '  Materials',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 35,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MaterialSearchScreen(
                                                groupId: widget.groupId),
                                      ));
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: materialsProvider.materials.length,
                              itemBuilder: (context, index) {
                                final material =
                                    materialsProvider.materials[index];

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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  material.title,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const Spacer(flex: 1,),
                                                 IconButton(
                                            icon: const Icon(Icons.delete, color: kprimaryColourcream),
                                            onPressed: () async {
                                              await Provider.of<MaterialsProvider>(context, listen: false)
                                                  .deleteMaterial(context,widget.groupId, material.id, widget.token);
                                            },
                                          ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                const Text('Uploaded by: '),
                                                // CircleAvatar(
                                                //   radius: 7,
                                                //   backgroundImage: NetworkImage(material.user.image!),
                                                // ),
                                                material.user.image != null
                                                    ? CircleAvatar(
                                                        radius: 7,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                material.user
                                                                    .image!),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 7,
                                                        backgroundColor:
                                                            kprimaryColourcream,
                                                        child: Text(material
                                                            .user.username[0]),
                                                      ),
                                                Text(
                                                    ' ${material.user.username}'),
                                                const Spacer(flex: 1),
                                                Text(
                                                  material.uploadedTime,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          Colors.grey.shade600),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUploadDialog();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
