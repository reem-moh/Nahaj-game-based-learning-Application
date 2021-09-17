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
              width: MediaQuery.of(context).size.width / 4.46,
              //height: MediaQuery.of(context).size.height / 8.317,
              left: MediaQuery.of(context).size.width * 0.776,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/homeTopBackground.jpg"),
              )),
          //side menu
          Positioned(
              width: MediaQuery.of(context).size.width / 10.34,
              height: MediaQuery.of(context).size.height / 21.9,
              left: MediaQuery.of(context).size.width * 0.875,
              top: MediaQuery.of(context).size.height / 50,
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
