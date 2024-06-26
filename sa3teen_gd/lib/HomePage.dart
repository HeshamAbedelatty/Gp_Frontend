import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:gp_screen/Chat%20Bot.dart';
import 'package:gp_screen/Logic.dart';
import 'Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'Pages/HandwrittingToText/HandwittingToText.dart';
import 'Pages/pomodoroPage/ThePage/newpomo.dart';
import'package:gp_screen/pages/chatBotIntegrated/Chat Bot copy 2.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';
import 'Pages/schedeulePage/ThePage/FinalSchedulePage.dart';
import 'Pages/toDoListPage/ThePage/ToDoListFinal.dart';
// import 'package:gp_screen/pages/textToSpeechPage/ThePage/textToSpeech.dart';
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

  List<String> videoPaths = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: customAppBar(
        //   // title: 'Home',
        //
        // ),

        body: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Services',
                          style: TextStyle(
                              fontSize: 18, // Increase font size to 16
                              fontFamily: 'Roboto',
                              fontWeight:
                                  FontWeight.bold // Change font type to Roboto
                              // You can also apply other TextStyle properties as needed
                              ),
                        ),
                        SizedBox(width: 80),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 80),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return  HandwrittenToTextWidget(); // Replace ViewAllPage with the destination page you want to navigate to
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration
                                  .underline, // Add underline decoration
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                                  return  GroupPage(
                                    id: 1,
                                    groupName: 'Example Group',
                                    groupImageUrl: 'url_to_image',
                                    members: ['Member 1', 'Member 2'],
                                    groupState: 'Active',); // Return the ChatScreen widget here
                                },
                              ),
                            );
                          },
                        ),
                        buildCustomContainerGroups(
                          context,
                          'ChatBot',
                          const AssetImage(
                              'lib/assets/icons/chat-bot.png'),
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
                          const AssetImage(
                              'lib/assets/icons/pngwing.com (6).png'),
                          70,
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const ToDoListScreen(); // Return the ChatScreen widget here
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                                  return  PomodoroTimer(); // Return the ChatScreen widget here
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
                                  return  SchedulePage(); // Return the ChatScreen widget here
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
                                  return  TextToSpeechApp(); // Return the ChatScreen widget here
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Motivation Videos',
                          style: TextStyle(
                              fontSize: 18, // Increase font size to 16
                              fontFamily: 'Roboto',
                              fontWeight:
                                  FontWeight.bold // Change font type to Roboto
                              // You can also apply other TextStyle properties as needed
                              ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 80),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const ChatScreen(); // Replace NextPage with the destination page you want to navigate to
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'See More',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration
                                  .underline, // Add underline decoration
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: videoPaths.map((videoPath) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              width: 0.65 * MediaQuery.of(context).size.width,
                              height:
                                  0.187 * MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    18.0), // Border radius for the circular container
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: AspectRatio(
                                  aspectRatio:
                                      2.0, // Ensures the video fits the circular container
                                  child: VideoPlayerWidget(videoUrl: videoPath),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
        // bottomNavigationBar: BottomNavBar());
  }
}
