import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/profile/profile.dart';
import 'package:image_picker/image_picker.dart';

import 'profilemodel.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;
  EditProfileScreen({required this.profile});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  File? _image;
  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.profile.firstName;
    _lastNameController.text = widget.profile.lastName;
    _emailController.text = widget.profile.email;
    _usernameController.text = widget.profile.username;
    _phoneNumberController.text = widget.profile.phoneNumber;
    _facultyController.text = widget.profile.faculty;
    // Load the image if available
    _image = File(widget.profile.image);
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_image != null)
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(_image!),
                ),
              SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _facultyController,
                decoration: InputDecoration(labelText: 'Faculty'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  ProfileModel updatedProfile = ProfileModel(
                    id: widget.profile.id,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    username: _usernameController.text,
                    phoneNumber: _phoneNumberController.text,
                    faculty: _facultyController.text,
                    dateOfBirth: widget.profile.dateOfBirth,
                    image: _image?.path ?? widget.profile.image,
                    rate: widget.profile.rate,
                  );

                  try {
                    await _profileService.updateProfile(
                      'your_access_token_here', // Replace with actual token
                      updatedProfile,
                    );
                    Navigator.pop(context, updatedProfile);
                  } catch (e) {
                    print('Failed to update profile: $e');
                  }
                },
                child: Text('Save Changes'),
              ),
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
                                  _getImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: Text('Camera'),
                                onTap: () {
                                  _getImage(ImageSource.camera);
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
                child: Text('Change Profile Picture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
