import 'package:flutter/material.dart';

class Child extends ChangeNotifier {
  String username = "";
  String email = "";
  String avatar = "";
  double level = 0;
  Child(this.username, this.email, this.avatar, this.level);
}

class Groups extends ChangeNotifier {
  String groupId = "";
  String groupName = "";
  String leaderId = "";
  String leaderName = "";
  List<String> membersId = [];
  Groups(this.groupId, this.groupName, this.leaderId, this.leaderName,
      this.membersId);
}