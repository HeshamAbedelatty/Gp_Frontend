import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/More_page/profile_screen.dart';
import'package:gp_screen/pages/chatBotIntegrated/Chat Bot copy 2.dart';



class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(75, 0, 0, 0).withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -5), // Adjust the offset to lift the bar
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle home icon press
                  },
                  icon: Image.asset(
                    "lib/assets/icons/home (3).png", // Replace with your home icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ChatScreen();
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/chat-bot.png', // Replace with your chat icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the chat icon
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/icons/group (1).png', // Replace with your chat icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the chat icon
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/icons/notification (1).png', // Replace with your chat icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the chat icon
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return ProfileScreen();
                        },
                      ),
                    );
                  },
                  icon: Image.asset(
                    'lib/assets/icons/application.png', // Replace with your chat icon asset
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
                // Text under the chat icon
              ],
            ),
            // Repeat the same for other icons...
          ],
        ),
      ),
    );
  }
}

/* Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return const ProfileScreen();
                        },
                      ),
                    ); icons/**/ */