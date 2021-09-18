import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
//background
    return Scaffold(
        backgroundColor: Colors.white,
        //drawer: Drawer(),
        body: Stack(children: <Widget>[
          //top image
          Positioned(
              //width: MediaQuery.of(context).size.width / 4.46,
              left: MediaQuery.of(context).size.width * 0.84,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/homeTopBackground.jpg"),
              )),

          //side menu
          Positioned(
            //width: MediaQuery.of(context).size.width / 10.34,
            //height: MediaQuery.of(context).size.height / 21.9,
            left: MediaQuery.of(context).size.width * 0.9,
            top: MediaQuery.of(context).size.height / 50,
            child: InkWell(
              child: Icon(
                Icons.menu,
                color: Colors.grey[800],
                size: MediaQuery.of(context).size.width / 20,
              ),
              onTap: () {},
            ),
          ),

          //welcome message widget
          WelcomeMessage(),
          //bottom image
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height / 1.43,
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/homeBottomBackground.jpg"))),
        ]));
  }
}

class WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//keys to assign to widgets
    final GlobalKey welcomeBackground = GlobalKey();

    return Stack(
      children: [
        //welcome message background
        Positioned(
            key: welcomeBackground,
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 11,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    width: MediaQuery.of(context).size.width / 1.09,
                    height: MediaQuery.of(context).size.height / 4.18,
                    image: AssetImage("assets/helloMessageBackground.png"))
              ],
            )),

        //welcome message text
        Positioned(
            width: MediaQuery.of(context).size.width / 1.09,
            top: MediaQuery.of(context).size.height / 5.5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'أهلاً، سلطان',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
