import 'package:flutter/material.dart';
import 'package:sa3teen_gd/widgets/UserModel.dart';

Color KPrimaryColour = Color.fromARGB(255, 248, 247, 242);
Color KPrimaryColourGreen = Color(0xFF3C8243);
Color KPrimaryColourBrown = Color(0xFFA17740);

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

// List to store user data
List<UserModel> users = [];

UserModel user = UserModel(
  firstName: firstNameController.text,
  lastName: lastNameController.text,
  email: emailController.text,
  phoneNumber: phoneNumberController.text,
  password: passwordController.text,
  confirmPassword: confirmPasswordController.text,
);
