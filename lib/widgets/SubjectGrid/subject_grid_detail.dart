import 'package:bunky_app/constants/top_app_bar.dart';
import 'package:flutter/material.dart';
import '../../constants/bottom_nav_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SubjectGridDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subject =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TopAppBar().topAppBar(
              subject['subjectName'],
              context,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: 35,
                  right: 35,
                ),
                height: MediaQuery.of(context).size.height * .6,
                child: ListView(
                  children: [
                    subejectOptions(
                      Icons.menu_book_rounded,
                      'Books',
                      Icons.download_sharp,
                      context,
                    ),
                    subejectOptions(
                      Icons.file_present,
                      'Syllabus',
                      Icons.download_sharp,
                      context,
                    ),
                    subejectOptions(
                      Icons.description_outlined,
                      'Paper',
                      Icons.download_sharp,
                      context,
                    ),
                    subejectOptions(
                      Icons.video_collection_outlined,
                      'Playlist',
                      Icons.open_in_new_rounded,
                      context,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(null),
      ),
    );
  }

  Widget subejectOptions(IconData leftIcon, String optionName,
      IconData rightIcon, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      padding: EdgeInsets.all(
        10,
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          depth: -5,
          shadowLightColorEmboss: Colors.black,
          lightSource: LightSource.bottomRight,
          color: Color(0xff162447),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              leftIcon,
              size: 30,
              color: Color.fromRGBO(253, 145, 145, 1),
            ),
            Text(
              optionName,
              style: TextStyle(
                fontSize: 30,
                color: Color.fromRGBO(253, 145, 145, 1),
              ),
            ),
            IconButton(
              icon: Icon(
                rightIcon,
                size: 30,
                color: Color.fromRGBO(253, 145, 145, 1),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
