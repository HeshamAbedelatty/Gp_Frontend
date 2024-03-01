import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/biuldBorder.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
    required this.hint,
    required this.onSaved,
  });
  final String hint;

  final void Function(String?)? onSaved; //vedio 341

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ??
            true) //lw b null 5od li b3dha 3ala tool li hya true vedio num 341 at7.00m
        {
          return 'feild is required';
        } else {
          return null;
        }
      },
      //maxLines: 5,
      //style: Color(KPrimaryColourBrown),
      onSaved: onSaved,
      cursorColor: KPrimaryColourGreen,
      decoration: InputDecoration(
        enabledBorder: biuldBorder(),
        focusedBorder: biuldBorder(KPrimaryColourGreen),
        hintText: hint, //'Enter task title'
      ),
    );
  }
}
