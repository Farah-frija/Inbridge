import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: LoginForm(),
          ),
        );
  }
}
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuillez remplir tous les champs."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (!_isValidEmail(email)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuillez saisir un email valide."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // Ajouter ici la logique d'authentification
    }
  }

  bool _isValidEmail(String email) {
    // Expression régulière pour valider l'email
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/logo.png',
                width: 300.0,
                height: 250.0,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xFFFAFAFA),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color.fromARGB(255, 171, 167, 167)),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xFFFAFAFA),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Color.fromARGB(255, 171, 167, 167)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF758E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Add your logic for forgot password here
              },
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF757575),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }}