import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gp_screen/Chat%20Bot.dart';
import 'package:gp_screen/Logic.dart';
import 'Pages/GroupPostAndCommentPage/Pages/FinalGroupPostsPage.dart';
import 'Pages/pomodoroPage/ThePage/newpomo.dart';

import 'package:gp_screen/widgets/constantsAcrossTheApp/customAppBar.dart';
import 'Pages/schedeulePage/ThePage/FinalSchedulePage.dart';
import 'Pages/toDoListPage/ThePage/ToDoListFinal.dart';


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
        'assets/360092821_837901977782666_5270737507025446062_n.jpg',
        'assets/EW_RXpjXYAAum_5.jpg',
        'assets/website-template-preview-389597.jpg',
        'assets/error-404-background-digital-art-uhdpaper.com-hd-8.2818.jpg',
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
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
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
                                image: AssetImage(imagePath),
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
                                  return const ChatScreen(); // Replace ViewAllPage with the destination page you want to navigate to
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
                              'lib/assets/kjkjpngwing.com (1).png'),
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
                          const AssetImage('lib/assets/pngwing.com.png'),
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
                          const AssetImage('lib/assets/pngwing.com (5).png'),
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
                          const AssetImage('lib/assets/pngwing.com (7).png'),
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
