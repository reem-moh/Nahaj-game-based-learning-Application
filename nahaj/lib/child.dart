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
  String creatorId = "";
  String creatorName = "";
  List<String> membersId = [];
  Groups(this.groupId, this.groupName, this.creatorId, this.creatorName,
      this.membersId);
}