import 'package:flutter/material.dart';

class TopAppBar {
  Widget topAppBar(String subjectName, BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .15,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(253, 145, 145, 1), width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 50,
                    color: Color.fromRGBO(253, 145, 145, 1),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      subjectName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(253, 145, 145, 1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
