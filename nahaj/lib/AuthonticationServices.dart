import 'package:firebase_auth/firebase_auth.dart';

class AuthonticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign up
  Future createNewUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }
  //sign in

  //sign out
}
