import 'package:bunky_app/models/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Data_initialize.dart';

class Home extends StatelessWidget {
  static const routeName = '/home-screen';

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
            print('6. User uid has been get from database');
            if (user.hasData) {
              User currentUser = user.data;
              return DataInitialize(currentUser.uid, 'home');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
