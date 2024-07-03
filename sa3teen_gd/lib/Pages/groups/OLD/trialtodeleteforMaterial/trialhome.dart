// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/MaterialsSearch/new/MaterialProvider.dart';
// import 'package:gp_screen/Pages/groups/MaterialsSearch/new/MaterialSearchScreen.dart';
// import 'package:provider/provider.dart';
// // import 'material_provider.dart';
// // import 'material_search_screen.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => MaterialProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go to Search'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MaterialSearchScreen()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
