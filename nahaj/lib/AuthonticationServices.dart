import 'package:firebase_auth/firebase_auth.dart';
import 'package:nahaj/database.dart';

class AuthonticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final DataBase db;
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
  //sign out
}
