//not needed anymore old version

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: TopPhotoSection(),
//       ),
//     );
//   }
// }

// class TopPhotoSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         // Background Image
//         Container(
//           height: 250,
//           decoration: BoxDecoration(
//             color:kprimaryColourBrown,
//             // image: DecorationImage(
//             //   image: AssetImage('lib/assets/icons/2.jpg'), // Path to your image
//             //   fit: BoxFit.cover,
//             // ),
//           ),
//         ),
//         // Overlaying Widgets
//         Positioned(
//           top: 40,
//           left: 20,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'WEB DEVELOPING',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.lock, color: Colors.white, size: 18),
//                   SizedBox(width: 5),
//                   Text(
//                     'Private Group · 5 members',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 180,
//           left: 20,
//           child: Row(
//             children: <Widget>[
//               // Circle Avatars
//               for (var i = 0; i < 5; i++)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                   child: CircleAvatar(
//                     radius: 20,
//                     // backgroundImage: AssetImage('assets/avatar_$i.png'), // Paths to your avatars
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
