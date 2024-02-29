import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sa3teen_gd/Pages/homePage.dart';
import 'package:sa3teen_gd/Pages/signUpPage/signUpPage.dart';
import 'package:sa3teen_gd/widgets/signUp_LoginWidgets/UserModel.dart';
import 'package:sa3teen_gd/widgets/constantsAcrossTheApp/constants.dart';
import 'package:sa3teen_gd/widgets/signUp_LoginWidgets/feild.dart';
//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  LoginPage();

  static String id = "LoginPage";
  GlobalKey<FormState> formkey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: KPrimaryColour,
          body: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(height: 60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sa3teen Gd',
                      style: TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/icons/treeCupAltered.png',
                      width: 280,
                      height: 280,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                feild(
                    text: 'Email',
                    icon: Icon(Icons.email_outlined),
                    controller: emailController,
                    fieldValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (value != null) {
                        print('hi');

                        EmailValidator(
                            errorText: 'Please correct email filled');
                      }
                    }),
                const SizedBox(height: 15),
                feild(
                    text: 'Password',
                    icon: Icon(Icons.lock_outline),
                    controller: passwordController,
                    fieldValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        MinLengthValidator(4,
                            errorText: 'Password must be at least 4 digit');
                      }
                    }),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          //sign-up logic
                          bool passwordCorrect = checkIfPasswordRight(
                              persons, passwordController.text);
                          bool userExists =
                              checkIfUserExists(persons, emailController.text);

                          if (formkey.currentState!.validate()) {
                            if (userExists) {
                              if (passwordCorrect) {
                                print('sucssesfully logged in');
                                showSnackBar(context, 'sucssesfully logged in');
                                // Clear text fields
                                emailController.clear();
                                passwordController.clear();
                                //Navigator.pushNamed(context, homePage.id);
                                Navigator.push(
                                    context,
                                     MaterialPageRoute(
                                        builder: (context) => new homePage()));
                                return;
                              } else {
                                print('wrong password try again');

                                showSnackBar(context,
                                    'Wrong password. Please try again.');
                              }
                              // Handle the case where the user not exists
                            } else if (!userExists) {
                              print('user is not existed before');
                              showSnackBar(
                                  context, 'user is not existed before');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(320, 48),
                          primary: const Color(
                              0xFF3C8243), // Hex color code for the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text('Sign In'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Or Sign In with',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.facebook,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    Image.asset(
                      'lib/assets/icons/843776_google_icon.png',
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                    Image.asset(
                      'lib/assets/icons/twitter.png',
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, signUpPage.id);
                        },
                        child: const Text("Sign Up")),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

 // // Method to handle retrieving UserModel and using it
  // void handleUserModel(BuildContext context) {
  //   // Retrieve UserModel object passed from SignUpPage
  //   final UserModel? user =
  //       ModalRoute.of(context)?.settings.arguments as UserModel?;
  // }
  // String newEmail = emailController.text;

// ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Processing Data')),
//       );

//kano fo2
  // void showSnackBar(String message) {
  //   scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));

// void showSnackBar(String message) {
//     if (scaffoldKey.currentState != null) {
//       scaffoldKey.currentState!.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ));
//     }
//   }

//         onSaved: (value) {
                      //   emailController = value;
                      // };


                      // final a = 'wrong password try again';
                              // final SnackBarr = SnackBar(content: Text(a));
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBarr);
                              //showSnackBar('Wrong password. Please try again.');