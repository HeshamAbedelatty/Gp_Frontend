import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _groupNameController = TextEditingController();
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

  void _createGroup() {
    // Handle group creation logic here
    final groupName = _groupNameController.text;
    final description = _descriptionController.text;
    final groupImage = _groupImage;
    final privacy = _privacy;

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
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a New Group',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Text(
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
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _createGroup,
                  child: Text('Create Group'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
