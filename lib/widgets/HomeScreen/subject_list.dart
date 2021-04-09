import 'package:bunky_app/widgets/BottomSheet/subject_detail.dart';
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
        return customListTile(chosenSubjects, index, context);
        // title: Text(chosenSubjects[index]['subjectName']),
      },
    );
  }
}

void openSubjectDetail(
    BuildContext context, Map<String, dynamic> chosenSubject, int index) {
  showBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (_) => SubjectDetail(chosenSubject, index),
  );
}

Widget customListTile(
    List<dynamic> chosenSubject, int index, BuildContext context) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 6,
    child: ListTile(
      horizontalTitleGap: 30,
      contentPadding: EdgeInsets.all(5),

      //leading image
      leading: Container(
        width: MediaQuery.of(context).size.width * .18,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "ACR",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),

      //title
      title: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Text(chosenSubject[index]['subjectName']),
      ),

      //subtitle
      subtitle: Text(chosenSubject[index]['subjectTeacher']),

      onTap: () => openSubjectDetail(context, chosenSubject[index], index),
    ),
  );
}
