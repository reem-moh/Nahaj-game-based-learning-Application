import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nahaj/homepage.dart';
import 'package:nahaj/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  DataBase db=DataBase();
  runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  final DataBase database;

  @override
  MyApp(this.database);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nahaj',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(db: this.database,),
      //MyHomePage(title: 'Nahaj')
    );
  }
}
