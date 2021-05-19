import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../models/provider.dart';

class VotingStarted extends StatefulWidget {
  final Map<String, dynamic> chosenSubject;
  final UserData userData;
  VotingStarted(this.chosenSubject, this.userData);
  @override
  _VotingStartedState createState() => _VotingStartedState();
}

class _VotingStartedState extends State<VotingStarted> {
  int votes;
  bool hasVoted;

  Future dataInit() async {
    await FirebaseFirestore.instance.collection('votes').get().then((value) {
      for (DocumentSnapshot item in value.docs) {
        Map<String, dynamic> doc = item.data();
        if (doc['semester'] == widget.userData.semester &&
            doc['course'] == widget.userData.course &&
            doc['subjectName'] == widget.chosenSubject['subjectName']) {
          votes = doc['votes'];
        }
      }
    });

    await FirebaseFirestore.instance
        .collection('student')
        .doc(widget.userData.uid)
        .collection('subjects')
        .get()
        .then((value) {
      Map<String, dynamic> data = value.docs.first.data();
      String subjectName = widget.chosenSubject['subjectName'];
      Map<String, dynamic> temp = data['$subjectName'];
      hasVoted = temp['hasVoted'];
      print(subjectName);
    });
    print('has user voted = $hasVoted');

    return 1;
  }

  void votingIncrement(BuildContext context) {
    votes++;
    FirebaseFirestore.instance
        .collection('student')
        .doc(widget.userData.uid)
        .collection('subjects')
        .get()
        .then((value) {
      DocumentSnapshot doc = value.docs.first;
      String docId = doc.id;
      String subjectName = widget.chosenSubject['subjectName'];
      FirebaseFirestore.instance
          .collection('student')
          .doc(widget.userData.uid)
          .collection('subjects')
          .doc(docId)
          .update({'$subjectName.hasVoted': true});
    });
    FirebaseFirestore.instance.collection('votes').get().then((value) {
      for (DocumentSnapshot item in value.docs) {
        String docID = item.id;
        Map<String, dynamic> data = item.data();
        if (data['semester'] == widget.userData.semester &&
            data['course'] == widget.userData.course &&
            data['subjectName'] == widget.chosenSubject['subjectName']) {
          FirebaseFirestore.instance
              .collection('votes')
              .doc(docID)
              .update({'votes': votes});
        }
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataInit(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Title starts
                        Text(
                          widget.chosenSubject['subjectName'],
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Title ends

                        //Graph Starts
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Number
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: FittedBox(
                                child: Text(
                                  votes.toString(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),

                            //Graph
                            Container(
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: (votes.toDouble()) / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.pink,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Graph Ends

                        //Options
                        hasVoted
                            ? Text('Already Voted')
                            : ElevatedButton(
                                onPressed: () {
                                  return votingIncrement(context);
                                },
                                child: Text('Yes'),
                              ),
                        ElevatedButton(
                          onPressed: () {
                            return Navigator.pop(context);
                          },
                          child: Text('Exit'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
