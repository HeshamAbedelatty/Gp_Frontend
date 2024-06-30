import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewImagePage extends StatefulWidget {
  @override
  _ViewImagePageState createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                children: [
                  CustomCard(
                    text: 'Use Sa3ten Gd To Make Studying Can Be Easier...',
                    imagePath: 'lib/assets/man.png',
                    gradientStartColor: Color.fromARGB(201, 255, 231, 153),
                    gradientEndColor: Color(0xFF38A143),
                  ),
                  CustomCard(
                    text: 'Another message here',
                    imagePath: 'lib/assets/man.png',
                    gradientStartColor: Color.fromARGB(201, 255, 231, 153),
                    gradientEndColor: Color(0xFF38A143),
                  ),
                  CustomCard(
                    text: 'Another message here',
                    imagePath: 'lib/assets/man.png',
                    gradientStartColor: Color.fromARGB(201, 255, 231, 153),
                    gradientEndColor: Color(0xFF38A143),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                height: 40,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3, // Adjust count based on the number of pages
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: Color.fromARGB(255, 194, 194, 194),
                      activeDotColor: Color.fromARGB(255, 120, 120, 120)!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Add additional widgets here as needed
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const CustomCard({
    required this.text,
    required this.imagePath,
    required this.gradientStartColor,
    required this.gradientEndColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}
