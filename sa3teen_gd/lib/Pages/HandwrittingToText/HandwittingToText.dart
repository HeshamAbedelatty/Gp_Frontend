// ignore_for_file:depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HandwrittenToTextWidget(),
    );
  }
}

class HandwrittenToTextWidget extends StatefulWidget {
  @override
  _HandwrittenToTextWidgetState createState() => _HandwrittenToTextWidgetState();
}

class _HandwrittenToTextWidgetState extends State<HandwrittenToTextWidget> {
  File? _imageFile;
  final picker = ImagePicker();
  String? _responseText;
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _downloadAsPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(_responseText!),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/converted_text.pdf");
    await file.writeAsBytes(await pdf.save());

    Share.shareFiles([file.path], text: 'Here is your converted text PDF');
  }
  Future<void> _sendImageToBackend(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/extract/'),
      );

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        String cleanedResponse = jsonResponse['response']
            .replaceAll('\n', ' ')
            .replaceAll(RegExp(r'[^\w\s]+'), '');

        setState(() {
          _responseText = cleanedResponse;
        });

        print('Request success with status: ${response.statusCode}');
      } else {
        var responseBody = await response.stream.bytesToString();
        setState(() {
          _responseText =
              'Request failed with status: ${response.statusCode}\nResponse body: $responseBody';
        });
        print('Request failed with status: ${response.statusCode}');
        print('Response body: $responseBody');
      }
    } catch (e) {
      setState(() {
        _responseText = 'Error sending image: $e';
      });
      print('Error sending image: $e');
    }
  }
Future<void> _generateAndDownloadPDF(String responseText) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text(responseText),
      ),
    ),
  );

  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/response.pdf';

  final file = File(path);
  await file.writeAsBytes(await pdf.save());

  // Show a dialog to indicate the file has been saved
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:const Text('PDF Saved'),
      content:const Text('The PDF file has been saved to your device.'),
      actions: <Widget>[
        TextButton(
          child:const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const  Text(
                  'Before:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const  SizedBox(height: 10),
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        width: 350,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 350,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child:const Center(
                          child: Text('No Image Selected'),
                        ),
                      ),
               const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(200, 40),
                  ),
                  onPressed: _pickImage,
                  child:const Text(
                    'Upload Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (_imageFile != null) {
                      await _sendImageToBackend(_imageFile!);
                    } else {
                      print('No image to send.');
                    }
                  },
                  child:const Text(
                    'Convert Image to Text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
               const SizedBox(height: 10),
                _responseText == null
                    ? Container()
                    : Column(
                        children: [
                        const  Text(
                            'After:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        const  SizedBox(height: 10),
                          Container(
                            width: 350,
                            padding:const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              _responseText!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                      const  SizedBox(height: 10,),
                         ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 40),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_responseText != null) {
                      // _generateAndDownloadPDF(_responseText!);
                      _downloadAsPdf();
                    } else {
                      print('No text to generate PDF.');
                    }
                  },
                  child:const Text(
                    'Download as PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                        ],
                      ),
                const SizedBox(height: 20),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}












  // Future<void> _generateAndDownloadPDF() async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Center(
  //           child: pw.Text(_responseText!),
  //         );
  //       },
  //     ),
  //   );
  //   final bytes = await pdf.save();

  //   final blob = Blob([bytes]);
  //   final url = Url.createObjectUrlFromBlob(blob);
  //   AnchorElement(href: url, target: 'self', download: 'response.pdf')
  //     .click();
  //   Url.revokeObjectUrl(url);
  // }

//   Future<void> _generateAndDownloadPDF() async {
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text(_responseText!),
//         );
//       },
//     ),
//   );

//   // Get the document directory using path_provider
//   final directory = await getApplicationDocumentsDirectory();
//   final path = '${directory.path}/response.pdf';

//   // Save the PDF document
//   final file = File(path);
//   await file.writeAsBytes(await pdf.save());

//   // Show a dialog to indicate the file has been saved
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text('PDF Saved'),
//       content: Text('The PDF file has been saved to your device.'),
//       actions: <Widget>[
//         TextButton(
//           child: Text('OK'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     ),
//   );
// }




/////////last working
// import 'dart:io';

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:gp_screen/Pages/GroupPostAndCommentPage/Widgets/tabBar.dart';
// import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:http_parser/http_parser.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HandwrittenToTextWidget(),
//     );
//   }
// }

// class HandwrittenToTextWidget extends StatefulWidget {
//   @override
//   _HandwrittenToTextWidgetState createState() =>
//       _HandwrittenToTextWidgetState();
// }

// class _HandwrittenToTextWidgetState extends State<HandwrittenToTextWidget> {
//   File? _imageFile;
//   final picker = ImagePicker();
//   String? _responseText;
//   File? _selectedFile;
//   String _convertedText = "test text ............"; // Example converted text
//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageFile = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _sendImageToBackend(File imageFile) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('http://10.0.2.2:8000/extract/'),
//       );

//       // Add the image file to the request
//       request.files.add(await http.MultipartFile.fromPath(
//         'image',
//         imageFile.path,
//         contentType: MediaType('image',
//             'jpeg'), // Adjust the content type based on your image type
//       ));

//       // Send the request
//       var response = await request.send();

//       // Check the response
//       if (response.statusCode == 200) {
//         var responseBody = await response.stream.bytesToString();
//         var jsonResponse = jsonDecode(responseBody);

//         // Clean up the response text
//         String cleanedResponse = jsonResponse['response']
//             .replaceAll('\n', ' ')
//             .replaceAll(RegExp(r'[^\w\s]+'), ''); // Remove special characters

//         setState(() {
//           _responseText = cleanedResponse;
//         });

//         print('Request success with status: ${response.statusCode}');
//       } else {
//         var responseBody = await response.stream.bytesToString();
//         setState(() {
//           _responseText =
//               'Request failed with status: ${response.statusCode}\nResponse body: $responseBody';
//         });
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: $responseBody');
//       }
//     } catch (e) {
//       setState(() {
//         _responseText = 'Error sending image: $e';
//       });
//       print('Error sending image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: tabbar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Before:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 _imageFile != null
//                     ? Image.file(
//                         _imageFile!,
//                         width: 350,
//                         height: 250,
//                         fit: BoxFit.cover,
//                       )
//                     : Container(
//                         width: 350,
//                         height: 250,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: Center(
//                           child: Text('No Image Selected'),
//                         ),
//                       ),
//                 // SizedBox(height: 20),

//                 SizedBox(height: 12),

//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: kprimaryColourGreen,
//                     fixedSize: const Size(200, 40),
//                   ),
//                   onPressed: _pickImage,
//                   child: Text(
//                     'Upload Image',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(200, 40),
//                     //  fixedSize: const Size(320, 48),
//                     backgroundColor: kprimaryColourGreen,
//                   ),
//                   onPressed: () async {
//                     if (_imageFile != null) {
//                       await _sendImageToBackend(_imageFile!);
//                     } else {
//                       print('No image to send.');
//                     }
//                   },
//                   child: Text(
//                     'Convert Image to Text',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),

//                 SizedBox(height: 10),

//                 _responseText == null
//                     ? Container()
//                     : Column(
//                         children: [
//                           Text(
//                             'After:',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             width: 350,
//                             padding: EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 5,
//                                   blurRadius: 7,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Text(
//                               _responseText!,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),

//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:http_parser/http_parser.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   File? _imageFile;
//   final picker = ImagePicker();
//   String? _responseText;

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageFile = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _sendImageToBackend(File imageFile) async {
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('http://10.0.2.2:8000/extract/'),
//       );

//       // Add the image file to the request
//       request.files.add(await http.MultipartFile.fromPath(
//         'image',
//         imageFile.path,
//         contentType: MediaType('image', 'jpeg'), // Adjust the content type based on your image type
//       ));

//       // Send the request
//       var response = await request.send();

//       // Check the response
//       if (response.statusCode == 200) {
//         var responseBody = await response.stream.bytesToString();
//         var jsonResponse = jsonDecode(responseBody);

//         // Clean up the response text
//         String cleanedResponse = jsonResponse['response']
//             .replaceAll('\n', ' ')
//             .replaceAll(RegExp(r'[^\w\s]+'), ''); // Remove special characters

//         setState(() {
//           _responseText = cleanedResponse;
//         });

//         print('Request success with status: ${response.statusCode}');
//       } else {
//         var responseBody = await response.stream.bytesToString();
//         setState(() {
//           _responseText = 'Request failed with status: ${response.statusCode}\nResponse body: $responseBody';
//         });
//         print('Request failed with status: ${response.statusCode}');
//         print('Response body: $responseBody');
//       }
//     } catch (e) {
//       setState(() {
//         _responseText = 'Error sending image: $e';
//       });
//       print('Error sending image: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send Image to Backend'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _imageFile == null
//                 ? Text('No image selected.')
//                 : Image.file(_imageFile!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_imageFile != null) {
//                   await _sendImageToBackend(_imageFile!);
//                 } else {
//                   print('No image to send.');
//                 }
//               },
//               child: Text('Send Image to Backend'),
//             ),
//             SizedBox(height: 20),
//             _responseText == null
//                 ? Container()
//                 : Text(
//                     _responseText!,
//                     textAlign: TextAlign.center,
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /////last working 
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http_parser/http_parser.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: HomeScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   File? _imageFile;
// //   final picker = ImagePicker();

// //   Future<void> _pickImage() async {
// //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

// //     setState(() {
// //       if (pickedFile != null) {
// //         _imageFile = File(pickedFile.path);
// //       } else {
// //         print('No image selected.');
// //       }
// //     });
// //   }

// //   Future<dynamic?> _sendImageToBackend(File imageFile) async {
// //     try {
// //       var request = http.MultipartRequest(
// //         'POST',
// //         Uri.parse('http://10.0.2.2:8000/extract/'),
// //       );

// //       // Add the image file to the request
// //       request.files.add(await http.MultipartFile.fromPath(
// //         'image',
// //         imageFile.path,
// //         contentType: MediaType('image', 'jpeg'), // Adjust the content type based on your image type
// //       ));

// //       // Send the request
// //       var response = await request.send();

// //       // Check the response
// //       if (response.statusCode == 200) {
// //         var responseBody = await response.stream.bytesToString();
// //         var jsonResponse = jsonDecode(responseBody);

// //         // Clean up the response text
// //         String cleanedResponse = jsonResponse['response']
// //             .replaceAll('\n', ' ')
// //             .replaceAll(RegExp(r'[^\w\s]+'), ''); // Remove special characters

// //         print('Request success with status: ${response.statusCode}');
// //         return cleanedResponse;
// //       } else {
// //         var responseBody = await response.stream.bytesToString();
// //         print('Request failed with status: ${response.statusCode}');
// //         print('Response body: $responseBody');
// //       }
// //     } catch (e) {
// //       print('Error sending image: $e');
// //     }
// //     return null;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Send Image to Backend'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             _imageFile == null
// //                 ? Text('No image selected.')
// //                 : Image.file(_imageFile!),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: _pickImage,
// //               child: Text('Pick Image'),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 if (_imageFile != null) {
// //                   var response = await _sendImageToBackend(_imageFile!);
// //                   print('Backend response: $response');
// //                 } else {
// //                   print('No image to send.');
// //                 }
// //               },
// //               child: Text('Send Image to Backend'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
