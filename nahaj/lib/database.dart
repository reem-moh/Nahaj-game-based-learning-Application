// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  //sign up 1 (add the user in Auth)
  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("createNewUser, database page");
      print(result.user);
      User? user = result.user;
      await addNewUser(name, email, user!.uid);
      return user;
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
    prefs.setString('id', uid);
    prefs.setString('username', name);
    prefs.setString('avatar', avatar);
    prefs.setDouble('level', level);
    prefs.setString('email', email);
    return true;
  }

  //Get avatar image from Firestorage
  Future<dynamic> loadImage(String path, String image) async {
    //path is the folder after the root on storage firebase
    //name of the image with extention
    return await firestorage.ref(path).child(image).getDownloadURL();
  }
}
