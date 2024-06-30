import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/icons/treeCupAltered.png',  // Ensure you have the logo image in your assets
              height: 150.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Sa3teen Gd',  // Replace with your app name
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,  // Green color for the app name
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Now Studying can be Easier...',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,  // Green color for the slogan
              ),
            ),
            const SizedBox(height: 50.0),
            const SpinKitCircle(
              color: Colors.green,  // Green color for the loading spinner
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'dart:async';

// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       Navigator.pushReplacementNamed(context, '/login');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kprimaryColourWhite,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.asset(
//               'lib/assets/icons/treeCupAltered.png',  // Ensure you have the logo image in your assets
//               height: 150.0,
//             ),
//           const  SizedBox(height: 20.0),
//            const Text(
//               'Sa3teen Gd',  // Replace with your app name
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,  // Green color for the app name
//               ),
//             ),
//            const SizedBox(height: 10.0),
//            const Text(
//               'Now Studying can be Easier...',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.black,  // Green color for the slogan
//               ),
//             ),
//             const SizedBox(height: 50.0),
//            const SpinKitCircle(
//               color: Colors.green,  // Green color for the loading spinner
//               size: 50.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
