import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nahaj/signUp.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nahaj',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: signUp(),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'push the button to go to the home page',
            ),
          ],
        ),
      ),
    );
  }
}*/
