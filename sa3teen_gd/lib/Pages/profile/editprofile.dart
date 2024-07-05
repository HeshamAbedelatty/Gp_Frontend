// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/profile/profile.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'profilemodel.dart';
// import 'profileservice.dart'; // Import your profile service

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
  final ProfileService _profileService = ProfileService(); // Initialize your profile service

  @override
  void initState() {
    super.initState();
    // Initialize controllers with profile data
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
      backgroundColor: kprimaryColourWhite,
      appBar: 
      AppBar(backgroundColor: kprimaryColourGreen,
        title: Text('Edit Profile',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
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
            buildTextField(_firstNameController, 'First Name', editable: true),
            SizedBox(height: 20),
            buildTextField(_lastNameController, 'Last Name', editable: true),
            // SizedBox(height: 20),
            // buildTextField(_emailController, 'Email', editable: false),
            SizedBox(height: 20),
            buildTextField(_usernameController, 'Username', editable: true),
            SizedBox(height: 20),
            // buildTextField(_phoneNumberController, 'Phone Number', editable: false),
            // SizedBox(height: 20),
            buildTextField(_facultyController, 'Faculty', editable: true),
            SizedBox(height: 20),
            ElevatedButton(
               style: ElevatedButton.styleFrom(
                          fixedSize: const Size(320, 48),
                          backgroundColor: const Color(
                              0xFF3C8243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
              onPressed: () async {
                ProfileModel updatedProfile = ProfileModel(
                  id: widget.profile.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: widget.profile.email, // Keep email unchanged
                  username: _usernameController.text,
                  phoneNumber: widget.profile.phoneNumber, // Keep phone number unchanged
                  faculty: _facultyController.text,
                  dateOfBirth: widget.profile.dateOfBirth,
                  image: _image?.path ?? widget.profile.image,
                  rate: widget.profile.rate,
                );

                try {
                  await _profileService.updateProfile(
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw', // Replace with actual token
                    updatedProfile,
                  );
                  Navigator.pop(context, updatedProfile);
                } catch (e) {
                  print('Failed to update profile: $e');
                }
              },
              child: Text('Save Changes',style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 15),
            ElevatedButton(
               style: ElevatedButton.styleFrom(
                          fixedSize: const Size(320, 48),
                          backgroundColor: const Color(
                              0xFF3C8243),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
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
              child: Text('Change Profile Picture',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, {required bool editable}) {
    return TextField(
      controller: controller,
      enabled: editable,
      decoration: InputDecoration(
        labelText: label,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(30),
        // ),
     ),
);
}
}

// // ignore_for_file: prefer_final_fields

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/profile/profile.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:image_picker/image_picker.dart';

// import 'profilemodel.dart';

// class EditProfileScreen extends StatefulWidget {
//   final ProfileModel profile;
//   EditProfileScreen({required this.profile});

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   TextEditingController _firstNameController = TextEditingController();
//   TextEditingController _lastNameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _phoneNumberController = TextEditingController();
//   TextEditingController _facultyController = TextEditingController();
//   File? _image;
//   final ProfileService _profileService = ProfileService();

//   @override
//   void initState() {
//     super.initState();
//     _firstNameController.text = widget.profile.firstName;
//     _lastNameController.text = widget.profile.lastName;
//     _emailController.text = widget.profile.email;
//     _usernameController.text = widget.profile.username;
//     _phoneNumberController.text = widget.profile.phoneNumber;
//     _facultyController.text = widget.profile.faculty;
//     // Load the image if available
//     _image = File(widget.profile.image);
//   }

//   Future<void> _getImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: source);

//     setState(() {
//       if (pickedImage != null) {
//         _image = File(pickedImage.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kprimaryColourWhite,
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               if (_image != null)
//                 CircleAvatar(
//                   radius: 80,
//                   backgroundImage: FileImage(_image!),
//                 ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                     labelText: 'First Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(
//                     labelText: 'Last Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _phoneNumberController,
//                 decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _facultyController,
//                 decoration: InputDecoration(
//                     labelText: 'Faculty',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: const Size(320, 48),
//                   backgroundColor: const Color(0xFF3C8243),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(100.0),
//                   ),
//                 ),
//                 onPressed: () async {
//                   ProfileModel updatedProfile = ProfileModel(
//                     id: widget.profile.id,
//                     firstName: _firstNameController.text,
//                     lastName: _lastNameController.text,
//                     email: _emailController.text,
//                     username: _usernameController.text,
//                     phoneNumber: _phoneNumberController.text,
//                     faculty: _facultyController.text,
//                     dateOfBirth: widget.profile.dateOfBirth,
//                     image: _image?.path ?? widget.profile.image,
//                     rate: widget.profile.rate,
//                   );

//                   try {
//                     await _profileService.updateProfile(
//                       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNDY1MjcyLCJpYXQiOjE3MTkxNjkyNzIsImp0aSI6IjljNGRiYzU3MWE4NjRkMmE4MjcyMGFhZjkwMWM3NTRiIiwidXNlcl9pZCI6NX0.OQJa3dfTJq-qYMJYPDziYBrHHYnBcNs9melKysxWyEw', // Replace with actual token
//                       updatedProfile,
//                     );
//                     Navigator.pop(context, updatedProfile);
//                   } catch (e) {
//                     print('Failed to update profile: $e');
//                   }
//                 },
//                 child: const Text('Save Changes',style: TextStyle(color: Colors.white),),
//               ),
//               const SizedBox(height: 15),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: const Size(320, 48),
//                   backgroundColor: const Color(0xFF3C8243),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(100.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: const Text('Select Image Source'),
//                         content: SingleChildScrollView(
//                           child: ListBody(
//                             children: [
//                               GestureDetector(
//                                 child: const Text('Gallery'),
//                                 onTap: () {
//                                   _getImage(ImageSource.gallery);
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               const Padding(padding: EdgeInsets.all(8.0)),
//                               GestureDetector(
//                                 child: const Text('Camera'),
//                                 onTap: () {
//                                   _getImage(ImageSource.camera);
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: const Text('Change Profile Picture',style: TextStyle(color: Colors.white),),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
