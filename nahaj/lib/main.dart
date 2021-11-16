import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nahaj/Group/GroupInfo.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/SignPages/Signin.dart';
//import 'package:nahaj/Group/addGroup.dart';
//import 'package:nahaj/Group/group.dart';
//import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
//import 'package:nahaj/Group/joinGroup.dart';
//import 'package:nahaj/SignPages/signUp.dart';
//import 'package:nahaj/Group/addGroup2.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  DataBase db = DataBase();
  runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  final DataBase database;

  @override
  MyApp(this.database);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {  
      return MaterialApp(
        title: 'Nahaj',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: //Signin(db: this.database,)
        
        
         GroupInfo(
          //groupName: 'مجموعة',
          db: this.database, group:  Groups(goupCode: 2, groupId: "2", groupName: "groupName", leaderId: "leaderId", leaderName: "leaderName", pathOfImage: "pathOfImage", members: [{}]), user: new User(userId: "userId", username: "ريم", email: "email", avatar: "avatar", level: 1),) 
        /*AddGroup2(
          db: this.database,
        ),*/
        //MyHomePage(title: 'Nahaj'),
      );
      },
    );
  }
}
