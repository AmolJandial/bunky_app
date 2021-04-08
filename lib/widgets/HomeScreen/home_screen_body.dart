import 'package:flutter/material.dart';

import 'dashboard.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            //Top left Hamburger Start
            key: scaffoldKey,
            drawer: Drawer(
              child: ListView(),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                ),
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
