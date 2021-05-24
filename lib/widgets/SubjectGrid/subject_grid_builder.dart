import 'package:bunky_app/models/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/bottom_nav_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SubjectGridBuilder extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = '/subject-wise-detail';
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    List<dynamic> subjects = dataProvider.subjects;
    print('grid screen $subjects');
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              flex: 12,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    padding: EdgeInsets.all(30),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 5,
                      mainAxisSpacing: constraints.maxHeight * 0.04,
                      crossAxisSpacing: constraints.maxWidth * 0.1,
                      mainAxisExtent: constraints.maxHeight * 0.25,
                    ),
                    itemBuilder: (context, index) {
                      return gridItems(subjects[index], context);
                    },
                    itemCount: subjects.length,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
    // bottomNavigationBar: BottomNavBar('subjectsGrid'),
  }

  Widget gridItems(Map<String, dynamic> subject, BuildContext context) {
    return Container(
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          depth: 3,
          intensity: 1,
          shadowLightColor: Colors.white38,
          shadowDarkColor: Colors.black87,
          color: Color(0xff162447),
          lightSource: LightSource.topLeft,
        ),
        child: GridTile(
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  routeName,
                  arguments: subject,
                );
              },
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    subject['subjectName'],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
