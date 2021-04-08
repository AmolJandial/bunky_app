import 'package:bunky_app/widgets/HomeScreen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      bottomNavigationBar: BottomNavBar('settings'),
    );
  }
}
