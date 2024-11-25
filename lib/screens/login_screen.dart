import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'task_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final ParseUser user = ParseUser(emailController.text, passwordController.text, null);
    var response = await user.login();

    if (response.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TaskScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error!.message)));
    }
  }

  Future<void> signUp() async {
    final ParseUser user = ParseUser(emailController.text, passwordController.text, emailController.text);
    var response = await user.signUp();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign-Up Successful! Please Login.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error!.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text('Login')),
            TextButton(onPressed: signUp, child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
