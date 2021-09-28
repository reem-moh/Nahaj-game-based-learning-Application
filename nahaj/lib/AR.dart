import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:arkit_plugin/widget/arkit_scene_view.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class AR extends StatefulWidget {
  const AR({Key? key}) : super(key: key);

  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        onARKitViewCreated: (controller) => arView(controller),
      ),
    );
  }
}

void arView(ARKitController controller) {
  //geometry for shape
  //
  final nodeAr = ARKitNode(
    geometry: ARKitSphere(
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialImage("assets/animals.png"),
          doubleSided: true,
        ),
      ],
      radius: 1,
    ),
    position: Vector3(0,0,0),
  );
  controller.add(nodeAr);
}
