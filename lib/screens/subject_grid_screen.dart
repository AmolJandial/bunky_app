import 'package:bunky_app/models/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../models/Data_initialize.dart';

class SubjectGridScreen extends StatelessWidget {
  static const routeName = '/subject-grid';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future waitForUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: FutureBuilder(
          future: waitForUser(),
          builder: (context, AsyncSnapshot user) {
            if (user.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              User currentUser = user.data;
              return DataInitialize(currentUser.uid, 'subjectsGrid');
            }
          }),
    );
  }
}
