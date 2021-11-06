import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ExperimentScene extends StatefulWidget {
  //ExperimentScene(/*{required Key key}*/) : super(key: key);

  @override
  _ExperimentScene createState() => _ExperimentScene();
}

class _ExperimentScene extends State<ExperimentScene> {
  late UnityWidgetController _unityWidgetController;

  late final void Function(SceneLoaded? scene)? onUnitySceneLoaded =
      (SceneLoaded? scene) {
    print('Received scene loaded from unity: ${scene!.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  };
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
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(0.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: UnityWidget(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              onUnityCreated: _onUnityCreated,
              onUnityMessage: onUnityMessage,
              onUnitySceneLoaded: onUnitySceneLoaded,
            ),
          ),
        ],
      ),
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

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
