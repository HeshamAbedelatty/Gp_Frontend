import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("lib/assets/icons/profile.jpg"),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      child: Image.asset(
                        "lib/assets/icons/camera.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          "Hala",
          style: Theme.of(context).textTheme.bodyText1!,
        ),
      ],
    );
  }
}
