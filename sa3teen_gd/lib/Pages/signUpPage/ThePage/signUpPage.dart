// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gp_screen/Pages/loginPage/ThePage/LoginPage.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:gp_screen/Pages/signUpPage/UserModel/UserModel.dart';
import 'package:gp_screen/Pages/signUpPage/Widgets/feild.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  // static String id = "SignUpPage";
  static String id = "SignUpPage";

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  GlobalKey<FormState> formkey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // bool validateEmail(String email) {
  //   // Regular expression for the email pattern
  //   final RegExp emailRegex =
  //       RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$");

  //   // Check if the email matches the pattern
  //   return emailRegex.hasMatch(email);
  // }
  bool validateEmail(String email) {
    // Regular expression for the email pattern
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

    // Check if the email matches the pattern
    return emailRegex.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumber) {
    // Regular expression for Egyptian phone numbers
    final RegExp phoneRegex = RegExp(r"^(?:01)(1|2|0|5)[0-9]{8}$");

    // Check if the phone number matches the pattern
    return phoneRegex.hasMatch(phoneNumber);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      // home: Scaffold(
      backgroundColor: kprimaryColourWhite,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            const SizedBox(height: 90),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create An Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C8243),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Feild(
                text: 'First Name',
                icon: const Icon(Icons.person_2_outlined),
                controller: firstNameController,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                }),
            const SizedBox(height: 15),
            Feild(
                text: 'Last Name',
                icon: const Icon(Icons.person_2_outlined),
                controller: lastNameController,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                }),
            const SizedBox(height: 15),
            Feild(
                text: 'UserName',
                icon: const Icon(Icons.person_2_outlined),
                controller: UserNameController,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your UserName';
                  }
                }),
            const SizedBox(height: 15),
            Feild(
                text: 'Email',
                icon: const Icon(Icons.email_outlined),
                controller: emailController,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (value != null) {
                    // print('hi');
                    if (!validateEmail(value)) {
                      return 'Please correct email format';
                    }
                    // EmailValidator(errorText: 'Please correct email filled');
                  }
                }),
            const SizedBox(height: 15),
            Feild(
                text: 'Phone Number',
                icon: const Icon(Icons.phone),
                controller: phoneNumberController,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value != null) {
                    // print('hi');
                    if (!validatePhoneNumber(value)) {
                      return 'Please provide a correct phone number';
                    }
                  }
                }),
            const SizedBox(height: 15),
            Feild(
              text: 'Password',
              icon: const Icon(Icons.lock_outline),
              controller: passwordController,
              obscureText: true,
              isPassword: true,
              fieldValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else {
                  if (value.length < 8) {
                    return 'Your password must be eight characters or more';
                  }
                }
              },
            ),
            const SizedBox(height: 15),
            Feild(
                text: 'Confirm Password',
                icon: const Icon(Icons.password_outlined),
                controller: confirmPasswordController,
                obscureText: true,
                isPassword: true,
                fieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter same password again';
                  } else {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                  }
                }),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      String newEmail = emailController.text;

                      bool userExists =
                          checkIfUserExists(persons, emailController.text);

                      //formkey.currentState != null &&
                      if (formkey.currentState?.validate() ?? false) {
                        // if (formkey.currentState!.validate())
                        // Validate passwords match
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          // Check if the user already exists
                          if (userExists) {
                            // Handle the case where the user already exists
                            print(
                                'User with email ${emailController.text} already exists');
                            showSnackBar(context,
                                'User with email ${emailController.text} already exists');
                            return;
                          } else if (!userExists) {
                            addUser(
                                firstNameController.text,
                                lastNameController.text,
                                UserNameController.text,
                                emailController.text,
                                phoneNumberController.text,
                                passwordController.text,
                                confirmPasswordController.text);
                            for (UserModel user in persons) {
                              print(
                                  'User: ${user.firstName} ${user.lastName} ${user.UserName} (${user.email}) (${user.phoneNumber}) (${user.password})');
                            }
                            // Clear text fields
                            firstNameController.clear();
                            lastNameController.clear();
                            UserNameController.clear();
                            emailController.clear();
                            phoneNumberController.clear();
                            passwordController.clear();
                            confirmPasswordController.clear();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          print('User registered successfully');
                        } else {
                          // show error message
                          print('Passwords do not match');
                          showSnackBar(context, 'Passwords do not match');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(320, 48),
                      backgroundColor: kprimaryColourGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  );
                }),
              ],
            ),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Or Sign Up with', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: const Text("Sign In"),
                ),
              ],
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
