import 'package:bunky_app/models/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Voting extends StatefulWidget {
  final Map<String, dynamic> chosenSubject;
  final UserData userData;

  Voting(
    this.chosenSubject,
    this.userData,
  );
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  void votingLogic(BuildContext context) {
    FirebaseFirestore.instance.collection('votes').add({
      'subjectName': widget.chosenSubject['subjectName'],
      'semester': widget.userData.semester,
      'course': widget.userData.course,
      'votes': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
    FirebaseFirestore.instance.collection('student').get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        Map<String, dynamic> docData = doc.data();
        String docID = doc.id;
        if (docData['semester'] == widget.userData.semester &&
            docData['course'] == widget.userData.course) {
          FirebaseFirestore.instance
              .collection('student')
              .doc(docID)
              .collection('subjects')
              .get()
              .then((value) {
            List<DocumentSnapshot> temp = value.docs;
            DocumentSnapshot doc = temp[0];
            String docId = doc.id;
            String subjectName = widget.chosenSubject['subjectName'];
            FirebaseFirestore.instance
                .collection('student')
                .doc(docID)
                .collection('subjects')
                .doc(docId)
                .update({'$subjectName.isvotingStarted': true});
          });
        }
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .43,
            minHeight: MediaQuery.of(context).size.height * .43,
            maxWidth: MediaQuery.of(context).size.width * .8,
            minWidth: MediaQuery.of(context).size.width * .8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  widget.chosenSubject['subjectName'],
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start Voting?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    return votingLogic(context);
                  },
                  child: Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  child: Text('No'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
