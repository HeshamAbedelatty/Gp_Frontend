

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/search/another.dart';
// import 'package:gp_screen/Pages/groups/search/searchgroup_provider.dart';
// import 'package:provider/app_state.dart';


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => GroupProvider(),
//       child: MaterialApp(
//         home: HomeScreen(),
//       ),
//     );
//   }
// }








// // workingggggggggggggggggg
// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/groups/search/searchgroup_provider.dart';
// // import 'package:provider/app_state.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (_) => GroupProvider(),
// //       child: MaterialApp(
// //         home: SearchScreen(),
// //       ),
// //     );
// //   }
// // }

// // class SearchScreen extends StatelessWidget {
// //   final TextEditingController _searchController = TextEditingController();
// //   final String _accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

// //   @override
// //   Widget build(BuildContext context) {
// //     final groupProvider = Provider.of<GroupProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Search Groups'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 labelText: 'Search',
// //               ),
// //               onChanged: (value) {
// //                 groupProvider.searchGroupsByTitle(value, _accessToken);
// //               },
// //             ),
// //             SizedBox(height: 20),
// //             groupProvider.isLoading
// //                 ? CircularProgressIndicator()
// //                 : Expanded(
// //                     child: ListView.builder(
// //                       itemCount: groupProvider.groups.length,
// //                       itemBuilder: (context, index) {
// //                         final group = groupProvider.groups[index];
// //                         return ListTile(
// //                           title: Text(group.title),
// //                           subtitle: Text(group.description),
// //                           leading: Image.network(group.image!),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:gp_screen/Pages/groups/search/searchgroup_provider.dart';
// // // import 'package:provider/app_state.dart';


// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ChangeNotifierProvider(
// // //       create: (_) => GroupProvider(),
// // //       child: MaterialApp(
// // //         home: SearchScreen(),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class SearchScreen extends StatelessWidget {
// // //   final TextEditingController _searchController = TextEditingController();
// // //   final String _accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final groupProvider = Provider.of<GroupProvider>(context);

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Search Groups'),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: _searchController,
// // //               decoration: InputDecoration(
// // //                 labelText: 'Search',
// // //                 suffixIcon: IconButton(
// // //                   icon: Icon(Icons.search),
// // //                   onPressed: () {
// // //                     groupProvider.searchGroupsByTitle(_searchController.text, _accessToken);
// // //                   },
// // //                 ),
// // //               ),
// // //             ),
// // //             SizedBox(height: 20),
// // //             groupProvider.isLoading
// // //                 ? CircularProgressIndicator()
// // //                 : Expanded(
// // //                     child: ListView.builder(
// // //                       itemCount: groupProvider.groups.length,
// // //                       itemBuilder: (context, index) {
// // //                         final group = groupProvider.groups[index];
// // //                         return ListTile(
// // //                           title: Text(group.title),
// // //                           subtitle: Text(group.description),
// // //                           leading: Image.network(group.image!),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:gp_screen/Pages/groups/search/searchgroup_provider.dart';
// // // // import 'package:provider/app_state.dart';

// // // // void main() {
// // // //   runApp(MyApp());
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return ChangeNotifierProvider(
// // // //       create: (_) => GroupProvider(),
// // // //       child: MaterialApp(
// // // //         home: SearchScreen(),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class SearchScreen extends StatelessWidget {
// // // //   final TextEditingController _searchController = TextEditingController();
// // // //   final String _accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU'; // Replace with your actual access token

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final groupProvider = Provider.of<GroupProvider>(context);

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Search Groups'),
// // // //       ),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           children: [
// // // //             TextField(
// // // //               controller: _searchController,
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'Search',
// // // //                 suffixIcon: IconButton(
// // // //                   icon: Icon(Icons.search),
// // // //                   onPressed: () {
// // // //                     groupProvider.searchGroups(_searchController.text, _accessToken);
// // // //                 print('search icon') ; },
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             SizedBox(height: 20),
// // // //             groupProvider.isLoading
// // // //                 ? CircularProgressIndicator()
// // // //                 : Expanded(
// // // //                     child: ListView.builder(
// // // //                       itemCount: groupProvider.groups.length,
// // // //                       itemBuilder: (context, index) {
// // // //                         final group = groupProvider.groups[index];
// // // //                         return ListTile(
// // // //                           title: Text(group.title),
// // // //                           subtitle: Text(group.description),
// // // //                           leading: Image.network(group.image),
// // // //                         );
// // // //                       },
// // // //                     ),
// // // //                   ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:gp_screen/Pages/groups/search/searchgroup_provider.dart';
// // // // // import 'package:provider/app_state.dart';

// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }

// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return ChangeNotifierProvider(
// // // // //       create: (_) => GroupProvider(),
// // // // //       child: MaterialApp(
// // // // //         home: SearchScreen(),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class SearchScreen extends StatelessWidget {
// // // // //   final TextEditingController _searchController = TextEditingController();

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final groupProvider = Provider.of<GroupProvider>(context);

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Search Groups'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             TextField(
// // // // //               controller: _searchController,
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Search',
// // // // //                 suffixIcon: IconButton(
// // // // //                   icon: Icon(Icons.search),
// // // // //                   onPressed: () {
// // // // //                     groupProvider.searchGroups(_searchController.text);
// // // // //                   },
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             groupProvider.isLoading
// // // // //                 ? CircularProgressIndicator()
// // // // //                 : Expanded(
// // // // //                     child: ListView.builder(
// // // // //                       itemCount: groupProvider.groups.length,
// // // // //                       itemBuilder: (context, index) {
// // // // //                         final group = groupProvider.groups[index];
// // // // //                         return ListTile(
// // // // //                           title: Text(group.title),
// // // // //                           subtitle: Text(group.description),
// // // // //                           leading: Image.network(group.image),
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
