import 'package:flutter/material.dart';

class Child extends ChangeNotifier {
  String username = "";
  String email = "";
  String avatar = "";
  double level = 0;
  Child(this.username, this.email, this.avatar, this.level);
}
