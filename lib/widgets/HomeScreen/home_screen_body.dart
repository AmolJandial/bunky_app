import 'package:bunky_app/models/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            //Top left Hamburger Start

            body: Stack(
              fit: StackFit.expand,
              children: [
                //Top left Hamburger end

                //Main body start
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 12,
                      child: Dashboard(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
