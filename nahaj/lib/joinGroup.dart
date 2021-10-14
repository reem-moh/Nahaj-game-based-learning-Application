import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addGroup2.dart';
import 'database.dart';
import 'homePage.dart';

class JoinGroup extends StatefulWidget {
  final DataBase db;
  const JoinGroup({Key? key, required this.db}) : super(key: key);

  @override
  _JoinGroup createState() => _JoinGroup();
}

class _JoinGroup extends State<JoinGroup> {
  final _key = GlobalKey<FormState>();

  String name = "";
  bool validName = false;
  String username = "1";
  String uid = "0";

  Future<void> _getInfoFromSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? "1");
      print('username inside getinfo from JoinGroup:' + username);
      uid = (prefs.getString('id') ?? "1");
      print('id inside getinfo from JoinGroup:' + uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getInfoFromSession();
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/SignUpSignInbackground.png"),
                    fit: BoxFit.cover)),
          ),
          //list view container
          ListView(
            key: _key,
            children: [
              FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 1050),
                  child: Image(
                    image: AssetImage("assets/PreviosButton.png"),
                    alignment: Alignment.topLeft,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                db: widget.db,
                              )),
                    );
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        width: MediaQuery.of(context).size.width / 1.09,
                        height: MediaQuery.of(context).size.height / 4.18,
                        image: AssetImage("assets/nahajLogo.png"))
                  ],
                ),
              ),
              //Name
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 900),
                  child: Text(
                    ": رمز المجموعة ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),

              //Name text field
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      /*onChanged: (val) {
                          name = val;
                        },*/
                      validator: (val) {
                        if (val!.length <= 0) {
                          validName = false;
                          return 'هذا الحقل مطلوب';
                        } else if (val.length <= 2) {
                          validName = false;
                          print("name is not valid");
                          return 'الإسم يجب أن يكون من ثلاثة أحرف أو أكثر';
                        } else {
                          validName = true;
                          name = val;
                        }
                        /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                        return null;
                      },
                    )),
              ),

              Container(
                margin: EdgeInsets.all(10),
                height: 60.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: Color.fromARGB(255, 129, 190, 255))),
                    onPressed: () {
                      print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
                      ToJoinGroup(name, uid);
                      //createGroup(name);
                    },
                    padding: EdgeInsets.all(0.0),
                    color: Color.fromARGB(255, 129, 190, 255),
                    textColor: Colors.white,
                    child: Text(
                      "انضمام ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
ToJoinGroup(String groupId, String userModel) async {
  CollectionReference groups = firestore.collection("Groups");
  String membersCounter = '0';

  await groups.doc("fbFCVDbnwQwlY476HVL0").get().then((value) {
    print('read from firestore: \n ' + value.get("membersCounter"));
    membersCounter = value.get('membersCounter');
  }).catchError((error) => print("Failed to join group: $error"));

  if (int.parse(membersCounter) < 20 && int.parse(membersCounter) != 0) {
    var NweMember = "member$membersCounter";
    firestore.collection("Groups").doc("fbFCVDbnwQwlY476HVL0").set({
      "members": FieldValue.arrayUnion(userModel as List<String>),
      "membersCounter": int.parse(membersCounter) + 1
    }, SetOptions(merge: true));
  }
}
