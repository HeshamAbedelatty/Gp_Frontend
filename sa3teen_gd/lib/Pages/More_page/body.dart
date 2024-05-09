import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp_screen/Pages/More_page/EditProfilePage';

import 'ProfilePic.dart';

class Body extends StatelessWidget {
  const Body({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/back.jpg"),
          fit: BoxFit.cover,
        ),
      ),*/
      child: Padding(
        padding:
            const EdgeInsets.all(20.0), // Add padding outside the container
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(248, 247, 242, 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: "lib/assets/icons/edit (2).png",
                              text: "Edit Profile",
                              press: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return const EditProfilePage();
                                    },
                                  ),
                                );
                              },
                            ),
                            ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: "lib/assets/icons/notification (1).png",
                              text: "Notifications",
                              press: () {},
                            ),
                            ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: "lib/assets/icons/chat.png",
                              text: "Contact US",
                              press: () {},
                            ),
                            ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: "lib/assets/icons/settings (2).png",
                              text: "Settings",
                              press: () {},
                            ),
                            ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: "lib/assets/icons/about.png",
                              text: "About Us",
                              press: () {},
                            ),
                            ProfileMenuDivider(),
                            ProfileMenuItem(
                              icon: "lib/assets/icons/logout.png",
                              text: "Log Out",
                              press: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color.fromARGB(0, 245, 246, 249),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
                color: Color.fromRGBO(161, 119, 64, 1), // Example color
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!,
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Color.fromRGBO(161, 119, 64, 1)), // Corrected color
          ],
        ),
      ),
    );
  }
}

class ProfileMenuDivider extends StatelessWidget {
  const ProfileMenuDivider({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // Adjust margin as needed
      child: Divider(
        height: 2,
        color: const Color.fromRGBO(
            161, 119, 64, 1), // Brown color for the divider
        thickness: 0.5, // Smaller thickness of the divider
      ),
    );
  }
}
