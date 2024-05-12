import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class Level {
  final int levelnum;

  Level(this.levelnum);
}

class FacultyLevelDropdown extends StatefulWidget {
  const FacultyLevelDropdown({
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
  _FacultyLevelDropdownstate createState() => _FacultyLevelDropdownstate();
}

class _FacultyLevelDropdownstate extends State<FacultyLevelDropdown> {
  String? _selectedItem;

  List<Level> levels = [
    Level(1),
    Level(2),
    Level(3),
    Level(4),
    Level(5),
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
                  child: SearchField<Level>(
                    suggestions: levels
                        .map(
                          (e) => SearchFieldListItem<Level>(
                            e.levelnum.toString(),
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
                                      e.levelnum.toString(),
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
