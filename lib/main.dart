import 'package:flutter/material.dart';
import 'package:inbridge/login.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}



