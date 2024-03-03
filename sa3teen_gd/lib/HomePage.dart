//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
//
// import 'package:dots_indicator/dots_indicator.dart';
//
//
//
// class HomePage extends StatefulWidget {
//
//    HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget buildCustomContainerGroups(
//       BuildContext context, String text, ImageProvider imageProvider, double iconSize) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300], // Background color for the icon container
//         borderRadius: BorderRadius.circular(12), // Rounded corners for the container
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: iconSize,
//               height: iconSize,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle, // Make the icon container circular
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: Offset(0, 2), // Shadow position
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: Image(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 4), // Spacing between icon and text
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.black87, // Text color
//                 fontSize: 12, // Text size
//                 fontWeight: FontWeight.bold, // Bold text
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget buildCustomContainerMotivation(BuildContext context, ImageProvider imageProvider) {
//   Widget buildCustomContainerMotivation(BuildContext context, ImageProvider imageProvider) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Container(
//       width: 0.65 * screenWidth,
//       height: 0.187 * screenHeight,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8.0),
//     );
//   }
//
//   int _current = 0;
//
//   List<String> carouselItems = [
//     'assets/image1.jpg',
//     'assets/image2.jpg',
//     'assets/image3.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//
//
//
//
//         child: Column(
//           children: [
//
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: CarouselSlider(
//                       options: CarouselOptions(
//                         height: 400,
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         viewportFraction: 0.8,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _current = index;
//                           });
//                         },
//                       ),
//                       items: [
//                         Container(
//                           margin: EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: AssetImage('assets/image1.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         // Add more CarouselItems as needed
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//
//             const SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text('Services'),
//                       SizedBox(width: 0.2 * screenWidth), // 20% of screen width
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 0.2 * screenWidth),
//                       const Text('View All'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30,),
//             Center(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//
//
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', AssetImage('assets/teacup.png'), 70),
//
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30,),
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text('Motivation Videos'),
//                       SizedBox(width: 0.1 * screenWidth),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 0.2 * screenWidth),
//                       const Text('See More'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20,),
//             Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: 0.65 * screenWidth,
//                           height: 0.187 * screenHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.greenAccent,
//                             border: Border.all(
//                               color: Colors.blue, // Set the color of the border
//                               width: 4.0,
//                               style: BorderStyle.none,
//                             ),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(8.0),
//                         ),
//                         const SizedBox(width: 40,),
//                         Container(
//                           width: 0.65 * screenWidth,
//                           height: 0.187 * screenHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.purple,
//                             border: Border.all(
//                               color: Colors.blue, // Set the color of the border
//                               width: 4.0,
//                               style: BorderStyle.none,
//                             ),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(8.0),
//                         ),
//                         const SizedBox(width: 40,),
//
//
//                         buildCustomContainerMotivation(context, AssetImage('teacup.png')),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20,),
//             BottomAppBar(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.home),
//                     onPressed: () {
//                       // Handle home icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.chat_bubble),
//                     onPressed: () {
//                       // Handle chat with bot icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.people),
//                     onPressed: () {
//                       // Handle people icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.notifications),
//                     onPressed: () {
//                       // Handle notification icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.settings),
//                     onPressed: () {
//                       // Handle settings icon press
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget buildCustomContainerGroups(
//       BuildContext context, String text, ImageProvider imageProvider, double iconSize) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300], // Background color for the icon container
//         borderRadius: BorderRadius.circular(12), // Rounded corners for the container
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: iconSize,
//               height: iconSize,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle, // Make the icon container circular
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2), // Shadow position
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: Image(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4), // Spacing between icon and text
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black87, // Text color
//                 fontSize: 12, // Text size
//                 fontWeight: FontWeight.bold, // Bold text
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCustomContainerMotivation(
//       BuildContext context, ImageProvider imageProvider) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Container(
//       width: 0.65 * screenWidth,
//       height: 0.187 * screenHeight,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8.0),
//     );
//   }
//
//   int _current = 0;
//   List<String> imagePaths = [
//     'assets/360092821_837901977782666_5270737507025446062_n.jpg',
//     // 'assets/teacup.png',
//     'assets/EW_RXpjXYAAum_5.jpg',
//     'assets/website-template-preview-389597.jpg',
//     'assets/error-404-background-digital-art-uhdpaper.com-hd-8.2818.jpg',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox( // Provide a width constraint here
//               width: MediaQuery.of(context).size.width,
//               // child: Row(
//               //   children: [
//               //     Expanded(
//               //       child: CarouselSlider(
//               //         options: CarouselOptions(
//               //           height: 200,
//               //           autoPlay: true,
//               //           enlargeCenterPage: true,
//               //           aspectRatio: 16 / 9,
//               //           autoPlayCurve: Curves.fastOutSlowIn,
//               //           enableInfiniteScroll: true,
//               //           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               //           viewportFraction: 0.8,
//               //           onPageChanged: (index, reason) {
//               //             setState(() {
//               //               _current = index;
//               //             });
//               //           },
//               //         ),
//               //         items: [
//               //           Container(
//               //             margin: const EdgeInsets.all(5.0),
//               //             decoration: BoxDecoration(
//               //               borderRadius: BorderRadius.circular(8.0),
//               //               image: const DecorationImage(
//               //                 image: AssetImage('assets/teacup.png'),
//               //                 fit: BoxFit.cover,
//               //               ),
//               //             ),
//               //           ),
//               //           // Add more CarouselItems as needed
//               //         ],
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround, // Add this line
//                 children: [
//                   Expanded(
//                     child: CarouselSlider(
//                       options: CarouselOptions(
//                         height: 200,
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                         viewportFraction: 0.8,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _current = index;
//                           });
//                         },
//                       ),
//                       items: imagePaths.map((imagePath) {
//                         return Container(
//                           margin: const EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: AssetImage(imagePath),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   )
//                 ],
//               ),
//
//             ),
//             const SizedBox(height: 20),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Services'),
//                       SizedBox(width: 80), // Adjust as needed
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80), // Adjust as needed
//                       Text('View All'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Center(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Motivation Videos'),
//                       SizedBox(width: 60),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80),
//                       Text('See More'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: 0.65 * screenWidth,
//                           height: 0.187 * screenHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.greenAccent,
//                             border: Border.all(
//                               color: Colors.blue, // Set the color of the border
//                               width: 4.0,
//                               style: BorderStyle.none,
//                             ),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(8.0),
//                         ),
//                         const SizedBox(width: 40),
//                         Container(
//                           width: 0.65 * screenWidth,
//                           height: 0.187 * screenHeight,
//                           decoration: BoxDecoration(
//                             color: Colors.purple,
//                             border: Border.all(
//                               color: Colors.blue, // Set the color of the border
//                               width: 4.0,
//                               style: BorderStyle.none,
//                             ),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(8.0),
//                         ),
//                         const SizedBox(width: 40),
//                         // buildCustomContainerMotivation(context, const AssetImage('teacup.png')),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             BottomAppBar(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children:  [
//                   IconButton(
//                     icon: const Icon(Icons.home),
//                     onPressed: () {
//                       // Handle home icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.chat_bubble),
//                     onPressed: () {
//                       // Handle chat with bot icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.people),
//                     onPressed: () {
//                       // Handle people icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.notifications),
//                     onPressed: () {
//                       // Handle notification icon press
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.settings),
//                     onPressed: () {
//                       // Handle settings icon press
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }































// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:video_player/video_player.dart';
//
// class HomePage extends StatefulWidget {
//
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget VideoPlayerWidget(String videoPath) {
//     return Container(
//       width: 200,
//       height: 200,
//       child: VideoPlayer(
//         VideoPlayerController.asset(
//           videoPath,
//         ),
//       ),
//     );
//   }
//
//   int _current = 0;
//
//
//   // Define your list of image paths as a getter
//   List<String> get imagePaths => [
//     'assets/360092821_837901977782666_5270737507025446062_n.jpg',
//     // 'assets/teacup.png',
//     'assets/EW_RXpjXYAAum_5.jpg',
//     'assets/website-template-preview-389597.jpg',
//     'assets/error-404-background-digital-art-uhdpaper.com-hd-8.2818.jpg',
//   ];
//   List<String> videoPaths = [
//     'assets/VID-20220913-WA0126.mp4',
//     'assets/VID-20230406-WA0014.mp4',
//     'assets/VID-20230406-WA0019.mp4',
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox( // Provide a width constraint here
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround, // Add this line
//                 children: [
//                   Expanded(
//                     child: CarouselSlider(
//                       options: CarouselOptions(
//                         height: 200,
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                         viewportFraction: 0.8,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _current = index;
//                           });
//                         },
//                       ),
//                       items: imagePaths.map((imagePath) {
//                         return Container(
//                           margin: const EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: AssetImage(imagePath),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Services'),
//                       SizedBox(width: 80), // Adjust as needed
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80), // Adjust as needed
//                       Text('View All'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Center(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Motivation Videos'),
//                       SizedBox(width: 60),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80),
//                       Text('See More'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: videoPaths.map((videoPath) {
//                         return Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                           width: 0.65 * MediaQuery.of(context).size.width,
//                           height: 0.187 * MediaQuery.of(context).size.height,
//                           child: VideoPlayerWidget(videoPath), // Replace VideoPlayerWidget with your video player implementation
//                         );
//                       }).toList(),
//                     ),
//                   ),
//
//
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children:  [
//             IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 // Handle home icon press
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.chat_bubble),
//               onPressed: () {
//                 // Handle chat with bot icon press
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.people),
//               onPressed: () {
//                 // Handle people icon press
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.notifications),
//               onPressed: () {
//                 // Handle notification icon press
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 // Handle settings icon press
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCustomContainerGroups(
//       BuildContext context, String text, ImageProvider imageProvider, double iconSize) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300], // Background color for the icon container
//         borderRadius: BorderRadius.circular(12), // Rounded corners for the container
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: iconSize,
//               height: iconSize,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle, // Make the icon container circular
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2), // Shadow position
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: Image(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4), // Spacing between icon and text
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black87, // Text color
//                 fontSize: 12, // Text size
//                 fontWeight: FontWeight.bold, // Bold text
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCustomContainerMotivation(
//       BuildContext context, ImageProvider imageProvider) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Container(
//       width: 0.65 * screenWidth,
//       height: 0.187 * screenHeight,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8.0),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoPaths[0]);
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayerFuture(String videoPath) async {
    _controller = VideoPlayerController.asset(videoPath);
    await _controller.initialize();
  }

  Widget videoPlayerWidget(String videoPath) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildCustomContainerGroups(
      BuildContext context, String text, ImageProvider imageProvider, double iconSize) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomContainerMotivation(
      BuildContext context, ImageProvider imageProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: 0.65 * screenWidth,
      height: 0.187 * screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
    );
  }

  int _current = 0;

  List<String> get imagePaths => [
    'assets/360092821_837901977782666_5270737507025446062_n.jpg',
    'assets/EW_RXpjXYAAum_5.jpg',
    'assets/website-template-preview-389597.jpg',
    'assets/error-404-background-digital-art-uhdpaper.com-hd-8.2818.jpg',
  ];

  List<String> videoPaths = [
    'assets/VID_20220916_101658_644.mp4',

    'assets/VID-20220913-WA0126.mp4',
    'assets/VID-20230406-WA0019.mp4',

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imagePaths.map((imagePath) {
                        return Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Services'),
                      SizedBox(width: 80),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 80),
                      Text('View All'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                      buildCustomContainerGroups(
                          context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Motivation Videos'),
                      SizedBox(width: 60),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 80),
                      Text('See More'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child:
              // Column(
              //   children: [
              //     const SizedBox(height: 10),
              //     SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: Row(
              //         children: videoPaths.map((videoPath) {
              //           return Container(
              //             margin: const EdgeInsets.symmetric(horizontal: 8.0),
              //             width: 0.65 * MediaQuery.of(context).size.width,
              //             height: 0.187 * MediaQuery.of(context).size.height,
              //             child: videoPlayerWidget(videoPath),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ],
              // ),


              Center(
                child:Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: videoPaths.map((videoPath) {
                            return Container(

                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              width: 0.65 * MediaQuery.of(context).size.width,
                              height: 0.187 * MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: videoPlayerWidget(videoPath),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

              ),

            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Handle home icon press
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble),
              onPressed: () {
                // Handle chat with bot icon press
              },
            ),
            IconButton(
              icon: const Icon(Icons.people),
              onPressed: () {
                // Handle people icon press
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification icon press
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle settings icon press
              },
            ),


 ]
        ),
      ),
    );
  }
}



//
//
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:video_player/video_player.dart';
//
// class NavigationDestination {
//   final Icon icon;
//   final Icon selectedIcon;
//   final String label;
//
//   NavigationDestination({
//     required this.icon,
//     required this.selectedIcon,
//     required this.label,
//   });
//
//   BottomNavigationBarItem buildNavigationBarItem(bool isSelected) {
//     return BottomNavigationBarItem(
//       icon: isSelected ? selectedIcon : icon,
//       label: label,
//     );
//   }
// }
//
// List<Widget> buildBottomNavigationBarItems(List<NavigationDestination> items) {
//   return items.map((item) => item.icon).toList();
// }
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late VideoPlayerController _controller;
//   late List<Widget> _bottomNavigationBarItems;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(videoPaths[0]);
//     _controller.initialize().then((_) {
//       setState(() {});
//     });
//
//     _bottomNavigationBarItems = buildBottomNavigationBarItems(_navigationItems);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _initializeVideoPlayerFuture(String videoPath) async {
//     _controller = VideoPlayerController.asset(videoPath);
//     await _controller.initialize();
//   }
//
//   Widget videoPlayerWidget(String videoPath) {
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture(videoPath),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   Widget buildCustomContainerGroups(
//       BuildContext context, String text, ImageProvider imageProvider, double iconSize) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: iconSize,
//               height: iconSize,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: ClipOval(
//                 child: Image(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               text,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildCustomContainerMotivation(
//       BuildContext context, ImageProvider imageProvider) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Container(
//       width: 0.65 * screenWidth,
//       height: 0.187 * screenHeight,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(8.0),
//     );
//   }
//
//   int _current = 0;
//
//   List<String> get imagePaths => [
//     'assets/360092821_837901977782666_5270737507025446062_n.jpg',
//     'assets/EW_RXpjXYAAum_5.jpg',
//     'assets/website-template-preview-389597.jpg',
//     'assets/error-404-background-digital-art-uhdpaper.com-hd-8.2818.jpg',
//   ];
//
//   List<String> videoPaths = [
//     'assets/VID_20220916_101658_644.mp4',
//
//     'assets/VID-20220913-WA0126.mp4',
//     'assets/VID-20230406-WA0019.mp4',
//
//   ];
//
//   List<NavigationDestination> _navigationItems = [
//     NavigationDestination(
//       icon: Icon(Icons.home_outlined),
//       selectedIcon: Icon(Icons.home_rounded),
//       label: 'Home',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.bookmark_border_outlined),
//       selectedIcon: Icon(Icons.bookmark_rounded),
//       label: 'Bookmarks',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.shopping_bag_outlined),
//       selectedIcon: Icon(Icons.shopping_bag),
//       label: 'Cart',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.person_outline_rounded),
//       selectedIcon: Icon(Icons.person_rounded),
//       label: 'Profile',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     child: CarouselSlider(
//                       options: CarouselOptions(
//                         height: 200,
//                         autoPlay: false,
//                         enlargeCenterPage: true,
//                         aspectRatio: 16 / 9,
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enableInfiniteScroll: true,
//                         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                         viewportFraction: 0.8,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             _current = index;
//                           });
//                         },
//                       ),
//                       items: imagePaths.map((imagePath) {
//                         return Container(
//                           margin: const EdgeInsets.all(5.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: AssetImage(imagePath),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Services'),
//                       SizedBox(width: 80),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80),
//                       Text('View All'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Center(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                       buildCustomContainerGroups(
//                           context, 'mohamed', const AssetImage('assets/teacup.png'), 70),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             const Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('Motivation Videos'),
//                       SizedBox(width: 60),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(width: 80),
//                       Text('See More'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: Center(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: videoPaths.map((videoPath) {
//                           return Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                             width: 0.65 * MediaQuery.of(context).size.width,
//                             height: 0.187 * MediaQuery.of(context).size.height,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 4,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: videoPlayerWidget(videoPath),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: _bottomNavigationBarItems,
//         ),
//       ),
//     );
//   }
// }
