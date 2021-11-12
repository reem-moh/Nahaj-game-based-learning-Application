import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String userId;
  String username;
  String email;
  String avatar;
  double level;

  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.avatar,
      required this.level});
}

class Groups{
  int goupCode = -1; //Code 
  String groupName ="";
  String leaderId ="";
  String leaderName = "";
  String pathOfImage = "";
  List members =[{}];

  Groups({required this.goupCode,required this.groupName,required this.leaderId, required this.leaderName,required this.pathOfImage,required this.members});

  Groups.fromJson(Map parsedJson) { 
    goupCode = parsedJson['code'] ?? -1;
    groupName = parsedJson['groupName'] ?? '';
    leaderId = parsedJson['leaderId'] ?? '';
    leaderName = parsedJson['leaderName'] ?? '';
    pathOfImage = parsedJson['pathOfImage'] ?? '';
    members = parsedJson['members'] ?? [{}];
  }
  
  Map<String, dynamic> toJson() =>
  {
    'code': goupCode,
    'groupName': groupName,
    'leaderId': leaderId,
    'leaderName': leaderName,
    'pathOfImage': pathOfImage,
    'members': members,
  };

  

}

class Message {
  final String userId;
  final String username;
  final String message;
  final String createdAt;

  const Message({
    required this.userId,
    required this.username,
    required this.message,
    required this.createdAt,
  });
}

class Chatroom {
  final String groupName;
  final String groupId;
  List<Message> chat;

  Chatroom({
    required this.groupName,
    required this.groupId,
    required this.chat,
  });
}

class ExperimentInfo {
  String name;
  String category;
  String info;
  String pathOfImage;
  double totalScore;
  double experimentScore;
  List<Question> questions;

  ExperimentInfo({
    required this.name,
    required this.category,
    required this.info,
    required this.pathOfImage,
    required this.totalScore,
    required this.experimentScore,
    required this.questions,
  });
}

class Question {
  String question;
  List<String> answers;
  String correctAnswer;
  double score;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.score,
  });
}
