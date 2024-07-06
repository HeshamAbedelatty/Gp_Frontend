// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:provider/provider.dart';
import 'package:gp_screen/Pages/apis/GroupsAPIfinal.dart';

class EditGroupScreen extends StatefulWidget {
  final ListGroupsModel group;

  EditGroupScreen({required this.group});

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _type;
  late String _password;
  late String _subject;

  @override
  void initState() {
    super.initState();
    _title = widget.group.title;
    _description = widget.group.description;
    _type = widget.group.type;
    _password = widget.group.password ?? '';
    _subject = widget.group.subject;
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedData = {
        'title': _title,
        'description': _description,
        'type': _type,
        'password': _password,
        'subject': _subject,
      };

      try {
        await Provider.of<GroupsProvider>(context, listen: false)
            .editGroup(context, widget.group.id, updatedData);
        var f = await Provider.of<GroupsProvider>(context, listen: false)
            .editGroup(context, widget.group.id, updatedData);
        if (f == 403) {
          print(f);
          print(f);
          print(f);
          print(f);
          //             showDialog(
          //   context: context,
          //   builder: (ctx) => AlertDialog(
          //     title: Text('Error '),
          //     // content: Text(responseBody),
          //     actions: <Widget>[
          //       TextButton(
          //         child: Text('Okay'),
          //         onPressed: () {
          //           Navigator.of(ctx).pop();
          //         },
          //       ),
          //     ],
          //   ),
          // );
        }
        Navigator.of(context).pop();
      } catch (error) {
        print('Failed to update group: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Edit Group Page',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: _subject,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a subject';
                  }
                  return null;
                },
                onSaved: (value) {
                  _subject = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (_type == 'private')
                TextFormField(
                  initialValue: _password,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
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
              Row(children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Public'),
                    leading: Radio<String>(
                      value: 'public',
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value!;
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
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // fixedSize: const Size(320, 48),
                  backgroundColor:
                      const Color(0xFF3C8243), // Hex color code for the button
                ),
                onPressed: _saveForm,
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
