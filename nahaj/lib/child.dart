import 'package:flutter/material.dart';

class User extends ChangeNotifier{
   String userId;
   String username;
   String email;
   String avatar;
   double level;

  User({required this.userId,required this.username,required this.email,required this.avatar,required this.level});
}

class Groups extends ChangeNotifier {
  int groupId = -1;
  String groupName = "";
  String leaderId = "";
  String leaderName = "";
  String pathOfImage = "";
  List<String> memberId = [];
  List<String> memberName = [];
  Groups(this.groupId, this.groupName, this.leaderId, this.leaderName,
      this.memberId,this.memberName,this.pathOfImage);
}

class Message {
  final String userId;
  final String username;
  final String message;
  //final DateTime createdAt;

  const Message({
    required this.userId,
    required this.username,
    required this.message,
    //required this.createdAt,
  });
}