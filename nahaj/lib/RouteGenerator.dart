import 'package:flutter/material.dart';
import 'package:nahaj/Signin.dart';
import 'package:nahaj/addGroup.dart';
import 'package:nahaj/category.dart';
import 'package:nahaj/group.dart';
import 'package:nahaj/homePage.dart';
import 'package:nahaj/joinGroup.dart';
import 'package:nahaj/main.dart';
import 'package:nahaj/signUp.dart';
import 'database.dart';

class RouteGenerator {
  final DataBase db;
  RouteGenerator(this.db);
  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

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
        return MaterialPageRoute(builder: (context) => JoinGroup());
      case '/AddGroup':
        return MaterialPageRoute(builder: (context) => AddGroup());
      case '/Group':
        return MaterialPageRoute(builder: (context) => Group());
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
