// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// //
// // class customAppBar extends StatelessWidget {
// //   const customAppBar({super.key, });
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration( color: kprimaryColourGreen,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
// //       height: 125,
// //       //width: 50,
// //
// //       padding:const EdgeInsets.symmetric(horizontal: 12),
// //
// //
// //       child: Row(
// //         children: [
// //           const Icon(Icons.person,color: Colors.white,),
// //           Spacer(),
// //           const Text(
// //             "ToDoList",
// //             style: TextStyle(fontSize: 20,color: Colors.white),
// //           ),
// //           Spacer(),
// //           Container(
// //             height: 27,
// //             width: 27,
// //             color: kprimaryColourGreen,
// //             child:const Center(
// //               child: Icon(Icons.search,color:Colors.white,),
// //             ),
// //           ),
// //           Container(
// //             height: 27,
// //             width: 27,
// //             color: kprimaryColourGreen,
// //             child:const Center(
// //               child: Icon(Icons.menu,color: Colors.white,),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
//
// class CustomAppBar extends StatelessWidget {
//   final String title;
//
//   const CustomAppBar({
//     Key? key,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: kprimaryColourGreen,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//       height: 125,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Row(
//         children: [
//     icon: const Icon(Icons.arrow_back, color: Colors.white),
//     onPressed: () {
//     Navigator.of(context).pop();          Spacer(),
//           Text(
//             title,
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           Spacer(),
//           Container(
//             height: 27,
//             width: 27,
//             color: kprimaryColourGreen,
//             child: const Center(
//               child: Icon(Icons.search, color: Colors.white),
//             ),
//           ),
//           Container(
//             height: 27,
//             width: 27,
//             color: kprimaryColourGreen,
//             child: const Center(
//               child: Icon(Icons.menu, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/Pages/More_page/profile_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kprimaryColourGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Spacer(),
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Spacer(),
          SizedBox(width: 10), // Spacer equivalent
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return ProfileScreen(); // Return the ChatScreen widget here
                  },
                ),
              );
            },
            child: Container(
              height: 27,
              width: 27,
              color: kprimaryColourGreen,
              child: const Center(
                child: Image(
                  image: AssetImage('lib/assets/icons/profileicon.png'), // Update the path to your image
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
