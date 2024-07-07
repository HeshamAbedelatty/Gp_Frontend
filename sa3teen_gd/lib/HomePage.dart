import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Musicplayer.dart';
import 'Pages/BottomAppBar/BottomBar.dart';
import 'Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'Pages/HandwrittingToText/HandwittingToText.dart';
import 'Pages/groups/listofMyGroupsPage_recommendation/finalListGroups_recommendation.dart';
import 'Pages/pomodoroPage/ThePage/newpomo.dart';
import 'package:gp_screen/pages/chatBotIntegrated/Chat Bot copy 2.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';
import 'Pages/schedeulePage/ThePage/FinalSchedulePage.dart';
import 'Pages/toDoListPage/ThePage/ToDoListFinal.dart';
import 'package:gp_screen/TtoAudio.dart';

// el video w el appbar
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget buildCustomContainerGroups(BuildContext context, String text,
      AssetImage imageProvider, double iconSize, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: iconSize + 4,
                height: iconSize + 2,
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomContainerMotivation(
      BuildContext context, ImageProvider imageProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: 0.65 * screenWidth,
      height: 0.187 * screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
    );
  }

  int _current = 0;

  List<String> get imagePaths => [
    'lib/assets/icons/240_F_83825573_00UVBhk7onQSx3DDwqoPUJGxZdjjmBtc.jpg',
    'lib/assets/icons/240_F_101141069_zspoNC0uVmKh8CJzNtbUQpxTjfi71mHq.jpg',
    'lib/assets/icons/240_F_101204019_9IvXJUEznXaAAIPs8ohsX8QxsHBAwtqw.jpg',
    'lib/assets/icons/240_F_136949956_Lj7iLID6C24JwkxoWyyDz1OmskHIKrRW.jpg',
    'https://t3.ftcdn.net/jpg/01/01/14/10/240_F_101141069_zspoNC0uVmKh8CJzNtbUQpxTjfi71mHq.jpg',
    'lib/assets/icons/240_F_311418783_3FT8u5yeLsbEaSZovOWidCtzFAGWr0hl.jpg',
    'https://t4.ftcdn.net/jpg/03/11/41/87/240_F_311418783_3FT8u5yeLsbEaSZovOWidCtzFAGWr0hl.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBar(title: 'Home'),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imagePaths.map((imagePath) {
                        return Container(
                          margin: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: imagePath.startsWith('http')
                                  ? NetworkImage(imagePath)
                                  : AssetImage(imagePath) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              textAlign: TextAlign.center,
              'Services',
              style: TextStyle(
                fontSize: 20, // Increase font size to 20
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold, // Change font type to Roboto
              ),
            ),
            const SizedBox(width: 80),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCustomContainerGroups(
                        context,
                        'Groups',
                        // 'lib/assets/icons/treeCupAltered.png'
                        const AssetImage('lib/assets/icons/pngwing.com2.png'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                // return GroupPage(
                                //   id: 1,
                                //   groupName: 'Example Group',
                                //   groupImageUrl: 'url_to_image',
                                //   members: ['Member 1', 'Member 2'],
                                //   groupState: 'Active',
                                // );
                               return GroupsScreen(
                                  url: 'groups/list_groups/',pageName: 'Groups',
                                  accessToken:
                                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNjU0MDA0LCJpYXQiOjE3MjAzNTgwMDQsImp0aSI6Ijg4ZTY5OTBlM2VhOTQ4NGU5ZGZjYzhhNTkzYjIyY2U1IiwidXNlcl9pZCI6NX0.WRNsW-YpHTPqUcYaUjicWi0IQ3GzAkL5ZrhPEXFnbWg',
                                );
                                // Return the GroupPage widget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'ChatBot',
                        const AssetImage('lib/assets/icons/chat-bot.png'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return const ChatScreen(); // Return the ChatScreen widget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'To-DoList',
                        const AssetImage('lib/assets/icons/pngwing.com (6).png'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return const ToDoListScreen(); // Return the ToDoListScreen widget here
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCustomContainerGroups(
                        context,
                        'Pomodoro',
                        const AssetImage('lib/assets/icons/iStock-1302208532.jpg'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return PomodoroTimer(); // Return the PomodoroTimer widget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'Schedules',
                        const AssetImage('lib/assets/icons/study-4k-with-coffee-no6c7yawny43am8k.jpg'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return SchedulePage(); // Return the SchedulePage widget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'Library',
                        const AssetImage('lib/assets/icons/table-work-computer-study-reading.jpg'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return TextToSpeechApp(); // Return the TextToSpeechApp widget here
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCustomContainerGroups(
                        context,
                        'Handwriting',
                        const AssetImage('lib/assets/icons/text-to-handwriting-converter.png'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return HandwrittenToTextWidget(); // Return the HandwrittenToTextWidget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'TextToSpeech',
                        const AssetImage('lib/assets/icons/text-speech_6268332.png'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return TextToSpeechApp(); // Return the TextToSpeechApp widget here
                              },
                            ),
                          );
                        },
                      ),
                      buildCustomContainerGroups(
                        context,
                        'Music BG',
                        const AssetImage('lib/assets/icons/FreeVector-Music-Icon-1.jpg'),
                        70,
                            () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return AudioPlayerApp(); // Return the AudioPlayerApp widget here
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(), // Add BottomNavBar here
    );
  }
}
