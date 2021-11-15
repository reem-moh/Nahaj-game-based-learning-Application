class Message {
  String groupId = '';
  List messages =[{}]; //chat

  Message({
    required this.groupId,
    required this.messages,
  });

  Message.fromJson(Map<String, dynamic> parsedJson){ 
        groupId = parsedJson['groupId'] ?? '';
        messages = parsedJson['messages'] ?? [{}];
   }
  
   Map<String, dynamic> toJson() =>
  { 'groupId': groupId,
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
