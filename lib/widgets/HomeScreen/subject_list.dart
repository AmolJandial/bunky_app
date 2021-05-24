import 'dart:ui';

import 'package:bunky_app/widgets/BottomSheet/subject_detail.dart';
import 'package:flutter/material.dart';
import 'package:bunky_app/models/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SubjectList extends StatelessWidget {
  final DateTime chosenDate;
  SubjectList(this.chosenDate);

  @override
  Widget build(BuildContext context) {
    DataProvider data = Provider.of<DataProvider>(context);
    final subjects = data.subjects;
    String finalChosenDate = DateFormat.E().format(chosenDate);
    List<dynamic> chosenSubjects = [];
    subjects.forEach((element) {
      List<dynamic> dates = element['subjectDate'];
      if (dates.contains(finalChosenDate)) {
        chosenSubjects.add(element);
      }
    });

    return ListView.builder(
      itemCount: chosenSubjects.length,
      itemBuilder: (context, index) {
        return customListTile(chosenSubjects, index, context, data.data);
        // title: Text(chosenSubjects[index]['subjectName']),
      },
    );
  }
}

void openSubjectDetail(BuildContext context, Map<String, dynamic> chosenSubject,
    int index, UserData userData) {
  showBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (_) => SubjectDetail(chosenSubject, index, userData),
  );
}

Widget customListTile(List<dynamic> chosenSubject, int index,
    BuildContext context, UserData userData) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    color: Color(0xff162447),
    margin: EdgeInsets.all(10),
    child: Container(
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(20),
            ),
            depth: -5,
            lightSource: LightSource.bottomRight,
            shadowLightColorEmboss: Colors.black,
            // shadowDarkColorEmboss: Colors.black.withOpacity(0.5),
            color: Color(0xff162447),
            border: NeumorphicBorder(
              isEnabled: false,
              color: Colors.black,
              width: 1,
            )),
        child: ListTile(
          horizontalTitleGap: 30,
          contentPadding: EdgeInsets.all(5),

          //leading image
          leading: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              depth: -5,
              shadowLightColorEmboss: Colors.black,
              lightSource: LightSource.bottomRight,
              color: Color(0xff162447),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * .18,
              child: Center(
                child: Text(
                  "ACR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          //title
          title: Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              chosenSubject[index]['subjectName'],
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          //subtitle
          subtitle: Text(
            chosenSubject[index]['subjectTeacher'],
            style: Theme.of(context).textTheme.subtitle1,
          ),

          onTap: () =>
              openSubjectDetail(context, chosenSubject[index], index, userData),
        ),
      ),
    ),
  );
}
