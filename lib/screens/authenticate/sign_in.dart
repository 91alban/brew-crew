import 'package:flutter/material.dart';
import 'package:guru4cars/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In to Brew Crew'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: const Text('Sign In anonymosly'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();

            if (result == null) {
              // ignore: avoid_print
              print('error signing in');
            } else {
              // ignore: avoid_print
              print('signed in');
              // ignore: avoid_print
              print(result);
            }
          },
        ),
      ),
    );
  }
}
