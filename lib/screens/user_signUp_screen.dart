import 'package:flutter/material.dart';
import 'package:langexchange/services/auth_service.dart';
import 'package:langexchange/validations/user_signIn_validators.dart';
import 'package:langexchange/screens/user_info_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String username = '';

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      // Kullanıcı kaydı işlemi
      var user = await _authService.signUpWithEmail(email, password);
      if (user != null) {
        // Kullanıcı bilgilerini kaydetme sayfasına yönlendirme
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserInfoScreen()),
        );
      } else {
        print('Sign Up Failed.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) => username = value,
                validator: (value) => Validators.validateUsername(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
                validator: (value) => Validators.validateEmail(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) => Validators.validatePassword(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
