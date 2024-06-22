import 'package:flutter/material.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> motivationalSentences = [
    'Believe in yourself and all that you are.',
    'The harder you work for something, the greater you’ll feel when you achieve it.',
    'Don’t stop when you’re tired. Stop when you’re done.',
    'Success doesn’t just find you. You have to go out and get it.',
    'Great things never come from comfort zones.',
  ];

  final List<String> backgroundImages = [
    'lib/assets/icons/Web_Development_Banner_Image_0e476d1ab6.jpg',
    // 'lib/assets/icons/depositphotos_3705693-stock-photo-climber-on-sunset.jpgg',
    'lib/assets/icons/pexels-sulimansallehi-1576939.jpg',
    'lib/assets/icons/istockphoto-1361421117-612x612.jpg',
    'lib/assets/icons/57e78ac6de5e41bdbc6eff9667538bff.jpg',
    'lib/assets/icons/table-work-computer-study-reading.jpg',
    'lib/assets/icons/study-4k-with-coffee-no6c7yawny43am8k.jpg',
    // 'lib/assets/icons/HD-wallpaper-classical-music-for-reading-study-and-concentration-dark-academia-playlist-dark-academia-aesthetic.jpg',
    // 'assets/background4.jpg',
    // 'assets/background5.jpg',
  ];

  late String selectedSentence;
  late String selectedBackgroundImage;

  @override
  void initState() {
    super.initState();
    final random = Random();
    selectedSentence =
        motivationalSentences[random.nextInt(motivationalSentences.length)];
    selectedBackgroundImage =
        backgroundImages[random.nextInt(backgroundImages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePage(), // The home page underneath the splash screen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // Slightly smaller width
                height: MediaQuery.of(context).size.height *
                    0.9, // Slightly smaller height
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                        selectedBackgroundImage), // Random background photo
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          selectedSentence,
                          style:const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon:const Icon(Icons.close_rounded), // Close icon
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Home Page'),
      ),
      body:const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final List<String> motivationalSentences = [
//     'Believe in yourself and all that you are.',
//     'The harder you work for something, the greater you’ll feel when you achieve it.',
//     'Don’t stop when you’re tired. Stop when you’re done.',
//     'Success doesn’t just find you. You have to go out and get it.',
//     'Great things never come from comfort zones.',
//   ];

//   late String selectedSentence;

//   @override
//   void initState() {
//     super.initState();
//     final random = Random();
//     selectedSentence = motivationalSentences[random.nextInt(motivationalSentences.length)];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           HomePage(),  // The home page underneath the splash screen
//           Container(
//             width: MediaQuery.of(context).size.width * 0.9,  // Slightly smaller width
//             height: MediaQuery.of(context).size.height * 0.9,  // Slightly smaller height
//             decoration: BoxDecoration(
//               color: Colors.white,
//               image: DecorationImage(
//                 image: AssetImage('lib/assets/icons/Web_Development_Banner_Image_0e476d1ab6.jpg'),  // Background photo
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.circular(20.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),  // changes position of shadow
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.all(20.0),
//             child: Stack(
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Text(
//                       selectedSentence,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.bold,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 10.0,
//                             color: Colors.black,
//                             offset: Offset(5.0, 5.0),
//                           ),
//                         ],
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     icon: Icon(Icons.close),
//                     // Image.asset('assets/close_icon.png'),  // Close icon
//                     iconSize: 30.0,
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: (context) => HomePage(),
//                       ));
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }
