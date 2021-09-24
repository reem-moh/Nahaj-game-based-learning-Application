// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataBase extends ChangeNotifier{

  //for data
  late FirebaseFirestore firestore;
  //for images and videos
  late FirebaseStorage firestorage;
  //contain the user account info
  late CollectionReference users;

  DataBase() {
    firestore = FirebaseFirestore.instance;
    firestorage = FirebaseStorage.instance;

  }

  Future<void> addUser(String fullName, String company, int age) {
    // Call the user's CollectionReference to add a new user
    return firestore
        .collection('users')
        .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<dynamic> loadImage(String path,String image) async {
    //path is the folder after the root on storage firebase
    //name of the image with extention
    return await firestorage.ref(path).child(image).getDownloadURL();
  }
}
