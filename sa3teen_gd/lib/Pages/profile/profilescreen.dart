import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/profile/profile.dart';
import 'package:gp_screen/Pages/profile/profileModel.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';
import 'package:image_picker/image_picker.dart';

import '../More_page/EditPage/EditProfilePage';

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
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    _futureProfile = _profileService.getProfile(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw');
  }

  Future<void> _editPhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        // Handle the selected image
        // For example, you can upload it to a server or update the profile model
      });
    }
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: tabbar(),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                if (_image != null)
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(_image!),
                  )
                else if (profile.image != null)
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(profile.image),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Image Source'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                GestureDetector(
                                  child: Text('Gallery'),
                                  onTap: () {
                                    _editPhoto(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  child: Text('Camera'),
                                  onTap: () {
                                    _editPhoto(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Change Photo',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
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
              SizedBox(height: 20),
            ],
          ),
          Center(
            child: SizedBox(
              width: double
                  .infinity, // Make button take the full width of the screen
              child: ElevatedButton(
                onPressed: _navigateToEditProfile,
                child: Text(
                  'Edit Profile',
                  style:
                      TextStyle(color: Colors.white), // Set font color to white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Set background color to teal
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
