import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: const Color(0xFFD9D4D0),

      appBar: AppBar(
        title: const Text(
          'Sa3teen Gd',
          style: TextStyle(fontSize: 30),

        ),
        backgroundColor: const Color(0xFFD9D4D0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/smoke-png-image-hot-tea-smoke-115628935603vseugjqx5.png',
                    width: 135,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/teacup.png',
                    width: 260.12,
                    height: 280,
                  ),
                  const Text(
                    "Login To Your Account",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  )                  ],
              ),



              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add your authentication logic here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(269, 45), backgroundColor: primaryColor,
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
              ),





              const SizedBox(height: 10,),
              const Text(" Or Sign in With"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {
                      // Handle Facebook login
                    },
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.table_view_rounded),
                    onPressed: () {
                      // Handle Twitter login
                    },
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.g_translate),
                    onPressed: () {
                      // Handle Google login
                    },
                  ),
                ],
              ),
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?"),
                    SizedBox(width: 5),
                    Text("Sign Up")
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
