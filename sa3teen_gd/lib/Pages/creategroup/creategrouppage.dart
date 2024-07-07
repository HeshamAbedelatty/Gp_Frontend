// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateGroupPage(),
    );
  }
}

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _groupNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  File? _groupImage;
  final ImagePicker _picker = ImagePicker();
  String _privacy = 'public';
  String? _password;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _groupImage = File(image.path);
      });
    }
  }

  Future<bool> _sendMessageToBackend(
      String title,
      String description,
      String privacy,
      File? image,
      String password,
      String subject,
      String accessToken) async {
    var uri = Uri.parse('http://10.0.2.2:8000/groups/');

    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['description'] = description
      ..fields['type'] = privacy
      ..fields['password'] = password
      ..fields['subject'] = subject;

    // If you need to send an image file
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    // Add the access token to the headers
    request.headers['Authorization'] = 'Bearer $accessToken';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}'); // Log status code
      print('Response body: ${response.body}'); // Log response body

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print('Request success with status: ${response.statusCode}');
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending message: $e');
    }
    return true;
  }

  void _createGroup() {
    String accessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE";
        // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNjE1ODc5LCJpYXQiOjE3MTkzMTk4NzksImp0aSI6IjBlYTlhMWQ1NTVjNDQzNmZiZDYzN2ExZWY5NDU0ZDQ5IiwidXNlcl9pZCI6NX0.j06_cCptq8jr7D9cbiUoVLJWB_OLzD-4ZASLMDJmtdwn';

    final groupName = _groupNameController.text;
    final description = _descriptionController.text;
    final subject = _subjectController.text;
    final groupImage = _groupImage;
    final privacy = _privacy;
    final String? password = _password;
    File? image = groupImage;
    // Handle group creation logic here

    _sendMessageToBackend(groupName, description, privacy, image, '2000',
        subject, accessToken);

    // For demonstration purposes, we'll just print the values
    print('Group Name: $groupName');
    print('Description: $description');
    print('Group Image: $groupImage');
    print('Privacy: $privacy');
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a New Group',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: _groupImage == null
                    ? Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.add_a_photo,
                          color: kprimaryColourcream,
                          size: 50,
                        ),
                      )
                    : Image.file(
                        _groupImage!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _groupNameController,
                decoration:  InputDecoration(
                  labelText: 'Group Name',  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  // border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration:  InputDecoration(
                  labelText: 'Subject',  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  // border: OutlineInputBorder(),
                ),
                // maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration:  InputDecoration(  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  labelText: 'Description',
                  // border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),

              const SizedBox(height: 16),
              if (_privacy == 'private')
                TextFormField(
                  initialValue: _password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
              const SizedBox(height: 10),
              const Text(
                'Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // RadioListTile(
              //   title: const Text('Public'),
              //   value: 'public',
              //   groupValue: _privacy,
              //   onChanged: (value) {
              //     setState(() {
              //       _privacy = value.toString();
              //     });
              //   },
              // ),
              // RadioListTile(
              //   title: const Text('Private'),
              //   value: 'private',
              //   groupValue: _privacy,
              //   onChanged: (value) {
              //     setState(() {
              //       _privacy = value.toString();
              //     });
              //   },
              // ),

              Row(children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Public'),
                    leading: Radio<String>(
                      value: 'public',
                      groupValue: _privacy,
                      onChanged: (value) {
                        setState(() {
                          _privacy = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Private'),
                    leading: Radio<String>(
                      value: 'private',
                      groupValue: _privacy,
                      onChanged: (value) {
                        setState(() {
                          _privacy = value!;
                        });
                      },
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton( style: ElevatedButton.styleFrom(
                        fixedSize: const Size(320, 48),
                        backgroundColor: const Color(
                            0xFF3C8243), // Hex color code for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100.0), // Adjust the border radius as needed
                        ),
                      ),
                  onPressed: _createGroup,
                  child: const Text('Create Group',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





  // Future<dynamic?> _sendMessageToBackend(String title, String description,
  //     String private, File image, String password, String subject) async {
  //   http.Response response = await http.post(
  //     Uri.parse('http://10.0.2.2:8000/groups/'),
  //     body: {
  //       // 'user_text': message

  //       // "id": id,
  //       "title": title,
  //       "description": description,
  //       "type": "private",
  //       "image": null,
  //       "password": "hesham2002",
  //       "subject": "Computer Science",
  //       // "members": 1
  //     },
  //     headers: {
  //       'Content-Type': 'multipart/form-data',
  //     },
  //   );
  //   try {
  //     // print('Sending message to backend: $message'); // Log message

  //     print('Response status: ${response.statusCode}'); // Log status code
  //     print('Response body: ${response.body}'); // Log response body
  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       print('Request success with status: ${response.statusCode}');

  //       // Clean up the response text
  //       String cleanedResponse = jsonResponse['response']
  //           .replaceAll('\n', '\n ')
  //           .replaceAll(RegExp(r"[^a-zA-Z0-9\s.,']"), ''); // Keep ., and '

  //       return cleanedResponse;
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error sending message: $e');
  //   }
  //   return null;
  // }

// Future<dynamic?> _sendMessageToBackend(String title, String description,
//     String privacy, File? image, String password, String subject) async {
//   var uri = Uri.parse('http://10.0.2.2:8000/groups/');
  
//   var request = http.MultipartRequest('POST', uri)
//     ..fields['title'] = title
//     ..fields['description'] = description
//     ..fields['type'] = privacy
//     ..fields['password'] = password
//     ..fields['subject'] = subject;

//   // If you need to send an image file
//   if (image != null) {
//     request.files.add(await http.MultipartFile.fromPath('image', image.path));
//   }

//   try {
//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);

//     print('Response status: ${response.statusCode}'); // Log status code
//     print('Response body: ${response.body}'); // Log response body

//     if (response.statusCode == 200) {
//       var jsonResponse = jsonDecode(response.body);
//       print('Request success with status: ${response.statusCode}');

//       // Clean up the response text
//       // String cleanedResponse = jsonResponse['response']
//       //     .replaceAll('\n', '\n ')
//       //     .replaceAll(RegExp(r"[^a-zA-Z0-9\s.,']"), ''); // Keep ., and '

//       // return cleanedResponse;
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//     }
//   } catch (e) {
//     print('Error sending message: $e');
//   }
//   return null;
// }