import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gp_screen/Pages/loginPage/ThePage/LoginPage.dart';

void main() async {
  // Initialize any necessary setup here
  runApp(const Sa3teenGd());
}

final dio = Dio();

void getHttp() async {
  final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=4bbb9e6d66614137aa67978c62cefaa7');
  print(response.data);
}

class Sa3teenGd extends StatelessWidget {
  const Sa3teenGd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*routes: {
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
      },
      initialRoute: LoginPage.id,*/
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => LoginPage());
        }
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return FlutterEasyLoading(child: child!);
      },
    );
  }
}
