import 'package:flutter/material.dart';

class BirthdayFormField extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;

  const BirthdayFormField({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.labelText,
  }) : super(key: key);

  @override
  _BirthdayFormFieldState createState() => _BirthdayFormFieldState();
}

class _BirthdayFormFieldState extends State<BirthdayFormField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Set initial date to today's date
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        widget.controller.text =
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
      });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Birthday Form Field Example'),
      ),
      body: Center(
        child: BirthdayFormField(
          controller: TextEditingController(),
          prefixIcon: Icons.calendar_today,
          labelText: 'Birthday',
        ),
      ),
    ),
  ));
}
