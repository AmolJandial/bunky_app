import 'package:bunky_app/screens/welcome_screen.dart';
import 'package:bunky_app/widgets/HomeScreen/home_screen_body.dart';
import 'package:bunky_app/models/provider.dart';
import 'package:bunky_app/widgets/SubjectGrid/subject_grid_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DataInitialize extends StatefulWidget {
  final String uid;
  final String screen;
  DataInitialize(this.uid, this.screen);
  @override
  _DataInitializeState createState() => _DataInitializeState();
}

class _DataInitializeState extends State<DataInitialize> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider myData = Provider.of<DataProvider>(context);
    myData.setId(widget.uid);
    print('uid: ${widget.uid}');
    return FutureBuilder(
      future: myData.getData(),
      builder: (context, snapshot) {
        print('entry to future : ${snapshot.data}');
        if (snapshot.hasData) {
          if (widget.screen == 'home') {
            return HomeScreenBody();
          } else if (widget.screen == 'subjectsGrid') {
            return SubjectGridBuilder();
          }
        }
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      },
    );
  }
}
