import 'package:bunky_app/screens/home_screen.dart';
import 'package:bunky_app/screens/logIn_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/custom_text_field.dart';
import '../services/database.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration-screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  static String _email;
  static String _password;
  static String _username;
  String _semester;
  String _course;
  final _auth = FirebaseAuth.instance;

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

  List<String> semesters = ['1', '2', '3', '4'];
  List<String> courses = ['cse', 'IT', 'biotech'];

  void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      Map<String, Map<String, dynamic>> filteredSubjects =
          Database().filteredSubjects(
        _semester,
        _course,
      );
      try {
        print('1. Register button is pressed');
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        print('2. User is Registered');

        print('3. User database is being initalized');
        FirebaseFirestore.instance
            .collection('student')
            .doc(user.user.uid)
            .set({
          'email': _email,
          'username': _username,
          'semester': _semester,
          'course': _course,
        }).then((value) {
          FirebaseFirestore.instance
              .collection('student')
              .doc(user.user.uid)
              .collection('subjects')
              .add(filteredSubjects);
        });
        print('4. User database is initializned and goes to Login Screen');
        Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
      } catch (e) {
        switch (e.code) {
          case 'ERROR_EMAIL_ALREADY_IN_USE':
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
          case 'ERROR_WEAK_PASSWORD':
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
          mainAxisAlignment: MainAxisAlignment.center,
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
              onSaved: (input) {
                _username = input;
              },
              // validator: emailValidator,
              icon: Icon(Icons.person),
              hint: 'USERNAME',
            ),
            CustomTextField(
              icon: Icon(Icons.lock),
              obsecure: true,
              onSaved: (input) => _password = input,
              validator: (input) => input.isEmpty ? '*Required' : null,
              hint: 'PASSWORD',
            ),
            DropdownButtonFormField(
              items: semesters.map((sem) {
                return DropdownMenuItem(
                  value: sem,
                  child: Text('$sem semester'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _semester = val),
              value: _semester,
            ),
            DropdownButtonFormField(
              items: courses.map((course) {
                return DropdownMenuItem(
                  value: course,
                  child: Text('$course'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _course = val),
              value: _course,
            ),
            ElevatedButton(
              onPressed: () {
                _validateRegisterInput();
              },
              child: Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
