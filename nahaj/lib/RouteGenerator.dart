import 'package:flutter/material.dart';
import 'package:nahaj/SignPages/Signin.dart';
import 'package:nahaj/Group/addGroup.dart';
import 'package:nahaj/HomePage/category.dart';
import 'package:nahaj/Group/group.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/Group/joinGroup.dart';
//import 'package:nahaj/main.dart';
import 'package:nahaj/SignPages/signUp.dart';
import 'child.dart';
import 'database.dart';

class RouteGenerator {
  final DataBase db;
  final User user;
  const RouteGenerator( this.db,  this.user);
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/Signin':
        return MaterialPageRoute(
            builder: (context) => Signin(
                  db: db,
                ));
      case '/Signup':
        return MaterialPageRoute(
            builder: (context) => SignUp(
                  db: db,
                ));
      case '/HomePage':
        return MaterialPageRoute(
            builder: (context) => HomePage(
                  db: db,
                ));
      case '/JoinGroup':
        return MaterialPageRoute(builder: (context) => JoinGroup(   db: this.db,user: user));
      case '/AddGroup':
        return MaterialPageRoute(builder: (context) => AddGroup( db: this.db,user: user));
      case '/Group':
        return MaterialPageRoute(builder: (context) => Group(group: new Groups(0, 'groupName', 'leaderId', 'leaderName', ['memberId'], ['memberName'], 'pathOfImage'),db: this.db,user: user));
      case '/Category':
        return MaterialPageRoute(builder: (context) => Category());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
