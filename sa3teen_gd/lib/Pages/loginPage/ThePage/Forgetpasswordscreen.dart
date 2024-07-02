import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gp_screen/Pages/signUpPage/Widgets/feild.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static String id = "ForgotPasswordScreen";
  GlobalKey<FormState> formkey = GlobalKey();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColourWhite,
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
                  'Reset your password',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Feild(
              text: 'Email',
              icon: const Icon(Icons.email_outlined),
              controller: emailController,
              fieldValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else {
                  EmailValidator(errorText: 'Please enter a valid email');
                }
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () async {
                      /* if (formkey.currentState!.validate()) {
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var response = await Api_services.resetPassword(
                            emailController.text);
                        await EasyLoading.dismiss();

                        if (response) {
                          print('Password reset email sent');
                          showSnackBar(context,
                              'Password reset email sent. Check your inbox.');
                          emailController.clear();
                          Navigator.pop(context);
                        } else {
                          print('Error sending password reset email');
                          showSnackBar(context,
                              'Error sending password reset email. Please try again.');
                        }
                      }*/
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(320, 48),
                      backgroundColor: const Color(
                          0xFF3C8243), // Hex color code for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100.0), // Adjust the border radius as needed
                      ),
                    ),
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Remember your password?",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Sign In"),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
