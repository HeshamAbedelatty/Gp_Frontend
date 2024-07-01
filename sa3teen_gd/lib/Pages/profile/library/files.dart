import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/tabbars/tabBar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// Adjust the path as per your project structure

class FilePickerHomePage extends StatefulWidget {
  @override
  _FilePickerHomePageState createState() => _FilePickerHomePageState();
}

class _FilePickerHomePageState extends State<FilePickerHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PlatformFile> _files = [];
  List<PlatformFile> _filteredFiles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_filterFiles);
    _loadFiles();
  }

  void _pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      _files.addAll(result.files);
      _filterFiles();
    }
  }

  void _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> entities = directory.listSync();

    setState(() {
      _files = entities.whereType<File>().map((file) {
        return PlatformFile(
          name: file.uri.pathSegments.last,
          path: file.path,
          size: file.lengthSync(),
        );
      }).toList();
      _filterFiles();
    });
  }

  void _filterFiles() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _filteredFiles = _files;
          break;
        case 1:
          _filteredFiles = _files
              .where((file) => file.name.toLowerCase().endsWith('.pdf'))
              .toList();
          break;
        case 2:
          _filteredFiles = _files.where((file) {
            final extension = file.name.split('.').last.toLowerCase();
            return ['png', 'jpg', 'jpeg', 'gif', 'bmp'].contains(extension);
          }).toList();
          break;
        case 3:
          _filteredFiles = _files.where((file) {
            final extension = file.name.split('.').last.toLowerCase();
            return ['xls', 'xlsx'].contains(extension);
          }).toList();
          break;
        default:
          _filteredFiles = _files;
      }
    });
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          tabbar(), // Your existing tabbar widget as an action
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All', icon: Icon(Icons.filter_none)),
            Tab(text: 'PDF', icon: Icon(Icons.picture_as_pdf)),
            Tab(text: 'Images', icon: Icon(Icons.image)),
            Tab(text: 'Excel', icon: Icon(Icons.table_chart)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(4, (index) => _buildFileListView(index)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFiles,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFileListView(int index) {
    return _filteredFiles.isEmpty
        ? Center(child: Text('No files found'))
        : ListView.builder(
            itemCount: _filteredFiles.length,
            itemBuilder: (context, idx) {
              if (idx < 0 || idx >= _filteredFiles.length) {
                // Guard against invalid indices
                print('Invalid index access attempt: $idx');
                return SizedBox
                    .shrink(); // Return an empty widget for invalid indices
              }

              final file = _filteredFiles[idx];
              return ListTile(
                leading: Icon(_getIconForFile(file)),
                title: Text(file.name),
                onTap: () => viewFile(file),
              );
            },
          );
  }

  IconData _getIconForFile(PlatformFile file) {
    String extension = file.name.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'bmp':
        return Icons.image;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file; // Default icon for unknown file types
    }
  }
}

// Example tabbar widget, replace with your actual implementation
