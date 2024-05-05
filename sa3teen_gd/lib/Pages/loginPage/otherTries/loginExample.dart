import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:form_field_validator/form_field_validator.dart'; 

class Login extends StatefulWidget { 
  static String id ="Login";
const Login({Key? key}) : super(key: key); 

@override 
State<Login> createState() => _LoginState(); 
} 

class _LoginState extends State<Login> { 
Map userData = {}; 
final _formkey = GlobalKey<FormState>(); 
@override 
Widget build(BuildContext context) { 
	return Scaffold( 
	appBar: AppBar( 
		title: const Text('Login'),
		centerTitle: true, 
	), 
	body: SingleChildScrollView( 
		child: Column( 
		children: <Widget>[ 
			Padding( 
			padding: const EdgeInsets.only(top: 30.0), 
			child: Center( 
				child: Container( 
				width: 120, 
				height: 120, 
				decoration: BoxDecoration( 
					borderRadius: BorderRadius.circular(40), 
					border: Border.all(color: Colors.blueGrey)), 
				child: Image.asset('assets/logo.png'), 
				), 
			), 
			), 
			Padding( 
			padding: const EdgeInsets.symmetric(horizontal: 15),
			child: Padding( 
				padding: const EdgeInsets.all(12.0), 
				child: Form( 
					key: _formkey, 
					child: Column( 
						crossAxisAlignment: CrossAxisAlignment.start, 
						children: <Widget>[ 
						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
								validator: MultiValidator([ 
									RequiredValidator( 
										errorText: 'Enter email address'), 
									EmailValidator( 
										errorText: 
											'Please correct email filled'), 
								]), 
								decoration: const InputDecoration(
									hintText: 'Email', 
									labelText: 'Email', 
									prefixIcon: Icon( 
										Icons.email, 
										//color: Colors.green, 
									), 
									errorStyle: TextStyle(fontSize: 18.0), 
									border: OutlineInputBorder( 
										borderSide: 
											BorderSide(color: Colors.red), 
										borderRadius: BorderRadius.all( 
											Radius.circular(9.0)))))), 
						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
							validator: MultiValidator([ 
								RequiredValidator( 
									errorText: 'Please enter Password'), 
								MinLengthValidator(8, 
									errorText: 
										'Password must be atlist 8 digit'), 
								PatternValidator(r'(?=.*?[#!@$%^&*-])', 
									errorText: 
										'Password must be atlist one special character') 
							]), 
							decoration: const InputDecoration( 
								hintText: 'Password', 
								labelText: 'Password', 
								prefixIcon: Icon( 
								Icons.key, 
								color: Colors.green, 
								), 
								errorStyle: TextStyle(fontSize: 18.0), 
								border: OutlineInputBorder( 
									borderSide: BorderSide(color: Colors.red), 
									borderRadius: 
										BorderRadius.all(Radius.circular(9.0))), 
							), 
							), 
						), 
						Container( 
							margin: const EdgeInsets.fromLTRB(180, 0, 0, 0),
							child: const Text('Forget Password!'),
						), 
						Padding( 
							padding: const EdgeInsets.all(28.0), 
							child: ElevatedButton(
								onPressed: () {
								if (_formkey.currentState!.validate()) {
									print('form submiitted');
								}
								},
							                style: ElevatedButton.styleFrom(   fixedSize: const Size(320, 48), backgroundColor: const Color(0xFF3C8243), // Hex color code for the button
							                  shape: RoundedRectangleBorder(
							                    borderRadius: BorderRadius.circular(
							                        100.0), // Adjust the border radius as needed
							                  ),),
								child: const Text(
								'Login',
								style: TextStyle(
									color: Colors.white, fontSize: 22),
								),

							),
						// Center( 
						// 	child: Padding( 
						// 	padding: EdgeInsets.fromLTRB(0, 30, 0, 0), 
						// 	child: Center( 
						// 		child: Text( 
						// 		'Or Sign In Using!', 
						// 		style: TextStyle( 
						// 			fontSize: 18, color: Colors.black), 
						// 		), 
						// 	), 
						// 	), 
						// ), 
						// Row( 
						// 	mainAxisAlignment: MainAxisAlignment.center, 
						// 	children: [ 
						// 	Padding( 
						// 		padding: EdgeInsets.fromLTRB(0, 20, 0, 0), 
						// 		child: Row( 
						// 		children: [ 
						// 			Container( 
						// 				height: 40, 
						// 				width: 40, 
						// 				child: Image.asset( 
						// 				'assets/social.jpg', 
						// 				fit: BoxFit.cover, 
						// 				)), 
						// 			Container( 
						// 			height: 70, 
						// 			width: 70, 
						// 			child: Image.asset( 
						// 				'assets/vishal.png', 
						// 				fit: BoxFit.cover, 
						// 			), 
						// 			), 
						// 			Container( 
						// 			height: 40, 
						// 			width: 40, 
						// 			child: Image.asset( 
						// 				'assets/google.png', 
						// 				fit: BoxFit.cover, 
						// 			), 
						// 			), 
						// 		], 
						// 		), 
						// 	), 
						// 	], 
						// ), 
						// Center( 
						// 	child: Container( 
						// 	padding: EdgeInsets.only(top: 50), 
						// 	child: Text( 
						// 		'SIGN UP!', 
						// 		style: TextStyle( 
						// 		fontSize: 20, 
						// 		fontWeight: FontWeight.w700, 
						// 		color: Colors.lightBlue, 
						// 		), 
						// 	), 
						// 	), 
						// ) 
						// ]), 
				), 
			 
		], 
		), 
	), 
	))]))); 
} 
} 
