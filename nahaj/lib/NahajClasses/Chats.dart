import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
class Message {
  String groupId = '';
  String groupName= '';
  List messages =[{}]; //chat

  Message({
    required this.groupId,
    required this.groupName,
    required this.messages,
  });

  Message.fromJson(Map<String, dynamic> parsedJson){ 
        groupId = parsedJson['groupId'] ?? '';
        groupName = parsedJson['groupName'] ?? '';
        messages = parsedJson['messages'] ?? [{}];
   }
  
   Map<String, dynamic> toJson() =>
  { 'groupId': groupId,
    'groupName': groupName,
    'messages': messages,
  };


}

class Chat {
  String userId = '';
  String username= '';
  String message = '';
  DateTime createdAt = DateTime.now();

  Chat({
    required this.userId,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  Chat.fromJson(Map<String, dynamic> parsedJson){ 
        userId = parsedJson['userId']?? "";
        username = parsedJson['username'] ??"";
        message = parsedJson['message'] ?? '';
        createdAt = parsedJson['createdAt'].toUtc();
  }
  
  Map<String, dynamic> toJson() =>
  { 
    'userId': userId,
    'username': username,
    'message': message,
    'createdAt': createdAt.toUtc(),
  };

}

class Utils {
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json as Map<String, dynamic>)).toList();

          sink.add(users);
        },
      );
}
