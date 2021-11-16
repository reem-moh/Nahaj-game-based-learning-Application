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

  Stream<List<Groups>> getGroupsList(String uid, String uName) {
    Map member = {'userName': uName, 'userId': uid};

    return firestore
        .collection('Groups')
        .where('members', arrayContains: member)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Groups.fromJson(document.data()))
            .toList());
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

  Future<String> joinGroup(
      int groupCode, String userId, String userName) async {
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
  void createChat(String groupId, String groupName) {
    //add to group collection
    if (groupId == '-1') {
      return;
    }
    final chatDocument = firestore.collection('Chats').doc(groupId);
    var addChat = Map<String, dynamic>();
    addChat['groupId'] = groupId;
    addChat['groupName'] = groupName;

    chatDocument
        .set(addChat)
        .then((value) => print("Groupchat created"))
        .catchError((error) => print("Failed to create groupchat: $error"));
  }

  Future uploadMessage(
      String groupId, String userId, String userName, String message) async {
    if (groupId == '-1') {
      return;
    }

    var refMessages =
        firestore.collection('Chats').doc(groupId).collection('Messages').doc();
    print('docRef: $refMessages');

    Chat c = new Chat(
        userId: userId,
        username: userName,
        message: message,
        createdAt: DateTime.now());
    List<Map> chattt = [c.toJson()];

    refMessages
        .set(c.toJson())
        .then((value) => print("Groupchat created"))
        .catchError((error) => print("Failed to create groupchat: $error"));
  }

  Stream<List<Chat>> getMessagesList(String groupId) {
    return firestore
        .collection('Chats')
        .doc(groupId)
        .collection('Messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Chat.fromJson(document.data()))
            .toList());
  }

  Stream<List<ExperimentInfo>> getExperiments(String category) {
    /*List<ExperimentInfo> experiments = [];
    QuerySnapshot querySnapshot =
        await */
    return firestore
        .collection('Experiments')
        .where('Category', isEqualTo: category)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ExperimentInfo.fromJson(document.data()))
            .toList());

    // Get data from docs and convert map to List
    /*var docs = querySnapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        print("in (getExperiments, DB) : name ->" + data['Name']!);

        ExperimentInfo exp = new ExperimentInfo.fromJson(data);
        exp.id = doc.id;
        experiments.add(exp);
      }
    }

    print(experiments.isNotEmpty ? experiments.first.sceneIndex : "empty");
    return experiments;*/
  }
}
