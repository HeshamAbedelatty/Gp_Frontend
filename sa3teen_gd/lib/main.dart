import 'package:flutter/material.dart';
import 'package:sa3teen_gd/Pages/LoginPage.dart';
import 'package:sa3teen_gd/Pages/homePage.dart';
import 'package:sa3teen_gd/Pages/signUpPage.dart';
import 'package:sa3teen_gd/widgets/UserModel.dart';

void main()  {
//stored data
addUser('salma', 'mourad', 'salma','01159228572', '111', '111');
addUser('hala', 'gamal', 'hala', '0','222', '222');
addUser('hesham', 'ahmed', 'hesham','1', '333', '333');
addUser('mohamed', 'bahaa', 'bahaa','2', '444', '444');
addUser('mohamed', 'khalil', 'khalil','3', '555', '555');
//salma@example.com

runApp(const sa3teenGd());
}
class sa3teenGd extends StatelessWidget {
  const sa3teenGd();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        signUpPage.id: (context) => signUpPage(),
        homePage.id:(context) => homePage(),
      },
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}



