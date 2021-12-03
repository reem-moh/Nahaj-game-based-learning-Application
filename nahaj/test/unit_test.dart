import 'package:flutter_test/flutter_test.dart';
import 'package:nahaj/presenter.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

final tUser = MockUser(
  uid: 'E0Qted5gY0Mm5ZKkGjJvE6Rv4b32',
  email: 'reem@gmail.com',
);

class MockPresenter extends Mock implements DataBase {
  @override
  //sign up 1 (add the user in Auth)
  Future createNewUser(String name, String email, String password) async {
    final auth = MockFirebaseAuth(mockUser: tUser);
    final result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print("createNewUser, database page");
    print(result.user);
    //User user = result.user;
    await addNewUser(name, email, result.user!.uid);
    return result.user;
  }

  @override
  //sign up 2 (add the user in Firestore)
  Future addNewUser(String name, String email, String uid) async {
    // Call the user's CollectionReference to add a new user
    bool done = false;
    final instance = FakeFirebaseFirestore();
    await instance
        .collection('user')
        .doc(uid)
        .set({
          'name': name,
          'email': email,
          //default avatar values:
          'avatar':
              "https://firebasestorage.googleapis.com/v0/b/nahaj-6104c.appspot.com/o/Avatar%2Fowl.png?alt=media&token=1e5f590d-ce96-4f4a-82d0-5a455d197585",
          'level': 0,
          'userId': uid,
        })
        .then((value) => done = true)
        .catchError(
            // ignore: invalid_return_type_for_catch_error
            (error) => print("database page, Failed to add user: $error"));
    return done;
  }
}

void main() {
  MockPresenter db = MockPresenter();
  setUp(() async {});
  tearDown(() {});

  test('sign up with email and password', () async {
    final result = db.addNewUser('طيف', 'taif@gmail.com', '12345678');
    expect(await result as bool, true);
  });
}
