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

class Groups extends ChangeNotifier {
  int groupId = -1;
  String groupName = "";
  String leaderId = "";
  String leaderName = "";
  String pathOfImage = "";
  List<String> memberId = [];
  List<String> memberName = [];
  Groups(this.groupId, this.groupName, this.leaderId, this.leaderName,
      this.memberId, this.memberName, this.pathOfImage);
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
