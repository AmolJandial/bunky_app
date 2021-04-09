import 'package:bunky_app/constants/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SubjectGridScreen extends StatelessWidget {
  static const routeName = '/subject-grid';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubjectDetail'),
      ),
      bottomNavigationBar: BottomNavBar('subjectsGrid'),
    );
  }
}
