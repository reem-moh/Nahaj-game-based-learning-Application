// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;

  DataBase() {
    firestore = FirebaseFirestore.instance;
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
}
