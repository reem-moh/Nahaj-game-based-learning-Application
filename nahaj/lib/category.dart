import 'package:flutter/material.dart';
import 'package:nahaj/experiment.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Page"),
      ),
      body: Stack(
        children: [
          InkWell(
            child: Text('volcano'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExperimentScene()),
              );
            },
          )
        ],
      ),
    );
  }
}
