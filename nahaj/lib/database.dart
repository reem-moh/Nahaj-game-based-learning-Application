// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'child.dart';

class DataBase extends ChangeNotifier {
  late FirebaseAuth _auth;
  //for data
  late FirebaseFirestore firestore;
  //for images and videos
  late FirebaseStorage firestorage;
  //contain the user account info
  late CollectionReference user;

  DataBase() {
    firestore = FirebaseFirestore.instance;
    firestorage = FirebaseStorage.instance;
    _auth = FirebaseAuth.instance;
    user = firestore.collection('user');
  }

  //sign up 1
  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("createNewUser !!!");
      print(result.user);
      User? user = result.user;
      await addNewUser(name, email, user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //sign up 2
  Future<void> addNewUser(String name, String email, String uid) async {
    // Call the user's CollectionReference to add a new user
    //because we want the same id of auth we can't use add method..
    return await user
        .doc(uid)
        .set({
          'name': name,
          'email': email,
          //default values:
          'avatar': "https://firebasestorage.googleapis.com:443/v0/b/nahaj-6104c.appspot.com/o/Avatar%2Fanimals.png?alt=media&token=734cf7d9-83e0-41d8-9249-c3b5b8144dc3",
          'level': 0.0,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //sign in
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> userInfo(String uid) async {
    /*
    await user.doc(uid).get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
      print('the data inside userInfo: \n ${data['name']} ${data['email']}');
      return new Child(data['name'], data['email'], data['avatar'],
          data['level'].toDouble());
    }).catchError((error) => print("Failed to read userInfo: $error"));
    */
    return new Child('', '', '', 0);
  }

  Future<dynamic> loadImage(String path, String image) async {
    //path is the folder after the root on storage firebase
    //name of the image with extention
    return await firestorage.ref(path).child(image).getDownloadURL();
  }
}
