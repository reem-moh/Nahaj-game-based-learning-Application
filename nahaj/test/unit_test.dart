/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/presenter.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

final tUser = MockUser(
  uid: 'E0Qted5gY0Mm5ZKkGjJvE6Rv4b32',
  email: 'reem@gmail.com',
  displayName: 'ريم',
);
final instanceFirestore = FakeFirebaseFirestore();
final auth = MockFirebaseAuth(mockUser: tUser);

class MockPresenter extends Mock implements DataBase {
  //sign up (add the user in Firestore) ✅
  @override
  Future addNewUser(String name, String email, String uid) async {
    // Call the user's CollectionReference to add a new user
    bool done = false;
    await instanceFirestore
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

//sign in ✅
  @override
  Future loginUser(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print('database page, ' + e.toString());
    }
  }

//update user level after experiment ✅
  @override
  Future updateUserLevel(String userId, int level) async {
    instanceFirestore.collection('user').doc(userId).update({'level': level});
  }

  //get groups of the user ✅
  @override
  Stream<List<Groups>> getGroupsList(String uid, String uName) {
    Map member = {'userId': uid};
    return instanceFirestore
        .collection('Groups')
        .where('members', arrayContains: member)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Groups.fromJson(document.data()))
            .toList());
  }

// get Experiments for user ✅
  @override
  Stream<List<ExperimentInfo>> getExperiments(String category) {
    return instanceFirestore
        .collection('Experiments')
        .where('Category', isEqualTo: category)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ExperimentInfo.fromJson(document.data()))
            .toList());
  }

  //get Questions for user ✅
  @override
  Stream<List<Question>> getQuestions(String expID) {
    return instanceFirestore
        .collection('Experiments')
        .doc(expID)
        .collection('Questions')
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => Question.fromJson(document.data()))
            .toList());
  }

  //add Q ✅
  @override
  Future<bool> addNewQuestion(
      String question,
      String correctAnswer,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      int score,
      String expID) async {
    // Call the user's CollectionReference to add a new user
    bool done = false;
    await instanceFirestore
        .collection('Experiments')
        .doc(expID)
        .collection('Questions')
        .add({
          'Question': question,
          'ExpID': expID,
          'CorrectAnswer': correctAnswer,
          'Score': score,
          'Answer1': answer1,
          'Answer2': answer2,
          'Answer3': answer3,
          'Answer4': answer4,
        })
        .then((value) => done = true)
        .catchError(
            (error) => print("database page, Failed to add user: $error"));
    return done;
  }

  @override
  removeUserFromGroup(String groupId, String userId) {
    bool done = false;
    var docRef = instanceFirestore.collection('Groups').doc(groupId);
    List deletedMember = [];
    deletedMember.add({
      "userId": userId,
    });
    docRef.update({
      "members": FieldValue.arrayRemove(deletedMember),
    }).then((value) => done = true);
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

  test('sign in with email and password', () async {
    final result = db.loginUser('reem@gmail.com', '12345678');
    //check the user id for sucess or failure
    expect((await result as Auth.User).uid, tUser.uid);
  });

  test('update user level after experiment', () async {
    db.updateUserLevel(tUser.uid, 6);
    expect(
        (await instanceFirestore
            .collection('user')
            .doc(tUser.uid)
            .get())['level'],
        equals(6));
  });

  test('get user\'s groups', () async {
    final result = db.getGroupsList(tUser.uid, tUser.displayName!);
    bool actual = await result.isEmpty;
    expect(actual, false);
  });

  test('get experiments of a specific category', () async {
    final result = db.getExperiments('الكيمياء');
    bool actual = await result.isEmpty;
    expect(actual, false);
  });

  test('get questions of an experiments', () async {
    final result = db.getQuestions('EC9BomGkVs0EGBodta1W');
    bool actual = await result.isEmpty;
    expect(actual, false);
  });

  test('add a question to an experiments', () async {
    String q = 'ما هو نوع التجربة؟';
    String cA = 'كيميائية';
    String a1 = 'حيوانات';
    String a2 = 'نباتات';
    String a3 = 'فيزيائية';
    String a4 = 'كيميائية';
    final result = await db.addNewQuestion(
        q, cA, a1, a2, a3, a4, 5, 'EC9BomGkVs0EGBodta1W');
    expect(result, true);
  });

  test('remove a user from a specific group', () async {
    final result =
        await db.removeUserFromGroup('BCWJ04QssnAulfCXw9Pf', tUser.uid);
    expect(result, false);
  });
}*/
