import 'package:bunky_app/models/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetail extends StatefulWidget {
  final Map<String, dynamic> chosenSubject;
  final int index;
  SubjectDetail(this.chosenSubject, this.index);

  @override
  _SubjectDetailState createState() => _SubjectDetailState();
}

class _SubjectDetailState extends State<SubjectDetail> {
  Widget subjectDetailDesign(Map<String, dynamic> chosenSubject,
      BuildContext context, DataProvider provider) {
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
            style: TextStyle(fontSize: 20),
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(total),
                        SizedBox(
                          height: mediaQuery.size.height * 0.010,
                        ),
                        Text('Total'),
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
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: InkWell(
                      onTap: () =>
                          showAlertDialog(context, 'attended', provider),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text((chosenSubject['attended']).toString()),
                          SizedBox(
                            height: mediaQuery.size.height * 0.010,
                          ),
                          Text('Attended'),
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => showAlertDialog(context, 'missed', provider),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text((chosenSubject['missed']).toString()),
                          SizedBox(
                            height: mediaQuery.size.height * 0.010,
                          ),
                          Text('Missed'),
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
              Text('Class Link'),
              Container(
                margin: EdgeInsets.only(
                  top: mediaQuery.size.height * .04,
                  bottom: mediaQuery.size.height * .04,
                ),
                width: mediaQuery.size.width * .50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          //Class Link Ends

          //Voting button starts
          InkWell(
            splashColor: Colors.red,
            onTap: () {},
            child: Container(
              width: mediaQuery.size.width * .35,
              height: mediaQuery.size.height * .06,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'vote',
                  style: TextStyle(fontSize: 20),
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
            //Box Decoration ends

            //Subject Shown Logic starts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                subjectDetailDesign(widget.chosenSubject, context, provider),
              ],
            ),
            //Subject shown logic ends
          ),
        ),
      ),
    );
  }
}
