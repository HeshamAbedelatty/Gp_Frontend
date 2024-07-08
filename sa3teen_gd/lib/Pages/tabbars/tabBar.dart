
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/More_page/profile_screen.dart';
class tabbar extends StatelessWidget implements PreferredSizeWidget {
  final String? profileImageUrl;
  final VoidCallback? onAvatarTap;

  const tabbar({Key? key, this.profileImageUrl, this.onAvatarTap}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // GestureDetector(
          //   onTap: onAvatarTap,
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         'lib/assets/icons/headphone.png',
          //         height: 38,
          //       ),
          //       const SizedBox(width: 8),
          //       CircleAvatar(
          //         radius: 20,
          //         backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            children: [
              const Text(
                "Sa3teen Gd",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(width: 20),
              Image.asset(
                'lib/assets/icons/sa3teenGd.png',
                height: 70,
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(56, 161, 67, 1),
      elevation: 15,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromWidth(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
        ),
     ),
);
}
}

// class TabBarWithProfile extends StatelessWidget implements PreferredSizeWidget {
//   final String? profileImageUrl;

//   const TabBarWithProfile({Key? key,  this.profileImageUrl}) : super(key: key);

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Colors.white),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProfileScreen()),
//               );
//             },
//             child: Row(
//               children: [
//                 Image.asset(
//                   'lib/assets/icons/headphone.png',
//                   height: 38,
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: NetworkImage(profileImageUrl!),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Text(
//                 "Sa3teen Gd",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25,
//                 ),
//               ),
//               SizedBox(width: 20),
//               Image.asset(
//                 'lib/assets/icons/sa3teenGd.png',
//                 height: 70,
//               ),
//             ],
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromRGBO(56, 161, 67, 1),
//       elevation: 15,
//       shape: const ContinuousRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         ),
//       ),
//       bottom: const PreferredSize(
//         preferredSize: Size.fromWidth(0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//         ),
//      ),
// );
// }
// }
// class TabBbarWithProfile extends StatelessWidget implements PreferredSizeWidget {
//   final String profileImageUrl;

//   const TabBbarWithProfile({Key? key, required this.profileImageUrl})
//       : super(key: key);

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kToolbarHeight + 10); // Adjust height accordingly

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       iconTheme: const IconThemeData(color: Colors.white),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: NetworkImage(profileImageUrl),
//               ),
//               const SizedBox(width: 12), 
//               Image.asset(
//                 'lib/assets/icons/headphone.png', // Replace with your search icon image path
//                 height: 35, // Adjust the height as needed
//               ),
//               // Headphones icon
//               // Add space between headphones icon and avatar
              
//             ],
//           ),
//           Row(
//             children: [
//               const Text(
//                 "Sa3teen Gd",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               const SizedBox(width: 30),
//               Image.asset(
//                 'lib/assets/icons/sa3teenGd.png', // Replace with your search icon image path
//                 height: 75, // Adjust the height as needed
//               ),
//             ],
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromRGBO(56, 161, 67, 1),
//       flexibleSpace: const FlexibleSpaceBar(),
//       elevation: 15,
//       shape: const ContinuousRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(50),
//           bottomRight: Radius.circular(50),
//         ),
//       ),
//       bottom: const PreferredSize(
//         preferredSize: Size.fromWidth(0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal, // Adjust as per your requirement
//         ),
//      ),
// );
// }
// }

// // import 'package:flutter/material.dart';

// // class tabbar extends StatelessWidget implements PreferredSizeWidget {
// //   @override
// //   Size get preferredSize =>
// //       const Size.fromHeight(kToolbarHeight + 10); // Adjust height accordingly

// //   @override
// //   Widget build(BuildContext context) {
// //     return AppBar(
// //       iconTheme: const IconThemeData(color: Colors.white),
// //       title: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Row(
// //             children: [
// //               Image.asset(
// //                 'lib/assets/icons/headphone.png', // Replace with your search icon image path
// //                 height: 38, // Adjust the height as needed
// //               ),
// //               // Headphones icon

// //               const SizedBox(
// //                   width: 8), // Add space between headphones icon and avatar
// //               const CircleAvatar(
// //                 // Replace with user avatar
// //                 radius: 20,
// //                 backgroundImage:
// //                     AssetImage('lib/assets/icons/profile.jpg'), // Adjust path
// //               ),
// //             ],
// //           ),
// //            Row(
// //             children: [
// //               // Add space between search icon and app name
// //               Text(
// //                 "Sa3teen Gd",
// //                 style: TextStyle(
// //                   color: Color.fromARGB(255, 255, 255, 255),
// //                   // fontWeight: FontWeight.bold,
// //                   fontSize: 25,
// //                   //fontFamily: 'lobster',
// //                 ),
// //               ),
// //               // Spacer(flex: 1,),
// //               SizedBox(width: 20),
// //               Image.asset(
// //                 'lib/assets/icons/sa3teenGd.png', // Replace with your search icon image path
// //                 height: 70, // Adjust the height as needed
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //       //shadowColor: Color.fromRGBO(0, 0, 0, 0.575),
// //       backgroundColor: const Color.fromRGBO(56, 161, 67, 1),
// //       flexibleSpace: const FlexibleSpaceBar(),
// //       elevation: 15,
// //       shape: const ContinuousRectangleBorder(
// //         borderRadius: BorderRadius.only(
// //           bottomLeft: Radius.circular(50),
// //           bottomRight: Radius.circular(50),
// //         ),
// //       ),
// //       bottom: const PreferredSize(
// //         preferredSize: Size.fromWidth(0),
// //         child: SingleChildScrollView(
// //           scrollDirection: Axis.horizontal, // Adjust as per your requirement
// //         ),
// //       ),
// //     );
// //   }
// // }
