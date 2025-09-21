import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:task/view/loginPage.dart';
import 'package:task/widgets/textFeild.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Box userBox = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textFieldCustom(controller: _usernameController, hintText: "UserName"),
            Gap(16),
            textFieldCustom(controller: _emailController, hintText: "Email"),
            Gap(16),
            textFieldCustom(controller: _passwordController, hintText: "Password",obscureText: true,),
            Gap(20),
            ElevatedButton(
              onPressed: signup,
              child: Text("Sign Up"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
  void signup() {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    // Check if email already exists
    final existingUser = userBox.values.firstWhere(
      (u) => u['email'] == email,
      orElse: () => null,
    );

    if (existingUser != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email already registered")),
      );
      return;
    }

    // Save user to Hive
    final newUser = {
      'username': username,
      'email': email,
      'password': password,
    };

    userBox.add(newUser);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signup successful! Please login.")),
    );

    // Go back to login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }
}
