import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class Faculty {
  final String name;

  Faculty(this.name);
}

class AwesomeDropdownExample extends StatefulWidget {
  const AwesomeDropdownExample({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  @override
  _AwesomeDropdownExampleState createState() => _AwesomeDropdownExampleState();
}

class _AwesomeDropdownExampleState extends State<AwesomeDropdownExample> {
  String? _selectedItem;

  List<Faculty> faculties = [
    Faculty('Faculty of Medicine - Cairo University'),
    Faculty('Faculty of Medicine - Ain Shams University'),
    Faculty('Faculty of Medicine - Alexandria University'),
    Faculty('Faculty of Engineering - Cairo University'),
    Faculty('Faculty of Engineering - Alexandria University'),
    Faculty('Faculty of Engineering - Ain Shams University'),
    Faculty('Faculty of Commerce - Cairo University'),
    Faculty('Faculty of Commerce - Ain Shams University'),
    Faculty('Faculty of Commerce - Alexandria University'),
    Faculty('Faculty of Law - Cairo University'),
    Faculty('Faculty of Law - Ain Shams University'),
    Faculty('Faculty of Law - Alexandria University'),
    Faculty('Faculty of Pharmacy - Cairo University'),
    Faculty('Faculty of Pharmacy - Alexandria University'),
    Faculty('Faculty of Pharmacy - Ain Shams University'),
    Faculty('Faculty of Science - Cairo University'),
    Faculty('Faculty of Science - Alexandria University'),
    Faculty('Faculty of Science - Ain Shams University'),
    Faculty('Faculty of Agriculture - Cairo University'),
    Faculty('Faculty of Agriculture - Alexandria University'),
    Faculty('Faculty of Agriculture - Ain Shams University'),
    Faculty('Faculty of Dentistry - Cairo University'),
    Faculty('Faculty of Dentistry - Alexandria University'),
    Faculty('Faculty of Dentistry - Ain Shams University'),
    Faculty('Faculty of Education - Cairo University'),
    Faculty('Faculty of Education - Alexandria University'),
    Faculty('Faculty of Education - Ain Shams University'),
    Faculty('Faculty of Veterinary Medicine - Cairo University'),
    Faculty('Faculty of Veterinary Medicine - Alexandria University'),
    Faculty('Faculty of Veterinary Medicine - Beni-Suef University'),
    Faculty('Faculty of Fine Arts - Cairo University'),
    Faculty('Faculty of Fine Arts - Alexandria University'),
    Faculty('Faculty of Fine Arts - Helwan University'),
    Faculty('Faculty of Tourism and Hotels - Helwan University'),
    Faculty('Faculty of Tourism and Hotels - Ain Shams University'),
    Faculty('Faculty of Tourism and Hotels - Alexandria University'),
    Faculty('Faculty of Computers and Information - Cairo University'),
    Faculty('Faculty of Computers and Information - Ain Shams University'),
    Faculty('Faculty of Computers and Information - Alexandria University'),
    Faculty('Faculty of Mass Communication - Cairo University'),
    Faculty('Faculty of Mass Communication - Ain Shams University'),
    Faculty('Faculty of Mass Communication - Alexandria University'),
    Faculty('Faculty of Languages and Translation - Ain Shams University'),
    Faculty('Faculty of Languages and Translation - Cairo University'),
    Faculty('Faculty of Languages and Translation - Alexandria University'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  //margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SearchField<Faculty>(
                    suggestions: faculties
                        .map(
                          (e) => SearchFieldListItem<Faculty>(
                            e.name,
                            item: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    controller: widget.controller,
                    searchInputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      labelText: widget.labelText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(161, 119, 64, 1),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      prefixIcon: Icon(widget.prefixIcon),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
