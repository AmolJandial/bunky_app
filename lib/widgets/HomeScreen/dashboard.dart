import 'package:bunky_app/screens/settings_screen.dart';
import 'package:bunky_app/widgets/HomeScreen/curverPainter.dart';
import 'package:bunky_app/widgets/HomeScreen/dashboardBuilding.dart';
import 'package:bunky_app/widgets/SubjectGrid/subject_grid_builder.dart';
import 'package:flutter/material.dart';
import './subjects.dart';
import '../../constants/bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 1;
  final List<Widget> children = [
    Settings(),
    DashboardBuild(),
    SubjectGridBuilder(),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //Card building Starts
            Expanded(flex: 12, child: children[index]),

            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(253, 145, 145, 1),
                      width: 2,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  iconSize: 30,
                  currentIndex: index,
                  onTap: (int ind) {
                    setState(() {
                      index = ind;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: index == 0
                          ? Icon(
                              Icons.settings,
                              color: Color.fromRGBO(0, 145, 145, 1),
                            )
                          : Icon(
                              Icons.settings,
                              color: Color.fromRGBO(253, 145, 145, 1),
                            ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: index == 1
                          ? Icon(
                              Icons.home,
                              color: Color.fromRGBO(0, 145, 145, 1),
                            )
                          : Icon(
                              Icons.home,
                              color: Color.fromRGBO(253, 145, 145, 1),
                            ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: index == 2
                          ? Icon(
                              Icons.file_copy,
                              color: Color.fromRGBO(0, 145, 145, 1),
                            )
                          : Icon(
                              Icons.file_copy,
                              color: Color.fromRGBO(253, 145, 145, 1),
                            ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
