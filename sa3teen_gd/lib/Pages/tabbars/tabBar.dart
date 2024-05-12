import 'package:flutter/material.dart';

class tabbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 10); // Adjust height accordingly

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/assets/headphone.png', // Replace with your search icon image path
                height: 25, // Adjust the height as needed
              ), // Headphones icon
              SizedBox(
                  width: 8), // Add space between headphones icon and avatar
              CircleAvatar(
                // Replace with user avatar
                radius: 15,
                backgroundImage: AssetImage(
                    'sa3teen_gd/lib/assets/icons/profile.jpg'), // Adjust path
              ),
            ],
          ),
          Row(
            children: [
              // Add space between search icon and app name
              Text(
                "Sa3teen Gd",
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  // fontWeight: FontWeight.bold,
                  fontSize: 25,
                  //fontFamily: 'lobster',
                ),
              ),
              SizedBox(width: 8),
              Image.asset(
                'sa3teen_gd/lib/assets/icons/sa3teenGd.jpg', // Replace with your search icon image path
                height: 50, // Adjust the height as needed
              ),
            ],
          ),
        ],
      ),
      //shadowColor: Color.fromRGBO(0, 0, 0, 0.575),
      backgroundColor: Color.fromRGBO(56, 161, 67, 1),
      flexibleSpace: FlexibleSpaceBar(),
      elevation: 15,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromWidth(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Adjust as per your requirement
        ),
      ),
    );
  }
}
