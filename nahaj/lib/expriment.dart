import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:nahaj/HomePage/category.dart';

class Experiment extends StatefulWidget {
  //SimpleScreen({Key key}) : super(key: key);

  @override
  _Experiment createState() => _Experiment();
}

class _Experiment extends State<Experiment> {
  late UnityWidgetController _unityWidgetController;
  bool paused = false;
  double buttonWidth = 0;
  double buttonHeight = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _unityWidgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonWidth = MediaQuery.of(context).size.width;
    buttonHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Card(
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              UnityWidget(
                borderRadius: BorderRadius.all(Radius.zero),
                onUnityCreated: _onUnityCreated,
                onUnityMessage: onUnityMessage,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, top: 20),
                child: InkWell(
                  child: Image.asset(
                    'assets/ExperimentBackButton.png',
                    height: 60,
                    width: 60,
                  ),
                  onTap: () {
                    if (paused) {
                      _unityWidgetController.resume()!.then((value) =>
                          _unityWidgetController
                              .unload()!
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Category()),
                                  )));
                    } else {
                      _unityWidgetController
                          .unload()!
                          .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Category()),
                              ));
                    }
                  },
                ),
              ),
              /*Positioned(
                  child: InkWell(
                child: Container(
                  width: buttonWidth,
                  height: buttonHeight,
                  color: Color.fromARGB(200, 145, 111, 170),
                ),
                onTap: () {
                  _unityWidgetController.pause();
                  _unityWidgetController.resume()!.then((value) => setState(() {
                        buttonHeight = buttonHeight * 0;
                        buttonWidth = 0;
                      }));
                  print('\n\nTapped to enable scene\n\n');
                },
              ))*/
            ],
          )),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    if (message.toString() == "END") {
      //if quit shows error let user unload(), quit()
      _unityWidgetController.pause()!.then((value) => paused = true);
    }
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
