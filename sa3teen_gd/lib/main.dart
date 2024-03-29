import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/loginPage/LoginPage.dart';
import 'package:gp_screen/Pages/signUpPage/signUpPage.dart';
import 'package:gp_screen/widgets/signUp_LoginWidgets/UserModel.dart';
//import 'package:hive_flutter/adapters.dart';

void main() async {
  // await Hive.initFlutter();
  // await Hive.openBox(ktask);
  // getHttp();

//stored data
  addUser('salma', 'mourad', 'salma', '01159228572', '111', '111');
  addUser('hala', 'gamal', 'hala', '0', '222', '222');
  addUser('hesham', 'ahmed', 'hesham', '1', '333', '333');
  addUser('mohamed', 'bahaa', 'bahaa', '2', '444', '444');
  addUser('mohamed', 'khalil', 'khalil', '3', '555', '555');
//salma@example.com

  runApp(const sa3teenGd());
}

final dio = Dio();
void getHttp() async {
  final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=4bbb9e6d66614137aa67978c62cefaa7');
  print(response.data);
}

class sa3teenGd extends StatelessWidget {
  const sa3teenGd();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        //HomePage.id:(context) => HomePage(),
      },
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
