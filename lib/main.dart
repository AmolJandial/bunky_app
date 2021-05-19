import 'package:bunky_app/screens/home_screen.dart';
import 'package:bunky_app/screens/logIn_screen.dart';
import 'package:bunky_app/screens/registration_screen.dart';
import 'package:bunky_app/screens/welcome_screen.dart';

import 'package:bunky_app/screens/settings_screen.dart';
import 'package:bunky_app/screens/subject_grid_screen.dart';
import 'package:bunky_app/widgets/SubjectGrid/subject_grid_detail.dart';
import 'package:bunky_app/widgets/SubjectGrid/subject_grid_builder.dart';

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
        SubjectGridBuilder.routeName: (context) => SubjectGridDetail(),
      },
      initialRoute: WelcomeScreen.routeName,
      theme: ThemeData(
        primarySwatch: Colors.amber,

        canvasColor: Color(0xff162447),
        //ABHISHEK --> 239, 175, 150, 1
        //Garvit --> 255, 222, 222, 1
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              subtitle1: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
              headline2: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
      ),
    );
  }
}
