import 'package:flutter/material.dart';
import 'package:gp_screen/Services/API_services.dart';
import 'package:gp_screen/Pages/loginPage/ThePage/LoginPage.dart' as login_page;

class Forgetpassword extends StatelessWidget {
  Forgetpassword({Key? key}) : super(key: key);
  Api_services api_services = Api_services();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var response = await api_services.forgetpassword(emailController.text);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: response ? const Text('Check Email') : const Text('Error'),
                      content: response
                          ? Text('Please check ${emailController.text} to proceed.')
                          : const Text('Invalid email, please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                            if (response) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => login_page.LoginPage()),
                              );
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(320, 48),
                backgroundColor: const Color(0xFF3C8243), // Hex color code for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0), // Adjust the border radius as needed
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
