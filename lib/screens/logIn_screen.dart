import 'package:bunky_app/constants/custom_text_field.dart';
import 'package:flutter/material.dart';
import './home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  static String _email;
  static String _password;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  void _validateLoginInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      } catch (e) {
        switch (e.code) {
          case 'ERROR_USER_NOT_FOUND':
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    child: Text(e),
                  ),
                );
              },
            );
            break;
          case 'ERROR_WRONG_PASSWORD':
            {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(e),
                    ),
                  );
                },
              );
              break;
            }
        }
      }
    } else {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Column(
          children: [
            CustomTextField(
              onSaved: (input) {
                _email = input;
              },
              validator: emailValidator,
              icon: Icon(Icons.email),
              hint: 'EMAIL',
            ),
            CustomTextField(
              icon: Icon(Icons.lock),
              obsecure: true,
              onSaved: (input) => _password = input,
              validator: (input) => input.isEmpty ? '*Required' : null,
              hint: 'PASSWORD',
            ),
            ElevatedButton(
              onPressed: () {
                _validateLoginInput();
              },
              child: Text('logIn'),
            )
          ],
        ),
      ),
    );
  }
}
