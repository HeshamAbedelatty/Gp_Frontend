import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/form.dart' as r;

class feild extends StatelessWidget {
  feild(
      {required this.text,
      required this.icon,
      this.controller,
      this.fieldValidator});

  String text;
  Icon icon;
  TextEditingController? controller;
  r.FormFieldValidator<String>? fieldValidator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFA6A5A4), //color for the bottom border
            width: 1.5, // Adjust the width
          ),
        ),
      ),
      child: Column(
        children: [
          // Image.asset('lib/assets/icons/user.png'),

          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: icon, // User icon on the left
              labelText: text,
              border: InputBorder.none, // Remove the default border
            ),
            validator: fieldValidator,
          ),
        ],
      ),
    );
  }
}












//working but only here :
  	// validator: MultiValidator([ 
		// 							RequiredValidator( 
		// 								errorText: 'Enter email address'), 
		// 							EmailValidator( 
		// 								errorText: 
		// 									'Please correct email filled'), 
		// 						]),

// validator: MultiValidator([ 
// 								RequiredValidator( 
// 									errorText: 'Please enter Password'), 
// 								MinLengthValidator(4, 
// 									errorText: 
// 										'Password must be at least 4 digit'), 
// 								// PatternValidator(r'(?=.*?[#!@$%^&*-])', 
// 								// 	errorText: 
// 								// 		'Password must be at least one special character') 
// 							]), 

//             // validator: (data) {
//             //   if (data !="salma")
//             //   {
//             //     return 'value is wrong';
//             //   }
              
//             //},