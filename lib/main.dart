import 'package:bunky_app/screens/home_screen.dart';
import 'package:bunky_app/screens/logIn_screen.dart';
import 'package:bunky_app/screens/registration_screen.dart';
import 'package:bunky_app/screens/welcome_screen.dart';

import 'package:bunky_app/widgets/HomeScreen/settings_screen.dart';
import 'package:bunky_app/widgets/HomeScreen/subject_grid_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        LogInScreen.routeName: (context) => LogInScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        Home.routeName: (context) => Home(),
        Settings.routeName: (context) => Settings(),
        SubjectGridScreen.routeName: (context) => SubjectGridScreen(),
      },
      initialRoute: WelcomeScreen.routeName,
    );
  }
}
