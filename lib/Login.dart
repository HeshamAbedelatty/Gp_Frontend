import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sa3teen Gd',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
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
                    Text("Login To Your Account", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),



              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add your authentication logic here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                },
                child: Text('Sign In'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook),
                    onPressed: () {
                      // Handle Facebook login
                    },
                  ),
                  SizedBox(width: 40),
                  IconButton(
                    icon: Icon(Icons.table_view_rounded),
                    onPressed: () {
                      // Handle Twitter login
                    },
                  ),
                  SizedBox(width: 40),
                  IconButton(
                    icon: Icon(Icons.g_translate),
                    onPressed: () {
                      // Handle Google login
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
