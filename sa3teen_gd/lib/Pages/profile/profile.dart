import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ApiHandler.dart';
import 'EditProfileScreen.dart';
import 'User.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _currentUser;
  File? _image;
  final ApiHandler _apiHandler = ApiHandler();

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _loadProfilePhoto();
    _fetchUserData(_currentUser.id);
  }

  Future<void> _fetchUserData(int id) async {
    try {
      Map<String, dynamic> userInfo = await _apiHandler.getUserInfo(id);
      setState(() {
        _currentUser = User(
          id: userInfo['id'],
          firstName: userInfo['first_name'],
          lastName: userInfo['last_name'],
          email: userInfo['email'],
          username: userInfo['username'],
          phoneNumber: userInfo['phone_number'],
          faculty: userInfo['faculty'],
          dateOfBirth: userInfo['date_of_birth'],
          image: userInfo['image'],
          rate: userInfo['rate'],
        );
        if (_currentUser.image != null) {
          _image = File(_currentUser.image!);
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _loadProfilePhoto() async {
    if (_currentUser.image != null) {
      setState(() {
        _image = File(_currentUser.image!);
      });
    } else {
      setState(() {
        _image = File('assets/default.png');
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      try {
        String? imageUrl =
            await _apiHandler.updateProfilePhoto(_currentUser.id, _image!);
        setState(() {
          _currentUser = User(
            id: _currentUser.id,
            firstName: _currentUser.firstName,
            lastName: _currentUser.lastName,
            email: _currentUser.email,
            username: _currentUser.username,
            phoneNumber: _currentUser.phoneNumber,
            faculty: _currentUser.faculty,
            dateOfBirth: _currentUser.dateOfBirth,
            image: imageUrl,
            rate: _currentUser.rate,
          );
        });
      } catch (e) {
        print('Error updating profile photo: $e');
      }
    }
  }

  Future<void> _editProfile() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          user: _currentUser,
          onUpdate: (User) {
            _currentUser.id;
          },
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        _currentUser = updatedUser;
      });
    }
  }

  Widget _buildProfilePhoto() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: _image != null
          ? FileImage(_image!)
          : AssetImage('assets/default.png') as ImageProvider,
      child: InkWell(
        onTap: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          width: 100,
          height: 100,
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${_currentUser.firstName} ${_currentUser.lastName}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Email: ${_currentUser.email}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Username: ${_currentUser.username}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Phone Number: ${_currentUser.phoneNumber}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Faculty: ${_currentUser.faculty}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Date of Birth: ${_currentUser.dateOfBirth ?? 'N/A'}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        Text(
          'Rate: ${_currentUser.rate}',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: _buildProfilePhoto(),
            ),
            SizedBox(height: 20),
            _buildProfileInfo(),
          ],
        ),
      ),
    );
  }
}
