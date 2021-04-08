import 'package:bunky_app/screens/home_screen.dart';
import 'package:bunky_app/screens/logIn_screen.dart';
import 'package:bunky_app/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Decoration containerDeco() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(30),
      color: Colors.red[200],
    );
  }

  TextStyle containerTextDeco() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, Home.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(LogInScreen.routeName),
              child: Container(
                width: 200,
                height: 50,
                decoration: containerDeco(),
                child: Center(
                  child: Text(
                    'Login',
                    style: containerTextDeco(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(RegistrationScreen.routeName),
              child: Container(
                width: 200,
                height: 50,
                decoration: containerDeco(),
                child: Center(
                  child: Text(
                    'Register',
                    style: containerTextDeco(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
