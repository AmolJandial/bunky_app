import 'package:bunky_app/models/provider.dart';
import 'package:bunky_app/widgets/BottomSheet/voting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './voting_started.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SubjectDetail extends StatefulWidget {
  final Map<String, dynamic> chosenSubject;
  final int index;
  final UserData userData;
  SubjectDetail(this.chosenSubject, this.index, this.userData);

  @override
  _SubjectDetailState createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  Widget subjectDetailDesign(
    Map<String, dynamic> chosenSubject,
    BuildContext context,
    DataProvider provider,
    UserData userData,
    bool hasVotingStarted,
  ) {
    String total =
        (chosenSubject['attended'] + chosenSubject['missed']).toString();
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.03,
          ),

          //Subject Name Starts
          Text(
            chosenSubject['subjectName'],
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(253, 145, 145, 1),
            ),
          ),
          //Subject Name Ends

          SizedBox(
            height: mediaQuery.size.height * 0.05,
          ),

          //Attendance details Starts
          Container(
            width: mediaQuery.size.width * 0.70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //First Container Total starts
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: mediaQuery.size.height * 0.10,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(253, 145, 145, 1),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          total,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * 0.010,
                        ),
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Color.fromRGBO(253, 145, 145, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Firts Container Total ends

                //Second Container Attendted starts
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: mediaQuery.size.height * 0.10,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color.fromRGBO(253, 145, 145, 1),
                        ),
                        bottom: BorderSide(
                          color: Color.fromRGBO(253, 145, 145, 1),
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () =>
                          showAlertDialog(context, 'attended', provider),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (chosenSubject['attended']).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: mediaQuery.size.height * 0.010,
                          ),
                          Text(
                            'Attended',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 145, 145, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Second Container Attended ends

                //Third container missed starts
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: mediaQuery.size.height * 0.10,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(253, 145, 145, 1),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => showAlertDialog(context, 'missed', provider),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (chosenSubject['missed']).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: mediaQuery.size.height * 0.010,
                          ),
                          Text(
                            'Missed',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 145, 145, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              //Third container missed ends
            ),
          ),
          //Attendance Details ends

          SizedBox(
            height: mediaQuery.size.height * 0.05,
          ),

          //Class Link Starts
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class Link',
                style: TextStyle(
                  color: Color.fromRGBO(253, 145, 145, 1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: mediaQuery.size.height * .04,
                  bottom: mediaQuery.size.height * .04,
                ),
                width: mediaQuery.size.width * .50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(253, 145, 145, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Class Link Ends

          //Voting button starts
          hasVotingStarted
              ? InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    return showBottomSheet(
                        context: context,
                        builder: (_) => VotingStarted(chosenSubject, userData));
                  },
                  child: Container(
                    width: mediaQuery.size.width * .35,
                    height: mediaQuery.size.height * .06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(253, 145, 145, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Vote',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(253, 145, 145, 1),
                        ),
                      ),
                    ),
                  ),
                )
              : InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    return showBottomSheet(
                      context: context,
                      builder: (_) => Voting(
                        chosenSubject,
                        userData,
                      ),
                    );
                  },
                  child: Container(
                    width: mediaQuery.size.width * .35,
                    height: mediaQuery.size.height * .06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(253, 145, 145, 1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(253, 145, 145, 1),
                        ),
                      ),
                    ),
                  ),
                ),
          //Voting button ends
        ],
      ),
    );
  }

  void showAlertDialog(
      BuildContext context, String type, DataProvider provider) {
    Widget cancelButton = TextButton(
      child: Text('cancel'),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: Text('continue'),
      onPressed: () => counting(type, provider),
    );

    AlertDialog alert = AlertDialog(
      title: Text('1'),
      content: Text('yup'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void counting(String type, DataProvider provider) {
    if (type == 'attended') {
      setState(() {
        provider.updateAttendedData(widget.chosenSubject['subjectName']);
        Navigator.of(context).pop();
      });
    } else if (type == 'missed') {
      setState(() {
        provider.updateMissedData(widget.chosenSubject['subjectName']);
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);
    bool hasVotingStarted;

    Future getData(String subjectName) async {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(widget.userData.uid)
          .collection('subjects')
          .get()
          .then((value) {
        Map<String, dynamic> docData = value.docs.first.data();
        print(docData[subjectName]);
        hasVotingStarted = docData[subjectName]['isvotingStarted'];
      });
      return 1;
    }

    return FutureBuilder(
        future: getData(widget.chosenSubject['subjectName']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              //Making it center starts
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .80,
                    maxWidth: MediaQuery.of(context).size.width * .80,
                    minHeight: MediaQuery.of(context).size.height * .45,
                    maxHeight: MediaQuery.of(context).size.height * .45,
                  ),
                  //Making it center ends

                  //Box decoration  starts
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      depth: -5,
                      shadowLightColorEmboss: Colors.black,
                      lightSource: LightSource.bottomRight,
                      shadowDarkColorEmboss: Colors.black.withOpacity(0.6),
                      color: Color(0xff162447),
                    ),
                    child: Container(
                      //Box Decoration ends

                      //Subject Shown Logic starts
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          subjectDetailDesign(
                            widget.chosenSubject,
                            context,
                            provider,
                            widget.userData,
                            hasVotingStarted,
                          ),
                        ],
                      ),
                      //Subject shown logic ends
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
