import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TextToSpeechApp extends StatefulWidget {
  @override
  _TextToSpeechAppState createState() => _TextToSpeechAppState();
}

class _TextToSpeechAppState extends State<TextToSpeechApp> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController textEditingController = TextEditingController();
  String ttsText = '';
  double speechRate = 1.0;
  String audioName = '';
  Duration audioDuration = Duration.zero;
  bool audioDownloaded = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('en-US');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: _pickPDF,
                child: Text('Pick PDF'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: textEditingController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        textEditingController.clear();
                        ttsText = '';
                      });
                    },
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    ttsText = text;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _speak();
                },
                child: Text('Convert to Speech'),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text('Speed:'),
                  Slider(
                    value: speechRate,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    label: speechRate.toStringAsFixed(1),
                    onChanged: (newValue) {
                      setState(() {
                        speechRate = newValue;
                      });
                      flutterTts.setSpeechRate(newValue);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _showFileNameDialog();
                },
                child: Text('Download as MP3'),
              ),
              SizedBox(height: 10.0),
              Text(
                audioName.isNotEmpty ? 'Audio: $audioName' : '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                audioDuration != Duration.zero
                    ? 'Duration: ${audioDuration.inSeconds} seconds'
                    : '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              audioDownloaded
                  ? Icon(Icons.check, color: Colors.green)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _speak() async {
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(ttsText);
    await _getAudioInfo(); // Ensure _getAudioInfo is correctly defined and accessible
  }

  Future<void> _showFileNameDialog() async {
    String fileName = '';

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter audio file name'),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
            decoration: InputDecoration(hintText: "Enter file name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
                _downloadSpeech(fileName);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _downloadSpeech(String fileName) async {
    if (fileName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File name cannot be empty'),
        ),
      );
      return;
    }

    try {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      String savePath = '$tempPath/$fileName.mp3';

      await flutterTts.setSpeechRate(speechRate);
      await flutterTts.setPitch(1.0);

      await flutterTts.synthesizeToFile(ttsText, savePath);

      // Move file to downloads directory
      String downloadsDir = (await getDownloadsDirectory())!.path;
      File tempFile = File(savePath);
      String newPath = '$downloadsDir/$fileName.mp3';
      await tempFile.rename(newPath);

      setState(() {
        audioDownloaded = true;
        audioName = '$fileName.mp3';
        audioDuration =
            Duration(seconds: _estimateDuration(ttsText, speechRate));
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Speech downloaded to Downloads folder'),
        ),
      );
    } catch (e) {
      print('Error downloading speech: $e');
    }
  }

  int _estimateDuration(String text, double rate) {
    // Simple estimate: assuming 150 words per minute as average speaking rate
    int wordCount = text.split(' ').length;
    return (wordCount / (rate * 150 / 60)).ceil();
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await _extractTextFromPDF(file);
    }
  }

  Future<void> _extractTextFromPDF(File file) async {
    try {
      // Load the existing PDF document.
      final PdfDocument document =
          PdfDocument(inputBytes: file.readAsBytesSync());

      // Extract text from all the pages.
      String extractedText = PdfTextExtractor(document).extractText();

      setState(() {
        textEditingController.text = extractedText;
        ttsText = extractedText;
      });

      // Dispose the document.
      document.dispose();
    } catch (e) {
      print('Error extracting text from PDF: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future<void> _getAudioInfo() async {
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate processing time
      // For simplicity, setting a default name and duration
      setState(() {
        audioName = 'Speech.mp3';
        audioDuration =
            Duration(seconds: _estimateDuration(ttsText, speechRate));
      });
    } catch (e) {
      print('Error getting audio info: $e');
    }
  }
}
