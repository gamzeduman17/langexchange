import 'package:flutter/material.dart';
import 'package:langexchange/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService(); // Düzeltilmiş
  String email = ''; // Varsayılan boş değer
  String password = ''; // Varsayılan boş değer

  void _submit() async {
    var user = await _authService.signUpWithEmail(email, password);
    if (user != null) {
      Navigator.pushNamed(context, '/userInfo');
    } else {
      print('Sign Up Failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth Screen'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => email = value,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            onChanged: (value) => password = value,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(onPressed: _submit, child: Text('Sign Up')), // Eklenen buton: Sign In
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signIn');
            },
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
