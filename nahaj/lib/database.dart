// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  }

  Future<void> addNewUser(String name, String email, String uid) async {
    return await user
        .add({'name': name, 'email': email, 'ID': uid})
        .then((value) => print("user added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<dynamic> loadImage(String path, String image) async {
    //path is the folder after the root on storage firebase
    //name of the image with extention
    return await firestorage.ref(path).child(image).getDownloadURL();
  }

  //sign up
  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DataBase().addNewUser(name, email, user!.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
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
}
