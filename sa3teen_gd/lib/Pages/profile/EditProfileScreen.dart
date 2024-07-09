import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ApiHandler.dart';
import 'User.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  final Function(User) onUpdate;

  EditProfileScreen({required this.user, required this.onUpdate});

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
  TextEditingController _dateOfBirthController = TextEditingController();
  File? _image;
  final ApiHandler _apiHandler = ApiHandler();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _emailController.text = widget.user.email;
    _usernameController.text = widget.user.username;
    _phoneNumberController.text = widget.user.phoneNumber;
    _facultyController.text = widget.user.faculty!;///////////
    _dateOfBirthController.text = widget.user.dateOfBirth ?? '';
    if (widget.user.image != null) {
      _image = File(widget.user.image!);
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        id: widget.user.id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        username: _usernameController.text,
        phoneNumber: _phoneNumberController.text,
        faculty: _facultyController.text,
        dateOfBirth: _dateOfBirthController.text,
        image: widget.user.image,
        rate: widget.user.rate,
      );

      try {
        await _apiHandler.updateUser(widget.user.id, {
          'first_name': updatedUser.firstName,
          'last_name': updatedUser.lastName,
          'email': updatedUser.email,
          'username': updatedUser.username,
          'phone_number': updatedUser.phoneNumber,
          'faculty': updatedUser.faculty,
          'date_of_birth': updatedUser.dateOfBirth,
        });

        if (_image != null) {
          String? imageUrl =
              await _apiHandler.updateProfilePhoto(widget.user.id, _image!);
          updatedUser.image = imageUrl;
        }

        widget.onUpdate(updatedUser);
        Navigator.pop(context, updatedUser);
      } catch (e) {
        print('Error updating user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _updateUser,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
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
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _facultyController,
                decoration: InputDecoration(labelText: 'Faculty'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter faculty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter date of birth';
                //   }
                //   return null;
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
