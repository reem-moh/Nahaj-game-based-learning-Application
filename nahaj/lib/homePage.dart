import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  get child => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //background
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          //top image
          Positioned(
              width: MediaQuery.of(context).size.width / 4.17,
              height: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width * 0.84,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/homeTopBackground.jpg"),
              )),
          //side menu
          Positioned(
              //width: MediaQuery.of(context).size.width / 6,
              //height: MediaQuery.of(context).size.height / 8,
              left: MediaQuery.of(context).size.width * 0.85,
              top: MediaQuery.of(context).size.height / 1000,
              child: IconButton(
                  onPressed: () {
                    //on pressed
                  },
                  icon: Image(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/sidebarMenu.png"),
                  ))),
          //bottom image
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.width * 0.95,
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/homeBottomBackground.jpg"))),
        ]));
  }
}
