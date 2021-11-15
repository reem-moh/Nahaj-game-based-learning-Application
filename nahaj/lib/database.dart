// Import the firebase_core and cloud_firestore plugin
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NahajClasses/Chats.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage firestorage = FirebaseStorage.instance;

class DataBase extends ChangeNotifier {
  late FirebaseAuth _auth;
  late CollectionReference user;
  late CollectionReference groups;

  DataBase() {
    _auth = FirebaseAuth.instance;
    user = firestore.collection('user');
  }

  //sign up 1 (add the user in Auth)
  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("createNewUser, database page");
      print(result.user);
      //User user = result.user;
      await addNewUser(name, email, result.user!.uid);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email, database page');
      }
    } catch (e) {
      print('database page \n' + e.toString());
    }
  }

  //sign up 2 (add the user in Firestore)
  Future<void> addNewUser(String name, String email, String uid) async {
    // Call the user's CollectionReference to add a new user
    return await user
        .doc(uid)
        .set({
          'name': name,
          'email': email,
          //default avatar values:
          'avatar':
              "https://firebasestorage.googleapis.com/v0/b/nahaj-6104c.appspot.com/o/Avatar%2Fowl.png?alt=media&token=1e5f590d-ce96-4f4a-82d0-5a455d197585",
          'level': 0.0,
        })
        .then((value) => print("User Added, database page"))
        .catchError(
            (error) => print("database page, Failed to add user: $error"));
  }

  //sign in
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print('database page, ' + e.toString());
    }
  }

  //reset password function (in Auth)
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('database page, ' + e.toString());
    }
  }

  //Store user info in session
  Future<dynamic> userInfo(String uid) async {
    String name = '1';
    String email = '1';
    String avatar = '1';
    double level = 0.0;

    await user.doc(uid).get().then((value) {
      print('read from firestore: \n ' +
          value.get("email") +
          ' ' +
          value.get("name") +
          ' ' +
          value.get("avatar"));
      name = value.get('name');
      email = value.get("email");
      avatar = value.get("avatar");
      level = value.get("level");
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', uid);
    prefs.setString('username', name);
    prefs.setString('avatar', avatar);
    prefs.setDouble('level', level);
    prefs.setString('email', email);
    return true;
  }

  //Signout
  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await _auth.signOut();
  }

  //Get avatar image from Firestorage
  Future<String> loadImage(String path) async {
    //path is the folder after the root on storage firebase
    //name of the image with extention
    return await firestorage.ref(path).getDownloadURL();
  }

  Future<String> storeImage(String destination, File path) async {
    try {
      Reference ref = firestorage.ref(destination);
      print('path.toString()' + path.toString());

      await ref.putFile(path);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(
          "error occure when store image in firestorage, method:storeImage class: DB error: $e");
    }
    return "-1";
  }

  //get groups of the user
  Future<List<Groups>> getGroups(String uid, String uName) async {
    print("inside getGroups");

    Map member = {'userName': uName, 'userId': uid};
    List<Groups> groupsInfo = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Groups')
        .where('members', arrayContains: member)
        .get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        print("in (getGroups, DB) : groupName ->" + data['groupName']!);
        List membersInDB = data['members'] ?? [{}];
        membersInDB.forEach((map) {
          print("$map:");
        });
        Groups g = new Groups.fromJson(data);
        groupsInfo.add(g);
      }
    }
    return groupsInfo;
  }

  Future<void> createGroup(int code, String groupName, String leaderName,
      String leaderId, String pathOfImage) async {
    //add to group collection
    final groupDocument = firestore.collection('Groups').doc();

    List<Map> members = [
      {
        'userId': leaderId,
        'userName': leaderName,
      }
    ];

    Groups _Obj = new Groups(
        goupCode: code,
        groupId: groupDocument.id,
        groupName: groupName,
        leaderId: leaderId,
        leaderName: leaderName,
        pathOfImage: pathOfImage,
        members: members);

    groupDocument
        .set(_Obj.toJson())
        .then((value) => print("Group created"))
        .catchError((error) => print("Failed to create group: $error"));
    //to add more on members array using groupDocument.updateData rather than groupDocument.set
    createChat(groupDocument.id, groupName);
  }

  Future<bool> checkGroupCode(int code) async {
    bool isFound = false;
    //read the list of groups from
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Groups')
        .where('code', isEqualTo: code)
        .get();

    if (snapshot.docs.length >= 1) {
      print("inside checkGroupCode more than one doc have the same code ");
      isFound = true;
    } else {
      print("only one unique value");
    }

    return isFound;
  }

  Future<String> joinGroup(int groupCode, String userId, String userName) async {
    print(
        "in (joinGroup,DB) groupId: $groupCode, userID: $userId, userName: $userName");

    String groupId = await findGroup(groupCode);

    if (groupId == '-1') {
      return '-1';
    }

    var docRef = firestore.collection('Groups').doc(groupId);
    print('docRef: $docRef');

    var doc = await docRef.get();
    var data = doc.data() as Map<String, dynamic>;
    var inGroup = false;

    List<Map> members = [
      {
        'userId': userId,
        'userName': userName,
      }
    ];

    List membersInDB = data['members'] ?? [{}];
    print("****************************");
    membersInDB.forEach((map) {
      print("$map:");
      if (map['userId'] == userId) {
        print("inside if v == userId value");
        inGroup = true;
      }
      members.add(map);
    });

    print("****************************");

    if (!inGroup) {
      print("inside !inGroup");
      docRef.update({
        "members": members,
        //"membersCounter": ++data['membersCounter'],
      });
    }
    return 'join group success';
  }

  Future<String> findGroup(int groupCode) async {
    var collection =
        firestore.collection('Groups').where('code', isEqualTo: groupCode);

    var querySnapshot = await collection.get();
    if (querySnapshot.docs.length == 0) {
      print(
          "there is no group has this code, (findGroup, database)\n$querySnapshot\n${querySnapshot.docs}");
      return '-1';
    }
    return querySnapshot.docs[0].reference.id;
  }

 /* removeUserFromGroup(String groupId, String userId, String userName) {
    var docRef = firestore.collection('Groups').doc(groupId);
    List deletedMember = [];
    deletedMember.add({
      "userId": userId,
      "userName": userName,
    });
    docRef.update({
      "members": FieldValue.arrayRemove(deletedMember),
    });
  }*/

                 /* for Chat */
  void createChat(String groupId, String groupName)  {
    //add to group collection
    if (groupId == '-1') {
      return ;
    }
    final chatDocument = firestore.collection('Chats').doc(groupId);
    List<Map> messages = [];

    Message mssg = new Message(groupId: groupId,groupName: groupName, messages: messages);

    chatDocument
        .set(mssg.toJson())
        .then((value) => print("Group created"))
        .catchError((error) => print("Failed to create group: $error"));
  }
  
  Future uploadMessage(String groupId,String userId,String userName, String message) async {

    if (groupId == '-1') {
      return ;
    }

    var refMessages = firestore.collection('Chats').doc(groupId);
    print('docRef: $refMessages');

    Chat c= new Chat(userId: userId, username: userName, message: message, createdAt: DateTime.now());
    List<Map> chattt = [c.toJson()];

    refMessages.update({
     "messages":  FieldValue.arrayUnion(chattt)
    });
    
  }
  
  
  
  
  
  void /*Stream<Message>*/ getChat(int groupCode,String groupId,String groupName) {
  
    //return retriveMessages(groupCode, groupId,groupName);
  }

  /*Stream<Message> retriveMessages(int goupCode,String groupId,String groupName) =>
        FirebaseFirestore
        .instance
        .collection('Chats/$groupId')
        .orderBy('createdAt', descending: true)
        .snapshots().transform(Utils.transformer(Chat.fromJson) as StreamTransformer<QuerySnapshot<Map<String, dynamic>>, Message>);
  *//*{

    var snapshot = FirebaseFirestore
        .instance
        .collection('Chats/$groupId')
        .orderBy('createdAt', descending: true)
        .snapshots().transform(Utils.transformer(Chat.fromJson));
        //.get() as QuerySnapshot<Map<String, dynamic>>;

    List chats = [{}];
    
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        print("in (getGroups, DB) : groupName ->" + data['groupName']!);
        chats = data['messages'] ?? [{}];
          chats.forEach((map) {
            print("$map:");
          });
        Chat c = new Chat.fromJson(data['messages']);
        chats.add(c.toJson());
      }
    }

    return Message(groupId: groupId,messages:chats);
  }*/

  getMessages(String groupId){

  }
  /*static Stream<List<Message>> getMessages(String groupId) {
    Message m = Message.fromJson(); 
    Stream<QuerySnapshot<Map<String, dynamic>>> mssgfirestore
            .collection('Chats')
            .doc(groupId)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots();

  }*/
}
