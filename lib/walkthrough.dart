import 'package:bunky_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Walkthrough extends StatefulWidget {
  static const String routeName = '/walkthrough';

  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Building Walkthrough using WalkthroughLogic class iff walkthroughIndex < 3
      body: PageView(
        children: [
          WalkthroughLogic(
            0,
            false,
          ),
          WalkthroughLogic(
            1,
            false,
          ),
          WalkthroughLogic(
            2,
            true,
          ),
        ],
      ),
    );
  }
}

class WalkthroughLogic extends StatelessWidget {
  final int index;

  // final String assetName = './assets/dot1.svg';
  final bool isfinalWalkthrough;

  WalkthroughLogic(this.index, this.isfinalWalkthrough);

  List<Map<String, List<String>>> walkthroughText = [
    {
      'text': [
        'Bunky',
        'your collage convienece app',
        'use it like blah',
      ]
    },
    {
      'text': [
        'Plan Bunks',
        'with one tap',
        'use it like yah yah',
      ]
    },
    {
      'text': [
        'Keep Record',
        'of your attendance',
        'use this like leh leh',
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.pinkAccent,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: mediaQuery.size.height * .05),
          SizedBox(height: mediaQuery.size.height * .13),
          //First Text Line start
          Text(
            walkthroughText[index]['text'][0],
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          //First text line end

          SizedBox(
            height: mediaQuery.size.height * .015,
          ),

          //second text line start
          Text(
            walkthroughText[index]['text'][1],
            style: TextStyle(color: Colors.white),
          ),
          //second text line end

          SizedBox(height: mediaQuery.size.height * .09),

          //center illustration start
          Image.asset('./assets/progress_1.png'),
          //center illustration end

          SizedBox(height: mediaQuery.size.height * .09),

          //third text line start
          Container(
            width: mediaQuery.size.width * .50,
            child: Text(
              walkthroughText[index]['text'][2],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          //third text line end

          SizedBox(
            height: mediaQuery.size.height * .04,
          ),

          // //dot image start
          // SvgPicture.asset(
          //   './assets/dot$imageIndex.svg', //dots image
          //   height: mediaQuery.size.height * .025,
          //   width: mediaQuery.size.width * .50,
          // ),
          // //dot image end

          //Botton 'Next' start
          if (isfinalWalkthrough)
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .popAndPushNamed(WelcomeScreen.routeName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: mediaQuery.size.height * .08,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            spreadRadius: 2),
                      ], color: Colors.white),
                      child: Center(
                        child: Text(
                          'Done', // bottom text
                          style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          //Bottom 'Next' end
        ],
      ),
    );
  }
}
