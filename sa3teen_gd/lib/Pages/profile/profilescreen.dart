import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/profile/profile.dart';
import 'package:gp_screen/Pages/profile/profileModel.dart';

void main() {
  runApp(ProfileScreen());
}

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
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(profile.image),
        ),
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
      ],
    );
  }
}
