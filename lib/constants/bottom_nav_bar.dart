import 'package:bunky_app/screens/home_screen.dart';

import 'package:bunky_app/screens/settings_screen.dart';
import 'package:bunky_app/screens/subject_grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomNavBar extends StatefulWidget {
  final String currentScreen;
  BottomNavBar(this.currentScreen);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(253, 145, 145, 1),
            width: 2,
          ),
        ),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.settings),
              color: Color.fromRGBO(253, 145, 145, 1),
              onPressed: () {
                widget.currentScreen == 'settings'
                    // ignore: unnecessary_statements
                    ? null
                    : Navigator.of(context).pushNamed(Settings.routeName);
              },
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              color: Color.fromRGBO(253, 145, 145, 1),
              onPressed: () {
                widget.currentScreen == 'home'
                    // ignore: unnecessary_statements
                    ? null
                    : Navigator.of(context).popAndPushNamed(Home.routeName);
              },
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.folder_open_rounded),
              color: Color.fromRGBO(253, 145, 145, 1),
              onPressed: () {
                widget.currentScreen == 'subjectsGrid'
                    // ignore: unnecessary_statements
                    ? null
                    : Navigator.of(context)
                        .pushNamed(SubjectGridScreen.routeName);
              },
            ),
            label: '',
          ),
        ],
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 30,
      ),
    );
  }
}
