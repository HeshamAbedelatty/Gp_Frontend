import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gp_screen/Pages/audio2%20copy/audioplayerstate.dart';
import 'package:gp_screen/Pages/loginPage/ThePage/LoginPage.dart';
import 'package:gp_screen/Pages/profile/library/folder.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/library.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Pages/APIsSalma/CommentsProvider.dart';
import 'Pages/APIsSalma/GroupsAPIfinal.dart';
import 'Pages/APIsSalma/MyGroups/GroupListProvider.dart';
import 'Pages/APIsSalma/ProviderMaterial.dart';
import 'Pages/APIsSalma/apiOfMaterials.dart';
import 'Pages/APIsSalma/posts/PostProviderrrrr.dart';
import 'Pages/APIsSalma/searchGroupProvider.dart';
import 'Pages/audio2 copy/audio.dart';
import 'Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AudioAdapter());
  await Hive.openBox<Audio>('audios');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
      create: (context) => LibraryModel(),
      // child: MyApp(),
    ),
        ChangeNotifierProvider(
          create: (context) => CommentsProvider(accesstokenfinal),
        ),
        ChangeNotifierProvider(
          create: (context) => GroupsProvider(accesstokenfinal),
        ),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => MaterialProvider()),
        ChangeNotifierProvider(create: (_) => MyGroupProvider()),
        ChangeNotifierProvider(create: (context) => MaterialsProvider()),
        ChangeNotifierProvider(create: (_) => ListGroupsProvider()),
        ChangeNotifierProvider<Api_services>(
          create: (context) => Api_services(),
        ),
        ChangeNotifierProvider<AudioPlayerState>(
          create: (context) => AudioPlayerState(),
        ),
        ChangeNotifierProvider(
          create: (context) => LibraryModel(),
        ),

      ],



      child: MaterialApp(
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
      ),
    );
  }
}
