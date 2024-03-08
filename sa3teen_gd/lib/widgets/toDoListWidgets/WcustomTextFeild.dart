import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/toDoListWidgets/WbiuldBorder.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, ///////////new
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required';
        } else {
          return null;
        }
      },
      cursorColor: KPrimaryColourGreen,
      decoration: InputDecoration(
        enabledBorder: biuldBorder(),
        focusedBorder: biuldBorder(KPrimaryColourGreen),
        hintText: hint,
      ),
    );
  }
}


















///////////////chatttttttttttttttttt
// class CustomTextFeild extends StatelessWidget {
//   const CustomTextFeild({
//     super.key,
//     required this.hint,
//     required this.controller,
//     //required this.onSaved,
    
//   });
//   final String hint;
//   final TextEditingController? controller;
//  // r.FormFieldValidator<String>? fieldValidator;

//  // final void Function(String?)? onSaved; //vedio 341

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       validator: (value) {
//         if (value?.isEmpty ??
//             true) //lw b null 5od li b3dha 3ala tool li hya true vedio num 341 at7.00m
//         {
//           return 'feild is required';
//         } else {
//           return null;
//         }
//       },
//       //maxLines: 5,
//       //style: Color(KPrimaryColourBrown),
//      // onSaved: onSaved,
//       cursorColor: KPrimaryColourGreen,
//       decoration: InputDecoration(
//         enabledBorder: biuldBorder(),
//         focusedBorder: biuldBorder(KPrimaryColourGreen),
//         hintText: hint, //'Enter task title'
//       ),
//     );
//   }
// }
