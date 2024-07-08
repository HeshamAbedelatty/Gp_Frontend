// import 'dart:convert';
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Services/API_services.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Define your access token here
// // const String accessToken =
//     // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => LibraryModel(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const Color kprimaryColourWhite = const Color.fromARGB(255, 248, 247, 242);
//     const Color kprimaryColourGreen = const Color(0xff1DAA61);
// // const Color kprimaryColourGreen = const Color(0xFF3C8243);
//     const Color kprimaryColourcream = Color.fromARGB(255, 207, 185, 157);
//     return MaterialApp(
//       title: 'File Manager',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           //  primarySwatch: Colors.green,
//           ),
//       home: Library(),
//     );
//   }
// }
//
// class Library extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kprimaryColourWhite,
//       appBar: AppBar(
//         title: Text('Library', style: TextStyle(color: Colors.white)),
//         backgroundColor: kprimaryColourGreen,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 16),
//           Expanded(
//             child: Consumer<LibraryModel>(
//               builder: (context, libraryModel, child) {
//                 if (libraryModel.folders.isEmpty) {
//                   libraryModel.fetchFolders();
//                   return Center(child: CircularProgressIndicator());
//                 } else {
//                   return GridView.builder(
//                     padding: EdgeInsets.all(8.0),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // Two folders per row
//                       childAspectRatio: 0.75, // Adjust as needed
//                       crossAxisSpacing: 8.0,
//                       mainAxisSpacing: 8.0,
//                     ),
//                     itemCount: libraryModel.folders.length,
//                     itemBuilder: (context, index) {
//                       final folder = libraryModel.folders[index];
//                       return GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FolderDetailPage(
//                               folder: folder,
//                             ),
//                           ),
//                         ),
//                         child: Card(
//                           color: kprimaryColourWhite,
//                           elevation: 4.0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.folder,
//                                   size: 50,
//                                   color: Colors.yellow,
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Expanded(
//                                   child: Text(
//                                     folder.name,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12.0,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.visible,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4.0),
//                                 Text(
//                                   'Created on: ${DateFormat.yMMMd().format(folder.creationDate)}\nAt ${DateFormat.Hm().format(folder.creationDate)}',
//                                   style: TextStyle(fontSize: 12.0),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 IconButton(
//                                   icon: Icon(Icons.delete),
//                                   onPressed: () =>
//                                       libraryModel.deleteFolder(index),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _navigateToCreateFolderDialog(context),
//         child: Icon(Icons.add),
//         backgroundColor: kprimaryColourGreen,
//       ),
//     );
//   }
//
//   void _navigateToCreateFolderDialog(BuildContext context) async {
//     final result = await showDialog<Folder>(
//       context: context,
//       builder: (context) => CreateFolderDialog(),
//     );
//     if (result != null) {
//       Provider.of<LibraryModel>(context, listen: false).addFolder(result);
//     }
//   }
// }
//
// class LibraryModel extends ChangeNotifier {
//   List<Folder> folders = [];
//
//   Future<void> fetchFolders() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://sa3teengd.azurewebsites.net/folders/'),
//         headers: {
//           'Authorization': 'Bearer $accesstokenfinal',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> folderList = json.decode(response.body);
//         List<Folder> fetchedFolders = folderList
//             .map((folderData) => Folder.fromJson(folderData))
//             .toList();
//         folders = fetchedFolders;
//         // Fetch files for each folder
//         for (var folder in folders) {
//           await fetchFilesForFolder(folder);
//         }
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to load folders. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching folders: $e');
//       throw Exception('Failed to load folders: $e');
//     }
//   }
//
//   Future<void> fetchFilesForFolder(Folder folder) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             'https://sa3teengd.azurewebsites.net/folders/${folder.id}/files/'),
//         headers: {
//           'Authorization': 'Bearer $accesstokenfinal',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> fileList = json.decode(response.body);
//         List<FileItem> fetchedFiles =
//             fileList.map((fileData) => FileItem.fromJson(fileData)).toList();
//         folder.files = fetchedFiles;
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to load files for folder ${folder.id}. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching files for folder ${folder.id}: $e');
//       throw Exception('Failed to load files for folder ${folder.id}: $e');
//     }
//   }
//
//   Future<void> addFolder(Folder folder) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://sa3teengd.azurewebsites.net/folders/'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $accesstokenfinal',
//         },
//         body: json.encode({
//           'name': folder.name,
//           'created_at': folder.creationDate.toIso8601String(),
//           'user': folder.userId,
//         }),
//       );
//
//       if (response.statusCode == 201) {
//         Folder addedFolder = Folder.fromJson(json.decode(response.body));
//         folders.add(addedFolder);
//         // Initialize files list for the added folder
//         addedFolder.files = [];
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to add folder. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error adding folder: $e');
//       throw Exception('Failed to add folder: $e');
//     }
//   }
//
//   Future<void> deleteFolder(int index) async {
//     final folderId = folders[index].id;
//
//     try {
//       final response = await http.delete(
//         Uri.parse('https://sa3teengd.azurewebsites.net/folders/$folderId/'),
//         headers: {
//           'Authorization': 'Bearer $accesstokenfinal',
//         },
//       );
//
//       if (response.statusCode == 204) {
//         folders.removeAt(index);
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to delete folder. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error deleting folder: $e');
//       throw Exception('Failed to delete folder: $e');
//     }
//   }
//
//   Future<void> pickAndUploadFile(int folderId) async {
//     try {
//       // Pick file using file picker
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//       if (result != null) {
//         File file = File(result.files.single.path!);
//         String fileName = result.files.single.name ??
//             'file'; // Use file name from picker result
//
//         // Prepare headers for the HTTP request
//         Map<String, String> headers = {
//           HttpHeaders.authorizationHeader: 'Bearer $accesstokenfinal',
//         };
//
//         // Construct multipart request body
//         var request = http.MultipartRequest(
//           'POST',
//           Uri.parse(
//               'https://sa3teengd.azurewebsites.net/folders/$folderId/files/'),
//         );
//
//         // Add file to request
//         request.headers.addAll(headers);
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'file', // Server-side form field name for file
//             file.path,
//             filename: fileName,
//           ),
//         );
//
//         // Send HTTP request
//         var streamedResponse = await request.send();
//         var response = await http.Response.fromStream(streamedResponse);
//
//         if (response.statusCode == 201) {
//           // Parse response JSON
//           Map<String, dynamic> jsonResponse = json.decode(response.body);
//
//           // Extract data and construct FileItem
//           FileItem fileItem = FileItem(
//             id: jsonResponse['id'],
//             mediaPath: jsonResponse['media_path'] ?? '', // Handle null case
//             fileType: jsonResponse['file_type'] ?? '', // Handle null case
//             folderId: jsonResponse['folder'],
//           );
//
//           // Update local data: find the folder and add the new file item
//           final folderIndex =
//               folders.indexWhere((folder) => folder.id == folderId);
//           if (folderIndex != -1) {
//             folders[folderIndex].files.add(fileItem);
//             // Notify listeners of the change
//             notifyListeners();
//           } else {
//             print('Folder not found for ID: $folderId');
//           }
//         } else {
//           // Handle error response
//           throw Exception(
//               'Failed to upload file. Status code: ${response.statusCode}');
//         }
//       } else {
//         // User canceled the file picker
//         print('User canceled file picking');
//       }
//     } catch (e) {
//       // Handle any exceptions thrown during the process
//       print('Error picking and uploading file: $e');
//       throw Exception('Failed to pick and upload file: $e');
//     }
//   }
// }
//
// class FolderDetailPage extends StatelessWidget {
//   final Folder folder;
//   final Color folderColor = kprimaryColourGreen;
//   int num = 0;
//
//   FolderDetailPage({required this.folder});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kprimaryColourWhite,
//       appBar: AppBar(
//         title: Text(
//           folder.name,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: folderColor,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: folder.files.length,
//                 itemBuilder: (context, index) {
//                   final file = folder.files[index];
//                   return Card(
//                     color: kprimaryColourWhite,
//                     margin: EdgeInsets.all(8.0),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.insert_drive_file,
//                         color:
//                             kprimaryColourcream, // Set file icon color to red
//                       ),
//                       title: Text(extractFileName(file.mediaPath)),
//                       trailing: IconButton(
//                         icon: Icon(Icons.open_in_new),
//                         onPressed: () => _openFile(file),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Provider.of<LibraryModel>(context, listen: false)
//             .pickAndUploadFile(folder.id),
//         child: Icon(Icons.add),
//         backgroundColor: folderColor,
//       ),
//     );
//   }
//
//   void _openFile(FileItem file) async {
//     try {
//       final url = 'https://sa3teengd.azurewebsites.net/${file.mediaPath}/';
//       await launch(url);
//     } catch (e) {
//       print('Error opening file: $e');
//     }
//   }
//
//   String extractFileName(String mediaPath) {
//     return mediaPath.split('/').last;
//   }
// }
//
// class CreateFolderDialog extends StatefulWidget {
//   @override
//   _CreateFolderDialogState createState() => _CreateFolderDialogState();
// }
//
// class _CreateFolderDialogState extends State<CreateFolderDialog> {
//   final _formKey = GlobalKey<FormState>();
//   String _folderName = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Create Folder'),
//       content: Form(
//         key: _formKey,
//         child: TextFormField(
//           decoration: InputDecoration(labelText: 'Folder Name'),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a folder name';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _folderName = value ?? '';
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             if (_formKey.currentState?.validate() ?? false) {
//               _formKey.currentState?.save();
//               Navigator.of(context).pop(Folder(
//                 id: -1,
//                 name: _folderName,
//                 creationDate: DateTime.now(),
//                 userId: 1, // Replace with actual user ID
//                 files: [], // Initialize files list for new folder
//               ));
//             }
//           },
//           child: Text('Create'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//       ],
//     );
//   }
// }
//
// class FileItem {
//   final int id;
//   final String mediaPath;
//   final String fileType;
//   final int folderId;
//
//   FileItem({
//     required this.id,
//     required this.mediaPath,
//     required this.fileType,
//     required this.folderId,
//   });
//
//   factory FileItem.fromJson(Map<String, dynamic> json) {
//     return FileItem(
//       id: json['id'],
//       mediaPath: json['media_path'],
//       fileType: json['file_type'],
//       folderId: json['folder'],
//     );
//   }
// }
//
// class Folder {
//   final int id;
//   final String name;
//   final DateTime creationDate;
//   final int userId;
//   List<FileItem> files; // List of files in the folder
//
//   Folder({
//     required this.id,
//     required this.name,
//     required this.creationDate,
//     required this.userId,
//     this.files = const [], // Initialize with an empty list
//   });
//
//   factory Folder.fromJson(Map<String, dynamic> json) {
//     return Folder(
//       id: json['id'],
//       name: json['name'],
//       creationDate: DateTime.parse(json['created_at']),
//       userId: json['user'],
//       files: [], // Initialize with an empty list
//     );
//   }
// }



import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Define your access token here
// const String accesstokenfinal =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LibraryModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color kprimaryColourWhite = const Color.fromARGB(255, 248, 247, 242);
    const Color kprimaryColourGreen = const Color(0xff1DAA61);
// const Color kprimaryColourGreen = const Color(0xFF3C8243);
    const Color kprimaryColourcream = Color.fromARGB(255, 207, 185, 157);
    return MaterialApp(
      title: 'File Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //  primarySwatch: Colors.green,
      ),
      home: Library(),
    );
  }
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
      appBar: AppBar(
        title: Text('Library', style: TextStyle(color: Colors.white)),
        backgroundColor: kprimaryColourGreen,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Expanded(
            child: Consumer<LibraryModel>(
              builder: (context, libraryModel, child) {
                if (libraryModel.folders.isEmpty) {
                  libraryModel.fetchFolders();
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two folders per row
                      childAspectRatio: 0.75, // Adjust as needed
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: libraryModel.folders.length,
                    itemBuilder: (context, index) {
                      final folder = libraryModel.folders[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FolderDetailPage(
                              folder: folder,
                            ),
                          ),
                        ),
                        child: Card(
                          color: kprimaryColourWhite,
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder,
                                  size: 50,
                                  color: Colors.yellow,
                                ),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Text(
                                    folder.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'Created on: ${DateFormat.yMMMd().format(folder.creationDate)}\nAt ${DateFormat.Hm().format(folder.creationDate)}',
                                  style: TextStyle(fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.0),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      libraryModel.deleteFolder(index),
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateFolderDialog(context),
        child: Icon(Icons.add),
        backgroundColor: kprimaryColourGreen,
      ),
    );
  }

  void _navigateToCreateFolderDialog(BuildContext context) async {
    final result = await showDialog<Folder>(
      context: context,
      builder: (context) => CreateFolderDialog(),
    );
    if (result != null) {
      Provider.of<LibraryModel>(context, listen: false).addFolder(result);
    }
  }
}

class LibraryModel extends ChangeNotifier {
  List<Folder> folders = [];

  Future<void> fetchFolders() async {
    try {
      final response = await http.get(
        Uri.parse('https://sa3teengd.azurewebsites.net/folders/'),
        headers: {
          'Authorization': 'Bearer $accesstokenfinal',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> folderList = json.decode(response.body);
        List<Folder> fetchedFolders = folderList
            .map((folderData) => Folder.fromJson(folderData))
            .toList();
        folders = fetchedFolders;
        // Fetch files for each folder
        for (var folder in folders) {
          await fetchFilesForFolder(folder);
        }
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load folders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching folders: $e');
      throw Exception('Failed to load folders: $e');
    }
  }

  Future<void> fetchFilesForFolder(Folder folder) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sa3teengd.azurewebsites.net/folders/${folder.id}/files/'),
        headers: {
          'Authorization': 'Bearer $accesstokenfinal',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> fileList = json.decode(response.body);
        List<FileItem> fetchedFiles =
        fileList.map((fileData) => FileItem.fromJson(fileData)).toList();
        folder.files = fetchedFiles;
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load files for folder ${folder.id}. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching files for folder ${folder.id}: $e');
      throw Exception('Failed to load files for folder ${folder.id}: $e');
    }
  }
  Future<void> addFolder(Folder folder) async {
    try {
      final response = await http.post(
        Uri.parse('https://sa3teengd.azurewebsites.net/folders/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accesstokenfinal',
        },
        body: json.encode({
          'name': folder.name,
          'created_at': folder.creationDate.toIso8601String(),
          'user': folder.userId,
        }),
      );

      if (response.statusCode == 201) {
        Folder addedFolder = Folder.fromJson(json.decode(response.body));
        folders.add(addedFolder);
        // Initialize files list for the added folder
        addedFolder.files = [];
        notifyListeners();
      } else {
        throw Exception(
            'Failed to add folder. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding folder: $e');
      throw Exception('Failed to add folder: $e');
    }
  }

  Future<void> deleteFolder(int index) async {
    final folderId = folders[index].id;

    try {
      final response = await http.delete(
        Uri.parse('https://sa3teengd.azurewebsites.net/folders/$folderId/'),
        headers: {
          'Authorization': 'Bearer $accesstokenfinal',
        },
      );

      if (response.statusCode == 204) {
        folders.removeAt(index);
        notifyListeners();
      } else {
        throw Exception(
            'Failed to delete folder. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting folder: $e');
      throw Exception('Failed to delete folder: $e');
    }
  }

  Future<void> pickAndUploadFile(int folderId) async {
    try {
      // Pick file using file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = result.files.single.name ??
            'file'; // Use file name from picker result

        // Prepare headers for the HTTP request
        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Bearer $accesstokenfinal',
        };

        // Construct multipart request body
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://sa3teengd.azurewebsites.net/folders/$folderId/files/'),
        );

        // Add file to request
        request.headers.addAll(headers);
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // Server-side form field name for file
            file.path,
            filename: fileName,
          ),
        );

        // Send HTTP request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 201) {
          // Parse response JSON
          Map<String, dynamic> jsonResponse = json.decode(response.body);

          // Extract data and construct FileItem
          FileItem fileItem = FileItem(
            id: jsonResponse['id'],
            mediaPath: jsonResponse['media_path'] ?? '', // Handle null case
            fileType: jsonResponse['file_type'] ?? '', // Handle null case
            folderId: jsonResponse['folder'],
          );

          // Update local data: find the folder and add the new file item
          final folderIndex =
          folders.indexWhere((folder) => folder.id == folderId);
          if (folderIndex != -1) {
            folders[folderIndex].files.add(fileItem);
            // Notify listeners of the change
            notifyListeners();
          } else {
            print('Folder not found for ID: $folderId');
          }
        } else {
          // Handle error response
          throw Exception(
              'Failed to upload file. Status code: ${response.statusCode}');
        }
      } else {
        // User canceled the file picker
        print('User canceled file picking');
      }
    } catch (e) {
      // Handle any exceptions thrown during the process
      print('Error picking and uploading file: $e');
      throw Exception('Failed to pick and upload file: $e');
    }
  }
}

class FolderDetailPage extends StatelessWidget {
  final Folder folder;
  final Color folderColor = kprimaryColourGreen;
  int num = 0;

  FolderDetailPage({required this.folder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
      appBar: AppBar(
        title: Text(
          folder.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: folderColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: folder.files.length,
                itemBuilder: (context, index) {
                  final file = folder.files[index];
                  return Card(
                    color: kprimaryColourWhite,
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.insert_drive_file,
                        color:
                        kprimaryColourcream, // Set file icon color to red
                      ),
                      title: Text(extractFileName(file.mediaPath)),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () => _openFile(file),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<LibraryModel>(context, listen: false)
            .pickAndUploadFile(folder.id),
        child: Icon(Icons.add),
        backgroundColor: folderColor,
      ),
    );
  }

  void _openFile(FileItem file) async {
    try {
      final url = 'https://sa3teengd.azurewebsites.net/${file.mediaPath}/';
      await launch(url);
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  String extractFileName(String mediaPath) {
    return mediaPath.split('/').last;
  }
}

class CreateFolderDialog extends StatefulWidget {
  @override
  _CreateFolderDialogState createState() => _CreateFolderDialogState();
}

class _CreateFolderDialogState extends State<CreateFolderDialog> {
  final _formKey = GlobalKey<FormState>();
  String _folderName = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Folder'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Folder Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a folder name';
            }
            return null;
          },
          onSaved: (value) {
            _folderName = value ?? '';
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              Navigator.of(context).pop(Folder(
                id: -1,
                name: _folderName,
                creationDate: DateTime.now(),
                userId: 1, // Replace with actual user ID
                files: [], // Initialize files list for new folder
              ));
            }
          },
          child: Text('Create'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
class FileItem {
  final int id;
  final String mediaPath;
  final String fileType;
  final int folderId;

  FileItem({
    required this.id,
    required this.mediaPath,
    required this.fileType,
    required this.folderId,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      id: json['id'],
      mediaPath: json['media_path'],
      fileType: json['file_type'],
      folderId: json['folder'],
    );
  }
}

class Folder {
  final int id;
  final String name;
  final DateTime creationDate;
  final int userId;
  List<FileItem> files; // List of files in the folder

  Folder({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.userId,
    this.files = const [], // Initialize with an empty list
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'],
      name: json['name'],
      creationDate: DateTime.parse(json['created_at']),
      userId: json['user'],
      files: [], // Initialize with an empty list
    );
  }
}