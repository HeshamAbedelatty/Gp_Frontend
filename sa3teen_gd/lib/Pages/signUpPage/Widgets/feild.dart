import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/form.dart' as r;
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

// ignore: must_be_immutable
class Feild extends StatefulWidget {
  Feild({
    super.key,
    required this.text,
    required this.icon,
    this.controller,
    this.fieldValidator,
    this.isPassword = false,
    this.obscureText = false,
  });

  String text;
  Icon icon;
  TextEditingController? controller;
  r.FormFieldValidator<String>? fieldValidator;
  final bool isPassword;
  bool obscureText = false;
  @override
  State<Feild> createState() => _FeildState();
}

class _FeildState extends State<Feild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        children: [
          // Image.asset('lib/assets/icons/user.png'),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              focusColor: kprimaryColourGreen,
              icon: widget.icon, // User icon on the left
              labelText: widget.text,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFA6A5A4), width: 1.5),
              ), // InputBorder.none, // Remove the default border
              suffixIcon: widget.isPassword && widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                    )
                  : null,
              // focusedBorder: const UnderlineInputBorder(
              //   borderSide: BorderSide(color: Color(0xFF3C8243), width: 1.5),
              // ),
            ),
            validator: widget.fieldValidator,
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