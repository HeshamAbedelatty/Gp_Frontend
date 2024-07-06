// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gp_screen/Pages/More_page/ProfilePic.dart';

// class Appbar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Size get preferredSize =>
//       Size.fromHeight(kToolbarHeight + 150); // Adjust height accordingly

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,

//       //leading: Icon(Icons.access_alarm),
//       actions: [
//         Icon(Icons.search),
//         SizedBox(width: 16), // Add SizedBox with desired width
//         Icon(Icons.more_vert),
//       ],
//       iconTheme: IconThemeData(color: Colors.white), // Make system icons white
//       flexibleSpace: FlexibleSpaceBar(
//         background: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               'sa3teen_gd/lib/assets/icons/moreback.jpg', // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//             Container(
//               color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
//             ),
//           ],
//         ),
//       ),
//       elevation: 15,
//       shape: ContinuousRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         ),
//       ),
//       bottom: PreferredSize(
//         preferredSize: Size.zero,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal, // Adjust as per your requirement
//           child: Column(
//             children: [
//               ProfilePic(),
//               Text("Hala", // Use widget._usernameController.text
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Color.fromARGB(255, 255, 255, 255),
//                       fontWeight: FontWeight.w800)

//                   //.copyWith(fontSize: 16),
//                   // Adjust font size as needed
//                   ),
//               // Add more widgets if needed
//             ],
//           ),
//         ),
//       ),
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//     );
//   }
// }
