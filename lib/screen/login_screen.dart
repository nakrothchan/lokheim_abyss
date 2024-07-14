import 'package:flutter/material.dart';
import 'package:lokheim_abyss/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
     AuthService.checkLogin().then((loggedIn){
      if (loggedIn) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
     });
  }

  Future <void> login() async {
    bool loggedIn = await AuthService.login(_email.text, _password.text);
    if (loggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('จงเข้าสู่ระบบ'),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'อีเมล'),
            ),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('เข้าสู่ระบบ'),
            )
          ],
        ),
      ),
    );
  }
}
