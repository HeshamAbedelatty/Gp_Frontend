import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = "homePage";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: KPrimaryColour,
          body: ListView(
            children: [
              const SizedBox(height: 60),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'home page',
                    style: TextStyle(
                      fontSize: 35,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Text('home page'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/icons/treeCupAltered.png',
                    width: 280,
                    height: 280,
                  )
                ],
              ),
            ],
          )),
    );
  }
}
