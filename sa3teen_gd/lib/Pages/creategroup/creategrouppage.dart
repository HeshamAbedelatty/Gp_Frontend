// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/interentCode&fakeHomePage/vediointernetcodeNotUsing/colors.dart';
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
  final _SubjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _groupImage;
  final ImagePicker _picker = ImagePicker();
  String _privacy = 'public';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _groupImage = File(image.path);
      });
    }
  }

Future<dynamic?> _sendMessageToBackend(String title, String description,
    String privacy, File? image, String password, String subject, String accessToken) async {
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
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending message: $e');
  }
  return null;
}

  void _createGroup() {
    String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNjE1ODc5LCJpYXQiOjE3MTkzMTk4NzksImp0aSI6IjBlYTlhMWQ1NTVjNDQzNmZiZDYzN2ExZWY5NDU0ZDQ5IiwidXNlcl9pZCI6NX0.j06_cCptq8jr7D9cbiUoVLJWB_OLzD-4ZASLMDJmtdwn';

    final groupName = _groupNameController.text;
    final description = _descriptionController.text;
    final groupImage = _groupImage;
    final privacy = _privacy;
    File? image =groupImage;
    final Subject =_SubjectController.text;
    // Handle group creation logic here
    _sendMessageToBackend( groupName, description,
       privacy,  image, '2000', Subject,accessToken) ;
    

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
        padding:const EdgeInsets.all(16.0),
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
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey[800],
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
                decoration:const InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _SubjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(30.0)
                    )),
                
              ),
           const   SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration:const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
             const SizedBox(height: 16),
             const Text(
                'Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                title: const Text('Public'),
                value: 'public',
                groupValue: _privacy,
                onChanged: (value) {
                  setState(() {
                    _privacy = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text('Private'),
                value: 'private',
                groupValue: _privacy,
                onChanged: (value) {
                  setState(() {
                    _privacy = value.toString();
                  });
                },
              ),
             const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    // fixedSize: const Size(200, 40),
                  ),
                  onPressed: _createGroup,
                  child:const Text('Create Group',style: TextStyle(color: Colors.white),),
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