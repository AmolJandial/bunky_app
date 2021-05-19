import 'package:bunky_app/constants/bottom_nav_bar.dart';
import 'package:bunky_app/constants/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopAppBar().topAppBar(
            'Settings',
            context,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'General',
                    style: TextStyle(
                        fontSize: 24, color: Color.fromRGBO(253, 145, 145, 1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  settingOption(
                    'Account',
                    Icons.account_circle_outlined,
                    context,
                  ),
                  settingOption(
                    'Logout',
                    Icons.logout,
                    context,
                  ),
                  settingOption(
                    'Notifications',
                    Icons.notifications_outlined,
                    context,
                  ),
                  Text(
                    'Feedback',
                    style: TextStyle(
                        fontSize: 24, color: Color.fromRGBO(253, 145, 145, 1)),
                  ),
                  settingOption(
                    'Send Feedback',
                    Icons.send_outlined,
                    context,
                  ),
                  settingOption(
                    'Report a Bug',
                    Icons.bug_report_outlined,
                    context,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar('settings'),
    );
  }

  Widget settingOption(String title, IconData icon, BuildContext ctx) {
    return Container(
      width: MediaQuery.of(ctx).size.width * .75,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: InkWell(
        onTap: () {
          if (title == 'Logout') {
            FirebaseAuth.instance.signOut();
          }
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: Color.fromRGBO(253, 145, 145, 1),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: 20,
      ),
    );
  }
}
