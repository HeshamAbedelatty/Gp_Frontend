import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/profile/editprofile.dart';
import 'package:gp_screen/Pages/profile/profile.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'profilemodel.dart';

class FieldName extends StatelessWidget {
  const FieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> _futureProfile;
  final ProfileService _profileService = ProfileService();
  String getimageUrl(profile) {
    return profile.imageUrl;
  }
  @override
  void initState() {
    super.initState();
    _futureProfile = _profileService.getProfile(
'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNzc4Mjk1LCJpYXQiOjE3MjA0ODIyOTUsImp0aSI6IjczMDJlZDg3NGVhNTQyOWY4ZTFlNTIzMzE5ZWZiZGQzIiwidXNlcl9pZCI6Mjd9.t2izweROe6r67NLE-MMJTbQTsrLjruJPhLh41Lo3myg'); // Make sure to replace with your actual token or get it dynamically
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<ProfileModel>(
            future: _futureProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return buildProfileUI(snapshot.data!);
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProfileUI(ProfileModel profile) {
    return Scaffold(
      appBar:tabbar(profileImageUrl: profile.image,) ,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(profile.image),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Card(
                color: kprimaryColourWhite,
                // elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldName(
                                text: 'Name',
                              ),
                              Text('${profile.firstName} ${profile.lastName}',
                                  style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.account_circle, size: 30),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldName(
                                text: 'Username',
                              ),
                              Text(profile.username,
                                  style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldName(
                                text: 'Rate',
                              ),
                              Text(profile.rate.toString(),
                                  style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.email, size: 30),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldName(
                                text: 'Email',
                              ),
                              Text(profile.email,
                                  style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldName(text: 'Phone Number',),
                              Text(profile.phoneNumber,
                                  style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.school, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(profile.faculty ?? 'N/A', style: const TextStyle(fontSize: 22)),

                              // const FieldName(text: 'Faculty',),
                              // Text(profile.faculty,
                              //     style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const ProfileMenuDivider(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.cake, size: 30),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profile.dateOfBirth ?? 'Not provided', style: const TextStyle(fontSize: 22)),
                              // const FieldName(text: 'Birthday',),
                              // Text(profile.dateOfBirth ?? 'Not provided',
                                  // style: const TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                          fixedSize: const Size(320, 48),
                          backgroundColor: const Color(
                              0xFF3C8243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(profile: profile),
                    ),
                  );
                },
                child: const Text('Edit Profile', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 20),
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const Divider(
        height: 2,
        color: Color.fromRGBO(161, 119, 64, 1),
        thickness: 0.5,
     ),
);
}
}

// // ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/profile/editprofile.dart';
// import 'package:gp_screen/Pages/profile/profile.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'profilemodel.dart';

// class FieldName extends StatelessWidget {
//   const FieldName({
//     Key? key,
//     required this.text,
//   }) : super(key: key);

//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 18.0, // Set the font size
//             color: Colors.black87, // Set the font color
//             fontWeight: FontWeight.bold, // Set the font weight
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   late Future<ProfileModel> _futureProfile;
//   final ProfileService _profileService = ProfileService();

//   @override
//   void initState() {
//     super.initState();
//     _futureProfile = _profileService.getProfile(
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'); // Make sure to replace with your actual token or get it dynamically
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'User Profile',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 25.0,
//             ),
//           ),
//           backgroundColor: const Color.fromRGBO(56, 161, 67, 1),
//         ),
//         body: Center(
//           child: FutureBuilder<ProfileModel>(
//             future: _futureProfile,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 return buildProfileUI(snapshot.data!);
//               } else {
//                 return const Text('No data available');
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProfileUI(ProfileModel profile) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const SizedBox(height: 10),
//           Center(
//             child: CircleAvatar(
//               radius: 75,
//               backgroundImage: NetworkImage(profile.image),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.all(7.0),
//             child: Card(
//               color: kprimaryColourWhite,
//               elevation: 8,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     // FieldName(text: 'Name',),
//                     Row(
//                       children: [
//                         const Icon(Icons.person, size: 30),
//                         const SizedBox(width: 20),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const FieldName(
//                               text: 'Name',
//                             ),
//                             Text('${profile.firstName} ${profile.lastName}',
//                                 style: const TextStyle(fontSize: 22)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     const ProfileMenuDivider(),
//                     const SizedBox(height: 12),

//                     Row(
//                       children: [
//                         const Icon(Icons.account_circle, size: 30),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const FieldName(
//                               text: 'username',
//                             ),
//                             const SizedBox(width: 20),
//                             Text(profile.username,
//                                 style: const TextStyle(fontSize: 22))
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     const ProfileMenuDivider(),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(Icons.email, size: 30),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const FieldName(
//                               text: 'Email',
//                             ),
//                             Text(profile.email,
//                                 style: const TextStyle(fontSize: 22)),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const ProfileMenuDivider(),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(Icons.phone, size: 30),
//                         const SizedBox(width: 20),
//                         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                              const FieldName(text: 'Phone Number',),
//                             Text(profile.phoneNumber,
//                                 style: const TextStyle(fontSize: 22)),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const ProfileMenuDivider(),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(Icons.school, size: 30),
//                         const SizedBox(width: 20),
//                         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                              const FieldName(text: 'Faculty',),
//                             Text(profile.faculty,
//                                 style: const TextStyle(fontSize: 22)),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(320, 48),
//                         backgroundColor: const Color(
//                             0xFF3C8243), // Hex color code for the button
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                               100.0), // Adjust the border radius as needed
//                         ),
//                       ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => EditProfileScreen(profile: profile),
//                   ),
//                 );
//               },
//               child: const Text('Edit Profile',style: TextStyle(color: Colors.white),),
//             ),
            
//           ),
//           const SizedBox(height: 20,)
//         ],
//       ),
//     );
//   }
// }

// class ProfileMenuDivider extends StatelessWidget {
//   const ProfileMenuDivider({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin:
//           const EdgeInsets.symmetric(horizontal: 20), // Adjust margin as needed
//       child: const Divider(
//         height: 2,
//         color: Color.fromRGBO(161, 119, 64, 1), // Brown color for the divider
//         thickness: 0.5, // Smaller thickness of the divider
//       ),
//     );
//   }
// }
