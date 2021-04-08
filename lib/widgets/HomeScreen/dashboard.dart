import 'package:bunky_app/widgets/HomeScreen/image_card.dart';
import 'package:flutter/material.dart';
import './subjects.dart';
import './bottom_nav_bar.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            //Card building Starts
            Container(
              width: constraints.maxWidth * .80,
              height: constraints.maxHeight * .35,
              child: ImageCard(),
            ),
            //Card building ends
            SizedBox(
              height: constraints.maxHeight * .03,
            ),

            Container(
              margin: EdgeInsets.only(top: 8),
              height: constraints.maxHeight * .52,
              width: constraints.maxWidth * .9,
              child: Subjects(),
            ),

            Expanded(
              child: Container(
                child: BottomNavBar('home'),
              ),
            ),
          ],
        );
      },
    );
  }
}
