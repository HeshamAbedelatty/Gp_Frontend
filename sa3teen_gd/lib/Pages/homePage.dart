import 'package:flutter/material.dart';
import 'package:sa3teen_gd/Pages/signUpPage/signUpPage.dart';
import 'package:sa3teen_gd/widgets/signUp_LoginWidgets/UserModel.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/signUp_LoginWidgets/feild.dart';



class homePage extends StatelessWidget {
   homePage();
   static String id ="homePage";
     
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
  

