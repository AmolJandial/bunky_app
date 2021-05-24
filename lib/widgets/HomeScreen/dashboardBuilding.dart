import 'package:bunky_app/widgets/HomeScreen/curverPainter.dart';
import 'package:bunky_app/widgets/HomeScreen/subjects.dart';
import 'package:flutter/material.dart';

class DashboardBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .33,
          child: CustomPaint(
            painter: CurvePainter(),
          ),
        ),
        //Card building ends
        SizedBox(
          height: MediaQuery.of(context).size.height * .03,
        ),

        Container(
          margin: EdgeInsets.only(top: 8),
          height: MediaQuery.of(context).size.height * .52,
          width: MediaQuery.of(context).size.width * .9,
          child: Subjects(),
        ),
      ],
    );
  }
}
