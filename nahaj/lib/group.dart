import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  const Group({Key? key}) : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Page"),
      ),
      body: Stack(),
    );
  }
}
