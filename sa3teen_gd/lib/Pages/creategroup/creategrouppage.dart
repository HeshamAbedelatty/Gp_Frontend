import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/ListGroupsModelwithAPIs.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  final _passwordController = TextEditingController();
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

  // Future<bool> _sendMessageToBackend(
  //     String title,
  //     String description,
  //     String privacy,
  //     File? image,
  //     String? password,
  //     String subject,
  //     String accessToken) async {
  //   var uri = Uri.parse('http://10.0.2.2:8000/groups/');

  //   var request = http.MultipartRequest('POST', uri)
  //     ..fields['title'] = title
  //     ..fields['description'] = description
  //     ..fields['type'] = privacy
  //     ..fields['subject'] = subject;

  //   // Conditionally add the password field
  //   if (privacy == 'private' && password != null) {
  //     request.fields['password'] = password;
  //   }

  //   // If you need to send an image file
  //   if (image != null) {
  //     request.files.add(await http.MultipartFile.fromPath('image', image.path));
  //   }

  //   // Add the access token to the headers
  //   request.headers['Authorization'] = 'Bearer $accesstokenfinal';

  //   try {
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     print('Response status: ${response.statusCode}'); // Log status code
  //     print('Response body: ${response.body}'); // Log response body

  //     if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203) {
  //       var jsonResponse = jsonDecode(response.body);
  //       print('Request success with status: ${response.statusCode}');
  //       return true;
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error sending message: $e');
  //     return false;
  //   }
  // }
//   Future<bool> _sendMessageToBackend(
//   String title,
//   String description,
//   String privacy,
//   File? image,
//   String? password,
//   String subject,
//   String accessToken) async {
  
//   var uri = Uri.parse('http://10.0.2.2:8000/groups/');

//   var request = http.MultipartRequest('POST', uri)
//     ..fields['title'] = title
//     ..fields['description'] = description
//     ..fields['type'] = privacy
//     ..fields['subject'] = subject;

//   // Add the password field only if it is not null
//   if (password != null) {
//     request.fields['password'] = password;
//   }

//   // If you need to send an image file
//   if (image != null) {
//     request.files.add(await http.MultipartFile.fromPath('image', image.path));
//   }

//   // Add the access token to the headers
//   request.headers['Authorization'] = 'Bearer $accesstokenfinal';

//   try {
//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);

//     print('Response status: ${response.statusCode}'); // Log status code
//     print('Response body: ${response.body}'); // Log response body

//     if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203) {
//       var jsonResponse = jsonDecode(response.body);
//       print('Request success with status: ${response.statusCode}');
//       return true;
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       return false;
//     }
//   } catch (e) {
//     print('Error sending message: $e');
//   }
//   return false;
// }

Future<bool> _sendMessageToBackend(
  String title,
  String description,
  String privacy,
  File? image,
  String? password,
  String subject,
  String accessToken) async {
  
  var uri = Uri.parse('http://10.0.2.2:8000/groups/');

  var request = http.MultipartRequest('POST', uri)
    ..fields['title'] = title
    ..fields['description'] = description
    ..fields['type'] = privacy
    ..fields['subject'] = subject;

  // Add the password field only if it is not null
  if (password != null) {
    request.fields['password'] = password;
    print('passwordpasswordpassword $password');
  }
  else{
        print('NoooooooooNooooooopasswordpasswordpassword $password');

  }

  // If you need to send an image file
  if (image != null) {
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
  }

  // Add the access token to the headers
  request.headers['Authorization'] = 'Bearer $accesstokenfinal';

  // Print the request details for debugging
  print('Request URL: $uri');
  print('Request fields: ${request.fields}');
  print('Request headers: ${request.headers}');
  print('Request files: ${request.files}');

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203) {
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
  return false;
}


  // Future<void> _createGroup() async {
  //   String accessToken = accesstokenfinal;

  //   final groupName = _groupNameController.text;
  //   final description = _descriptionController.text;
  //   final subject = _subjectController.text;
  //   final groupImage = _groupImage;
  //   final privacy = _privacy;
  //   final String? password = _password;
  //   File? image = groupImage;

  //   // Handle group creation logic here
  //   bool isSuccess = await _sendMessageToBackend(groupName, description, privacy, image, password, subject, accessToken);
  //   print(isSuccess);
  //   if (isSuccess) {
  //     Navigator.pop(context);
  //     Provider.of<ListGroupsProvider>(context, listen: false)
  //         .fetchAllGroups('groups/list_groups/', accesstokenfinal);
  //   }

  //   // For demonstration purposes, we'll just print the values
  //   print('Group Name: $groupName');
  //   print('Description: $description');
  //   print('Group Image: $groupImage');
  //   print('Privacy: $privacy');
  // }
  Future<void> _createGroup() async {
  String accessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE";

  final groupName = _groupNameController.text;
  final description = _descriptionController.text;
  final subject = _subjectController.text;
  final groupImage = _groupImage;
  final privacy = _privacy;
  final String? password = _passwordController.text;
  File? image = groupImage;

  // Handle group creation logic here
  bool isSuccess = await _sendMessageToBackend(groupName, description, privacy, image, password, subject, accessToken);

  if (isSuccess) {
    Navigator.pop(context);
    Provider.of<ListGroupsProvider>(context, listen: false)
        .fetchAllGroups('groups/list_groups/', accesstokenfinal);
  }

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
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              if (_privacy == 'private')
                TextFormField(
                  controller: _passwordController,
                  // initialValue: _password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a password';
                  //   }
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   _password = value!;
                  // },
                ),
              const SizedBox(height: 10),
              const Text(
                'Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
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
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 48),
                    backgroundColor: const Color(0xFF3C8243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  onPressed: _createGroup,
                  child: const Text(
                    'Create Group',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// import 'package:gp_screen/Pages/groups/listofMyGroupsPage_recommendation/modelnewpro.dart';
// import 'package:gp_screen/Services/API_services.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CreateGroupPage(),
//     );
//   }
// }

// class CreateGroupPage extends StatefulWidget {
//   @override
//   _CreateGroupPageState createState() => _CreateGroupPageState();
// }

// class _CreateGroupPageState extends State<CreateGroupPage> {
//   final _groupNameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _subjectController = TextEditingController();
//   File? _groupImage;
//   final ImagePicker _picker = ImagePicker();
//   String _privacy = 'public';
//   String? _password;

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _groupImage = File(image.path);
//       });
//     }
//   }

//   Future<bool> _sendMessageToBackend(
//       String title,
//       String description,
//       String privacy,
//       File? image,
//       String password,
//       String subject,
//       String accessToken) async {
//     var uri = Uri.parse('http://10.0.2.2:8000/groups/');

//     var request = http.MultipartRequest('POST', uri)
//       ..fields['title'] = title
//       ..fields['description'] = description
//       ..fields['type'] = privacy
//       ..fields['password'] = password
//       ..fields['subject'] = subject;

//     // If you need to send an image file
//     if (image != null) {
//       request.files.add(await http.MultipartFile.fromPath('image', image.path));
//     }

//     // Add the access token to the headers
//     request.headers['Authorization'] = 'Bearer $accesstokenfinal';

//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       print('Response status: ${response.statusCode}'); // Log status code
//       print('Response body: ${response.body}'); // Log response body

//       if (response.statusCode == 200 ||response.statusCode == 201||response.statusCode == 203) {
//         var jsonResponse = jsonDecode(response.body);
//         print('Request success with status: ${response.statusCode}');
//         return true;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//     return true;
//   }

//   Future<void> _createGroup() async {
//     String accessToken =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE";

//     final groupName = _groupNameController.text;
//     final description = _descriptionController.text;
//     final subject = _subjectController.text;
//     final groupImage = _groupImage;
//     final privacy = _privacy;
//     final String? password = _password;
//     File? image = groupImage;

//     // Handle group creation logic here
//     bool isSuccess = await _sendMessageToBackend(groupName, description, privacy, image, '2000', subject, accessToken);
// print(isSuccess);
//     if (isSuccess) {
//       Navigator.pop(context);
//        Provider.of<ListGroupsProvider>(context, listen: false)
//         .fetchAllGroups('groups/list_groups/', accesstokenfinal);
//       //  ListGroupsProvider.fetchAllGroups(
//       //                                 widget.url,widget.accessToken,);
//     }

//     // For demonstration purposes, we'll just print the values
//     print('Group Name: $groupName');
//     print('Description: $description');
//     print('Group Image: $groupImage');
//     print('Privacy: $privacy');
//   }

//   @override
//   void dispose() {
//     _groupNameController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Create a New Group',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: _groupImage == null
//                     ? Container(
//                         width: double.infinity,
//                         height: 150,
//                         color: Colors.grey[200],
//                         child: Icon(
//                           Icons.add_a_photo,
//                           color: kprimaryColourcream,
//                           size: 50,
//                         ),
//                       )
//                     : Image.file(
//                         _groupImage!,
//                         width: double.infinity,
//                         height: 150,
//                         fit: BoxFit.cover,
//                       ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _groupNameController,
//                 decoration:  InputDecoration(
//                   labelText: 'Group Name',  border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   // border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _subjectController,
//                 decoration:  InputDecoration(
//                   labelText: 'Subject',  border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   // border: OutlineInputBorder(),
//                 ),
//                 // maxLines: 3,
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: _descriptionController,
//                 decoration:  InputDecoration(  border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   labelText: 'Description',
//                   // border: OutlineInputBorder(),
//                 ),
//                 maxLines: 2,
//               ),

//               const SizedBox(height: 16),
//               if (_privacy == 'private')
//                 TextFormField(
//                   initialValue: _password,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _password = value!;
//                   },
//                 ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Privacy',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),

//               Row(children: [
//                 Expanded(
//                   child: ListTile(
//                     title: const Text('Public'),
//                     leading: Radio<String>(
//                       value: 'public',
//                       groupValue: _privacy,
//                       onChanged: (value) {
//                         setState(() {
//                           _privacy = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListTile(
//                     title: const Text('Private'),
//                     leading: Radio<String>(
//                       value: 'private',
//                       groupValue: _privacy,
//                       onChanged: (value) {
//                         setState(() {
//                           _privacy = value!;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ]),
//               const SizedBox(height: 10),
//               Center(
//                 child: ElevatedButton( style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(320, 48),
//                         backgroundColor: const Color(
//                             0xFF3C8243), // Hex color code for the button
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                               100.0), // Adjust the border radius as needed
//                         ),
//                       ),
//                   onPressed: _createGroup,
//                   child: const Text('Create Group',style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
// // import 'package:gp_screen/Services/API_services.dart';
// // import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: CreateGroupPage(),
// //     );
// //   }
// // }

// // class CreateGroupPage extends StatefulWidget {
// //   @override
// //   _CreateGroupPageState createState() => _CreateGroupPageState();
// // }

// // class _CreateGroupPageState extends State<CreateGroupPage> {
// //   final _groupNameController = TextEditingController();
// //   final _descriptionController = TextEditingController();
// //   final _subjectController = TextEditingController();
// //   File? _groupImage;
// //   final ImagePicker _picker = ImagePicker();
// //   String _privacy = 'public';
// //   String? _password;

// //   Future<void> _pickImage() async {
// //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       setState(() {
// //         _groupImage = File(image.path);
// //       });
// //     }
// //   }

// //   Future<bool> _sendMessageToBackend(
// //       String title,
// //       String description,
// //       String privacy,
// //       File? image,
// //       String password,
// //       String subject,
// //       String accessToken) async {
// //     var uri = Uri.parse('http://10.0.2.2:8000/groups/');

// //     var request = http.MultipartRequest('POST', uri)
// //       ..fields['title'] = title
// //       ..fields['description'] = description
// //       ..fields['type'] = privacy
// //       ..fields['password'] = password
// //       ..fields['subject'] = subject;

// //     // If you need to send an image file
// //     if (image != null) {
// //       request.files.add(await http.MultipartFile.fromPath('image', image.path));
// //     }

// //     // Add the access token to the headers
// //     request.headers['Authorization'] = 'Bearer $accesstokenfinal';

// //     try {
// //       var streamedResponse = await request.send();
// //       var response = await http.Response.fromStream(streamedResponse);

// //       print('Response status: ${response.statusCode}'); // Log status code
// //       print('Response body: ${response.body}'); // Log response body

// //       if (response.statusCode == 200) {
// //         var jsonResponse = jsonDecode(response.body);
// //         print('Request success with status: ${response.statusCode}');
// //         return true;
// //       } else {
// //         print('Request failed with status: ${response.statusCode}');
// //         print('Response body: ${response.body}');
// //         return false;
// //       }
// //     } catch (e) {
// //       print('Error sending message: $e');
// //     }
// //     return true;
// //   }

// //   void _createGroup() {
// //     String accessToken =
// //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIxNTk3MTkzLCJpYXQiOjE3MjAzMDExOTMsImp0aSI6ImFmYjMyMzVhMzRhNzQyODc4YzM4NWE0YTMwNDE0OTYzIiwidXNlcl9pZCI6MjJ9.iDlAypZXseuOu4_F2UR3TaCys0grp_HLTDRRkcjSMIE";
// //         // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwODIzNjc0LCJpYXQiOjE3MTk1Mjc2NzQsImp0aSI6ImRlODZmMmUwM2RiOTRjOGJiOWQ3ZTVlMTZiYTcwYzY3IiwidXNlcl9pZCI6Mn0.ezPy5Xh-ItL9SH3h9REnioVGgn1WKlDtH-y2un_muGU';
// //     // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwNjE1ODc5LCJpYXQiOjE3MTkzMTk4NzksImp0aSI6IjBlYTlhMWQ1NTVjNDQzNmZiZDYzN2ExZWY5NDU0ZDQ5IiwidXNlcl9pZCI6NX0.j06_cCptq8jr7D9cbiUoVLJWB_OLzD-4ZASLMDJmtdwn';

// //     final groupName = _groupNameController.text;
// //     final description = _descriptionController.text;
// //     final subject = _subjectController.text;
// //     final groupImage = _groupImage;
// //     final privacy = _privacy;
// //     final String? password = _password;
// //     File? image = groupImage;
// //     // Handle group creation logic here

// //     _sendMessageToBackend(groupName, description, privacy, image, '2000',
// //         subject, accessToken);

// //     // For demonstration purposes, we'll just print the values
// //     print('Group Name: $groupName');
// //     print('Description: $description');
// //     print('Group Image: $groupImage');
// //     print('Privacy: $privacy');
// //   }

// //   @override
// //   void dispose() {
// //     _groupNameController.dispose();
// //     _descriptionController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: tabbar(),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 'Create a New Group',
// //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //               ),
// //               const SizedBox(height: 16),
// //               GestureDetector(
// //                 onTap: _pickImage,
// //                 child: _groupImage == null
// //                     ? Container(
// //                         width: double.infinity,
// //                         height: 150,
// //                         color: Colors.grey[200],
// //                         child: Icon(
// //                           Icons.add_a_photo,
// //                           color: kprimaryColourcream,
// //                           size: 50,
// //                         ),
// //                       )
// //                     : Image.file(
// //                         _groupImage!,
// //                         width: double.infinity,
// //                         height: 150,
// //                         fit: BoxFit.cover,
// //                       ),
// //               ),
// //               const SizedBox(height: 16),
// //               TextField(
// //                 controller: _groupNameController,
// //                 decoration:  InputDecoration(
// //                   labelText: 'Group Name',  border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                   // border: OutlineInputBorder(),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               TextField(
// //                 controller: _subjectController,
// //                 decoration:  InputDecoration(
// //                   labelText: 'Subject',  border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                   // border: OutlineInputBorder(),
// //                 ),
// //                 // maxLines: 3,
// //               ),
// //               const SizedBox(height: 16),
// //               TextField(
// //                 controller: _descriptionController,
// //                 decoration:  InputDecoration(  border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                   labelText: 'Description',
// //                   // border: OutlineInputBorder(),
// //                 ),
// //                 maxLines: 2,
// //               ),

// //               const SizedBox(height: 16),
// //               if (_privacy == 'private')
// //                 TextFormField(
// //                   initialValue: _password,
// //                   decoration: InputDecoration(
// //                     labelText: 'Password',
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(30),
// //                     ),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter a password';
// //                     }
// //                     return null;
// //                   },
// //                   onSaved: (value) {
// //                     _password = value!;
// //                   },
// //                 ),
// //               const SizedBox(height: 10),
// //               const Text(
// //                 'Privacy',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),

// //               Row(children: [
// //                 Expanded(
// //                   child: ListTile(
// //                     title: const Text('Public'),
// //                     leading: Radio<String>(
// //                       value: 'public',
// //                       groupValue: _privacy,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           _privacy = value!;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: ListTile(
// //                     title: const Text('Private'),
// //                     leading: Radio<String>(
// //                       value: 'private',
// //                       groupValue: _privacy,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           _privacy = value!;
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ]),
// //               const SizedBox(height: 10),
// //               Center(
// //                 child: ElevatedButton( style: ElevatedButton.styleFrom(
// //                         fixedSize: const Size(320, 48),
// //                         backgroundColor: const Color(
// //                             0xFF3C8243), // Hex color code for the button
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(
// //                               100.0), // Adjust the border radius as needed
// //                         ),
// //                       ),
// //                   onPressed: _createGroup,
// //                   child: const Text('Create Group',style: TextStyle(color: Colors.white),),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
