import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class Experiment extends StatefulWidget {
  //SimpleScreen({Key key}) : super(key: key);

  @override
  _Experiment createState() => _Experiment();
}

class _Experiment extends State<Experiment> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

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
    return Scaffold(
      key: _scaffoldKey,
      body: Card(
          margin: const EdgeInsets.all(8),
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
                //onUnitySceneLoaded: onUnitySceneLoaded,
              ),
            ],
          )),
    );
  }

  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  /*void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }*/

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
