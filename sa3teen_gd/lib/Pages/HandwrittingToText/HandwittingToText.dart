// ignore_for_file:depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for Clipboard
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:share/share.dart';


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
  _HandwrittenToTextWidgetState createState() =>
      _HandwrittenToTextWidgetState();
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
        Uri.parse('https://aisa3teengd.azurewebsites.net/extract/'),
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
            .replaceAll('\n', '\n ')
            .replaceAll(RegExp(r"[^a-zA-Z0-9\s.,':]"), ''); // Keep ., and '

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
        title: const Text('PDF Saved'),
        content: const Text('The PDF file has been saved to your device.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
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
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Before:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                        child: const Center(
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
                  child: const Text(
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
                  child: const Text(
                    'Convert Image to Text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                _responseText == null
                    ? Container()
                    : Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'After:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 350,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SelectableText(
                              _responseText!,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 40),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              if (_responseText != null) {
                                _downloadAsPdf();
                              } else {
                                print('No text to generate PDF.');
                              }
                            },
                            child: const Text(
                              'Download as PDF',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 10),
                         
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(200, 40),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              if (_responseText != null) {
                                _copyToClipboard(_responseText!);
                              } else {
                                print('No text to copy.');
                              }
                            },
                            child: const Text(
                              'Copy All',
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