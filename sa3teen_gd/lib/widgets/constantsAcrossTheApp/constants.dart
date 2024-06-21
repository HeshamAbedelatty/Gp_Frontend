// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/signUpPage/UserModel/UserModel.dart';

const Color kprimaryColourWhite = const Color.fromARGB(255, 248, 247, 242);
const Color kprimaryColourGreen = const Color(0xFF3C8243);
const Color kprimaryColourBrown = const Color(0xFFA17740);
const Color kprimaryColourcream = Color.fromARGB(255, 207, 185, 157);

String ktask = "task";
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController UserNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

// TextEditingController taskNameController = TextEditingController();
// TextEditingController idController = TextEditingController();
// TextEditingController dateController = TextEditingController();
// TextEditingController priorityController = TextEditingController();

// TextEditingController colorController = TextEditingController();
// TextEditingController isDoneController = TextEditingController();

// List to store user data
List<UserModel> users = [];

UserModel user = UserModel(
  firstName: firstNameController.text,
  lastName: lastNameController.text,
  UserName: UserNameController.text,
  email: emailController.text,
  phoneNumber: phoneNumberController.text,
  password: passwordController.text,
  confirmPassword: confirmPasswordController.text,
);
