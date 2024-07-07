import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/FavouriteGroupsList/provider/FavoriteGroupsProvider.dart';
import 'package:provider/provider.dart';
import '../Pages/listofMyGroupsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteGroupsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GroupListPage(),
      ),
    );
  }
}
