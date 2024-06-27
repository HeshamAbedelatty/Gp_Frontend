import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

class HandwrittenToTextWidget extends StatefulWidget {
  @override
  _HandwrittenToTextWidgetState createState() =>
      _HandwrittenToTextWidgetState();
}

class _HandwrittenToTextWidgetState extends State<HandwrittenToTextWidget> {
  File? _selectedFile;
  String _convertedText = "test text ............"; // Example converted text

  void _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
      // You can call your handwriting recognition function here and update _convertedText
    } else {
      // User canceled the picker
    }
  }

  void _convertText() {
    // Placeholder for actual conversion logic
    setState(() {
      _convertedText =
          "Converted text"; // Update this with actual converted text
    });
  }

  Future<void> _downloadAsPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(_convertedText),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/converted_text.pdf");
    await file.writeAsBytes(await pdf.save());

    Share.shareFiles([file.path], text: 'Here is your converted text PDF');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Handwritten to Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Before:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _selectedFile != null
                    ? Image.file(
                        _selectedFile!,
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text('No Image Selected'),
                        ),
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Upload Image'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _convertText,
                  child: Text('Convert'),
                ),
                SizedBox(height: 20),
                Text(
                  'After:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    _convertedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _downloadAsPdf,
                  child: Text('Download as PDF'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
