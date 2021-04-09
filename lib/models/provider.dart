import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData {
  final String username;
  final String email;

  UserData({
    this.email,
    this.username,
  });
}

class Subjects {
  final String subjectName;
  final String subjectTeacher;
  final List<String> subjectDate;
  int attended;
  int missed;
  int totalAttended;
  Subjects({
    this.attended,
    this.subjectName,
    this.missed,
    this.subjectDate,
    this.subjectTeacher,
    this.totalAttended,
  });
}

class DataProvider extends ChangeNotifier {
  String uid;
  UserData data;
  var subjects = []; //List<Map<String,dynamic>>

  void setId(String tempUid) {
    uid = tempUid;
  }

  Future getData() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('student').doc(uid).get();
    Map<String, dynamic> userDataFirestore = snapshot.data();
    UserData userData = UserData(
      email: userDataFirestore['email'],
      username: userDataFirestore['username'],
    );
    data = userData;

    QuerySnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('student')
        .doc(uid)
        .collection('subjects')
        .get();

    List<DocumentSnapshot> documents = docSnapshot.docs;
    print('Number of documents ${documents.length}');

    DocumentSnapshot document = documents[0];
    String docId = document.id;
    print(docId);
    Map<String, dynamic> documentData = document.data();

    subjects = documentData.entries.map((e) => e.value).toList();

    // userSubjectsData = list;

    // //Map<String,Map<String,dynamic>>

    // // for (int i = 0; i < documents.length; i++) {
    // //   DocumentSnapshot document = documents[i];

    // //   Map<String, dynamic> data = document.data();
    // //   final attended = data['attended'];
    // //   final subjectName = data['subjectName'];
    // //   print(attended);
    // //   print(subjectName);
    // //   userSubjectsData.insert(i, {
    // //     'attended': attended,
    // //     'subjectName': subjectName,
    // //   });
    // //   print('4');

    // // print(temp);
    return data;
  }

  Future updateAttendedData(String subjectName) async {
    int newAttended;
    subjects.forEach((element) {
      if (element['subjectName'] == subjectName) {
        element['attended']++;
        newAttended = element['attended'];
      }
    });

    // print("after click ${data['username']}");
    await FirebaseFirestore.instance
        .collection('student')
        .doc(uid)
        .collection('subjects')
        .get()
        .then((value) async {
      String someId = value.docs[0].id;
      print(someId);
      await FirebaseFirestore.instance
          .collection('student')
          .doc(uid)
          .collection('subjects')
          .doc(someId)
          .update({
        '$subjectName.attended': newAttended,
      });
    });
  }

  Future updateMissedData(String subjectName) async {
    int newMissed;
    subjects.forEach((element) {
      if (element['subjectName'] == subjectName) {
        element['missed']++;
        newMissed = element['missed'];
      }
    });

    // print("after click ${data['username']}");
    await FirebaseFirestore.instance
        .collection('student')
        .doc(uid)
        .collection('subjects')
        .get()
        .then((value) async {
      String someId = value.docs[0].id;
      print(someId);
      await FirebaseFirestore.instance
          .collection('student')
          .doc(uid)
          .collection('subjects')
          .doc(someId)
          .update({
        '$subjectName.missed': newMissed,
      });
    });
  }
}
