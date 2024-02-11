import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sa3teen_gd/Pages/LoginPage.dart';
import 'package:sa3teen_gd/widgets/UserModel.dart';
import 'package:sa3teen_gd/widgets/constants.dart';
import 'package:sa3teen_gd/widgets/feild.dart';

class signUpPage extends StatefulWidget {
  signUpPage();

  static String id = "SignUpPage";

  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
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

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: KPrimaryColour,
        body: Form(
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
              feild(
                  text: 'First Name',
                  icon: const Icon(Icons.person_2_outlined),
                  controller: firstNameController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                  }),
              const SizedBox(height: 15),
              feild(
                  text: 'Last Name',
                  icon: const Icon(Icons.person_2_outlined),
                  controller: lastNameController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                  }),
              const SizedBox(height: 15),
              feild(
                  text: 'Email',
                  icon: const Icon(Icons.email_outlined),
                  controller: emailController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (value != null) {
                      print('hi');

                      EmailValidator(errorText: 'Please correct email filled');
                    }
                  }),
              const SizedBox(height: 15),
              feild(
                  text: 'Phone Number',
                  icon: const Icon(Icons.phone),
                  controller: phoneNumberController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                  }),
              const SizedBox(height: 15),
              feild(
                  text: 'Password',
                  icon: const Icon(Icons.lock_outline),
                  controller: passwordController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      MinLengthValidator(4,
                          errorText: 'Password must be at least 4 digit');
                    }
                  }),
              const SizedBox(height: 15),
              feild(
                  text: 'Confirm Password',
                  icon: const Icon(Icons.password_outlined),
                  controller: confirmPasswordController,
                  fieldValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter same password again';
                    }
                  }),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        String newEmail = emailController.text;

                        bool userExists =
                            checkIfUserExists(persons, emailController.text);

                        //formkey.currentState != null &&
                        // if (formkey.currentState?.validate() ?? false) {
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
                                emailController.text,
                                phoneNumberController.text,
                                passwordController.text,
                                confirmPasswordController.text);
                            for (UserModel user in persons) {
                              print(
                                  'User: ${user.firstName} ${user.lastName} (${user.email}) (${user.phoneNumber}) (${user.password})');
                            }
                            // Clear text fields
                            firstNameController.clear();
                            lastNameController.clear();
                            emailController.clear();
                            phoneNumberController.clear();
                            passwordController.clear();
                            confirmPasswordController.clear();
                          }
                          Navigator.push(
                              context,
                               MaterialPageRoute(
                                  builder: (context) => new LoginPage()));
                          print('User registered successfully');
                        } else {
                          // show error message
                          print('Passwords do not match');
                          showSnackBar(context, 'Passwords do not match');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(320, 48),
                        primary: Color(0xFF3C8243),
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
      ),
    );
  }
}
