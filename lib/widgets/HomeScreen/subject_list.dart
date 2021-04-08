import 'package:flutter/material.dart';
import 'package:bunky_app/models/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
        return ListTile(
          title: Text(chosenSubjects[index]['subjectName']),
        );
      },
    );
  }
}
