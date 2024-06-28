// // import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
//
// class customAppBar extends StatelessWidget
//    String? title ;
//   const customAppBar({super.key, required String title}) {
//   this.title = title;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration( color: kprimaryColourGreen,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
//       height: 125,
//       //width: 50,
//
//       padding:const EdgeInsets.symmetric(horizontal: 12),
//
//
//       child: Row(
//         children: [
//           const Icon(Icons.person,color: Colors.white,),
//           Spacer(),
//           const Text(
//             "${title}",
//             style: TextStyle(fontSize: 20,color: Colors.white),
//           ),
//           Spacer(),
//           Container(
//             height: 27,
//             width: 27,
//             color: kprimaryColourGreen,
//             child:const Center(
//               child: Icon(Icons.search,color:Colors.white,),
//             ),
//           ),
//           Container(
//             height: 27,
//             width: 27,
//             color: kprimaryColourGreen,
//             child:const Center(
//               child: Icon(Icons.menu,color: Colors.white,),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

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
          const Icon(Icons.person, color: Colors.white),
          Spacer(),
          Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Spacer(),
          Container(
            height: 27,
            width: 27,
            color: kprimaryColourGreen,
            child: const Center(
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
          Container(
            height: 27,
            width: 27,
            color: kprimaryColourGreen,
            child: const Center(
              child: Icon(Icons.menu, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
