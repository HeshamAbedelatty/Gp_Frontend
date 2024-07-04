import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/profile/editprofile.dart';
import 'package:gp_screen/Pages/profile/profile.dart';

import 'profilemodel.dart';
// Ensure the path is correct

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> _futureProfile;
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _futureProfile = _profileService.getProfile(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw'); // Make sure to replace with your actual token or get it dynamically
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          backgroundColor: Color.fromRGBO(56, 161, 67, 1),
        ),
        body: Center(
          child: FutureBuilder<ProfileModel>(
            future: _futureProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return buildProfileUI(snapshot.data!);
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProfileUI(ProfileModel profile) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Name: ${profile.firstName} ${profile.lastName}',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          'Username: ${profile.username}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Email: ${profile.email}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Phone Number: ${profile.phoneNumber}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'Faculty: ${profile.faculty}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(profile: profile),
              ),
            );
          },
          child: Text('Edit Profile'),
        ),
      ],
    );
  }
}
