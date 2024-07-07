//not the last but there where no pictures
import 'package:flutter/material.dart';

class tabbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + 10); // Adjust height accordingly

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 8),
              CircleAvatar(
                radius: 15,
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Row(
            children: [
              // Add space between search icon and app name
              Text(
                "Sa3teen Gd",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'lobster',
                ),
              ),
              SizedBox(width: 8),
              // Image.asset(
              //   'lib/assets/sa3teenGd.png', // Replace with your search icon image path
              //   height: 50, // Adjust the height as needed
              // ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
      //shadowColor: Color.fromRGBO(0, 0, 0, 0.575),
      backgroundColor: Color.fromRGBO(56, 161, 67, 1),
      flexibleSpace: FlexibleSpaceBar(),
      elevation: 15,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromWidth(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Adjust as per your requirement
        ),
      ),
    );
  }
}
