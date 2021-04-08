import 'package:flutter/material.dart';
import './calender.dart';

import './subject_list.dart';

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  DateTime chosenDate = DateTime.now();

  void updateSubjectList(DateTime userPickedDate) {
    setState(() {
      this.chosenDate = userPickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //Calender
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 5),
              height: constraints.maxHeight * .2,
              width: constraints.maxWidth * .9,
              child: Calender(updateSubjectList, chosenDate),
            ),

            //SubjectList
            Expanded(
              child: Container(
                height: constraints.maxHeight * .6,
                width: constraints.maxWidth * .9,
                child: SubjectList(chosenDate),
              ),
            ),
          ],
        );
      },
    );
  }
}
