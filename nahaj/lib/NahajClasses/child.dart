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

class Groups {
  int goupCode = -1; //Code
  String groupId = '';
  String groupName = "";
  String leaderId = "";
  String leaderName = "";
  String pathOfImage = "";
  List members = [{}];

  Groups(
      {required this.goupCode,
      required this.groupId,
      required this.groupName,
      required this.leaderId,
      required this.leaderName,
      required this.pathOfImage,
      required this.members});

  Groups.fromJson(Map parsedJson) {
    goupCode = parsedJson['code'] ?? -1;
    groupId = parsedJson['groupId'] ?? '';
    groupName = parsedJson['groupName'] ?? '';
    leaderId = parsedJson['leaderId'] ?? '';
    leaderName = parsedJson['leaderName'] ?? '';
    pathOfImage = parsedJson['pathOfImage'] ?? '';
    members = parsedJson['members'] ?? [{}];
  }

  Map<String, dynamic> toJson() => {
        'code': goupCode,
        'groupId': groupId,
        'groupName': groupName,
        'leaderId': leaderId,
        'leaderName': leaderName,
        'pathOfImage': pathOfImage,
        'members': members,
      };
}

class ExperimentInfo {
  String id = '';
  int sceneIndex = 0;
  String name = '';
  String category = '';
  String info = '';
  String pathOfImage = '';
  int totalScore = 0;
  int userScore = 0;
  int experimentScore = 0;
  List questions = [{}];

  ExperimentInfo({
    required this.name,
    required this.category,
    required this.info,
    required this.pathOfImage,
    required this.totalScore,
    required this.userScore,
    required this.experimentScore,
    required this.questions,
  });

  ExperimentInfo.fromJson(Map parsedJson) {
    name = parsedJson['Name'] ?? '';
    id = parsedJson['ExpID'] ?? '';
    sceneIndex = parsedJson['SceneIndex'] ?? 0;
    category = parsedJson['Category'] ?? '';
    info = parsedJson['Info'] ?? '';
    pathOfImage = parsedJson['PathOfImage'] ?? '';
    totalScore = parsedJson['TotlaScore'] ?? 0;
    userScore = parsedJson['UserScore'] ?? 0;
    experimentScore = parsedJson['ExperimentScore'] ?? 0;
    questions = [{}];
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'SceneIndex': sceneIndex,
        'Category': category,
        'Info': info,
        'PathOfImage': pathOfImage,
        'TotlaScore': totalScore,
        'UserScore': userScore,
        'ExperimentScore': experimentScore,
      };
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
