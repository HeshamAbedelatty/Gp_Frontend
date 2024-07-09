// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/BottomAppBar/BottomBar.dart';
// import 'package:gp_screen/Pages/profile/library/files.dart';

// class Library extends StatefulWidget {
//   @override
//   _LibraryState createState() => _LibraryState();
// }

// class _LibraryState extends State<Library> {
//   List<String> folders = [];

//   void _addFolder(String name) {
//     setState(() {
//       folders.add(name);
//     });
//   }

//   void _navigateToCreateFolderPage() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CreateFolderPage()),
//     );
//     if (result != null) {
//       _addFolder(result);
//     }
//   }

//   void _navigateToFolderDetailPage(String folderName) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => FolderDetailPage(folderName: folderName)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TabBarWidget(), // Use TabBarWidget as the appBar
//       body: ListView.builder(
//         itemCount: folders.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Icon(
//               Icons.folder,
//               color: Colors.yellow,
//               size: 50,
//             ),
//             title: Text(folders[index]),
//             onTap: () => _navigateToFolderDetailPage(folders[index]),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToCreateFolderPage,
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavBar(),
//     );
//   }
// }

// class CreateFolderPage extends StatefulWidget {
//   @override
//   _CreateFolderPageState createState() => _CreateFolderPageState();
// }

// class _CreateFolderPageState extends State<CreateFolderPage> {
//   final _folderNameController = TextEditingController();

//   void _createFolder() {
//     final folderName = _folderNameController.text;
//     if (folderName.isNotEmpty) {
//       Navigator.pop(context, folderName);
//     }
//   }

//   @override
//   void dispose() {
//     _folderNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Folder'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _folderNameController,
//               decoration: InputDecoration(
//                 labelText: 'Folder Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _createFolder,
//               child: Text('Create'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FolderDetailPage extends StatelessWidget {
//   final String folderName;

//   FolderDetailPage({required this.folderName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(folderName),
//       ),
//       body: FilePickerHomePage(),
//       bottomNavigationBar: BottomNavBar(),
//     );
//   }
// }

// class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize =>
//       Size.fromHeight(kToolbarHeight + 10); // Adjust height accordingly

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       iconTheme: IconThemeData(color: Colors.white),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Image.asset(
//                 'lib/assets/headphone.png', // Replace with your headphones icon image path
//                 height: 25, // Adjust the height as needed
//               ), // Headphones icon
//               SizedBox(
//                   width: 8), // Add space between headphones icon and avatar
//               CircleAvatar(
//                 radius: 15,
//                 backgroundImage: AssetImage(
//                   'lib/assets/profile.png', // Replace with your profile image path
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "Sa3teen Gd",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontFamily: 'lobster',
//                 ),
//               ),
//               SizedBox(width: 8),
//               Image.asset(
//                 'lib/assets/sa3teenGd.png', // Replace with your app logo image path
//                 height: 50, // Adjust the height as needed
//               ),
//             ],
//           ),
//         ],
//       ),
//       backgroundColor: Color.fromRGBO(56, 161, 67, 1),
//       shape: ContinuousRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         ),
//       ),
//     );
//   }
// }
