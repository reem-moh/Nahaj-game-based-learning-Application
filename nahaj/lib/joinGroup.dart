import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  int groupCode = -1;
  bool validName = false;
  String username = "1";
  String uid = "0";
  bool enter = true;

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
    if (enter) {
      _getInfoFromSession();
      enter = false;
    }
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
              //backbutton
              TextButton(
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
              //logo
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
              //انضمام للمجموعه
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

              //Code text field
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                //Code text field
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.length <= 0) {
                          validName = false;
                          return 'هذا الحقل مطلوب';
                        } else if (val.length <= 5) {
                          validName = false;
                          print("groupCode is not valid");
                          return 'الرمز يجب أن يكون من ٦ أرقام أو أكثر';
                        } else {
                          validName = true;
                          if (int.tryParse(val) == null) {
                            return 'Only Number are allowed';
                          }
                          groupCode = int.parse(val);
                        }
                        /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                        return null;
                      },
                    )),
              ),

              //button
              Container(
                margin: EdgeInsets.all(10),
                height: 60.0,
                //button
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: Color.fromARGB(255, 129, 190, 255))),
                    onPressed: () async {
                      //group code is shorter than usual
                      if (validName) {
                        print("groupCode before enter join group: $groupCode");
                        String check = await joinGroup(groupCode);
                        //1 means added to the group
                        if (check == '1') {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        db: widget.db,
                                      )),
                            );
                          });
                        }
                      }
                    },
                    padding: EdgeInsets.all(0.0),
                    color: Color.fromARGB(255, 129, 190, 255),
                    textColor: Colors.white,
                    //text of button
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

  Future<String> joinGroup(int groupCode) async {
    //check if there is a group and if user in it .
    String groupId = await widget.db.joinGroup(groupCode, uid, username);
    if (groupId == "-1") {
      return "there is no group has this code!!";
    }

    if (groupId == "0") {
      return "you are in the group!!";
    }
    return "1";
  }
}
