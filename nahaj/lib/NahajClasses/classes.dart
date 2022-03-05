import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String userId = '';
  String username = '';
  String email = '';
  String avatar = '';
  int level = -1;

  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.avatar,
      required this.level});

  User.fromJson(Map parsedJson) {
    userId = parsedJson['userId'] ?? '';
    username = parsedJson['name'] ?? '';
    email = parsedJson['email'] ?? '';
    avatar = parsedJson['avatar'] ?? '';
    level = parsedJson['level'] ?? -1;
  }
}

class Admin extends ChangeNotifier {
  String adminId = '';
  String adminName = '';
  String email = '';

  Admin({
    required this.adminId,
    required this.adminName,
    required this.email,
  });

  Admin.fromJson(Map parsedJson) {
    adminId = parsedJson['userId'] ?? '';
    adminName = parsedJson['name'] ?? '';
    email = parsedJson['email'] ?? '';
  }
}

class Groups {
  int goupCode = -1; //Code
  String groupId = '';
  String groupName = "";
  String leaderId = "";
  String leaderName = "";
  String groupImage = "";
  List members = [{}];

  Groups(
      {required this.goupCode,
      required this.groupId,
      required this.groupName,
      required this.leaderId,
      required this.leaderName,
      required this.groupImage,
      required this.members});

  Groups.fromJson(Map parsedJson) {
    goupCode = parsedJson['code'] ?? -1;
    groupId = parsedJson['groupId'] ?? '';
    groupName = parsedJson['groupName'] ?? '';
    leaderId = parsedJson['leaderId'] ?? '';
    leaderName = parsedJson['leaderName'] ?? '';
    groupImage = parsedJson['pathOfImage'] ?? '';
    members = parsedJson['members'] ?? [{}];
  }

  Map<String, dynamic> toJson() => {
        'code': goupCode,
        'groupId': groupId,
        'groupName': groupName,
        'leaderId': leaderId,
        'leaderName': leaderName,
        'pathOfImage': groupImage,
        'members': members,
      };
}

class ExperimentInfo {
  String id = '';
  String sceneIndex = '';
  String name = '';
  String category = '';
  String info = '';
  String expImage = '';
  int totalScore = 0;
  int experimentScore = 0;

  ExperimentInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.info,
    required this.expImage,
    required this.totalScore,
    //required this.userScore,
    required this.experimentScore,
  });

  ExperimentInfo.fromJson(Map parsedJson) {
    name = parsedJson['Name'] ?? '';
    id = parsedJson['ExpID'] ?? '';
    sceneIndex = parsedJson['SceneIndex'] ?? '';
    category = parsedJson['Category'] ?? '';
    info = parsedJson['Info'] ?? '';
    expImage = parsedJson['PathOfImage'] ?? '';
    totalScore = parsedJson['TotlaScore'] ?? 0;
    experimentScore = parsedJson['ExperimentScore'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'SceneIndex': sceneIndex,
        'Category': category,
        'Info': info,
        'PathOfImage': expImage,
        'TotlaScore': totalScore,
        //'UserScore': userScore,
        'ExperimentScore': experimentScore,
      };
}

class Question {
  String question = '';
  String id = '';
  String expID = '';
  List<String> answers = [''];
  String correctAnswer = '';
  int score = 0;

  Question({
    required this.id,
    required this.expID,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.score,
  });

  Question.fromJson(Map parsedJson) {
    question = parsedJson['Question'] ?? '';
    id = parsedJson['QID'] ?? '';
    expID = parsedJson['ExpID'] ?? '';
    correctAnswer = parsedJson['CorrectAnswer'] ?? '';
    score = parsedJson['Score'] ?? 0;
    answers = [
      parsedJson['Answer1'] ?? '',
      parsedJson['Answer2'] ?? '',
      parsedJson['Answer3'] ?? '',
      parsedJson['Answer4'] ?? ''
    ];
  }

  Map<String, dynamic> toJson() => {
        'Question': question,
        'QID': id,
        'ExpID': expID,
        'CorrectAnswer': correctAnswer,
        'Score': score,
        'Answer1': answers[0],
        'Answer2': answers[1],
        'Answer3': answers[2],
        'Answer4': answers[3],
      };
}
