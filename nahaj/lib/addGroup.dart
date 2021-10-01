import 'package:flutter/material.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({Key? key}) : super(key: key);

  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Group Page"),
      ),
      body: Stack(),
    );
  }
}
