import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/BottomAppBar/BottomBar.dart';
import 'package:gp_screen/Pages/tabbars/MorePageTabBar.dart';

import 'body.dart';

class ProfileScreen extends StatelessWidget {
  //const ProfileScreen extends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
