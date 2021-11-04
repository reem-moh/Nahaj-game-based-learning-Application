import 'package:flutter/material.dart';
import 'package:nahaj/addGroup2.dart';
import 'package:nahaj/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart';
import 'dart:math';

class AddGroup extends StatefulWidget {
  final DataBase db;
  AddGroup({Key? key, required this.db}) : super(key: key);

  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup> {
  final _key = GlobalKey<FormState>();

  String name = "";
  bool validName = false;
  String username = "1";
  String uid = "0";
  //to let user enter _getInfoFromSession only one
  bool entere = true;

  Future<void> _getInfoFromSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? "1");
      print('username inside getinfo from addGroup:' + username);
      uid = (prefs.getString('id') ?? "1");
      print('id inside getinfo from addGroup:' + uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(entere){
      _getInfoFromSession();
      entere=false;
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
                    //Back button
                    // ignore: deprecated_member_use

                    //Nahaj logo
                    FlatButton(
                      child:
                          /*
                        Image(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1,
                          image: AssetImage("assets/Groupimage.png"),alignment: Alignment.topCenter,),
                          */
                          Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 40),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset("assets/owl1.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: new BorderRadius.circular(40.0),
                            child: Image.asset("assets/EditImage.png",
                                height: 150, width: 1000),
                          ),
                        ],
                      ),
                      onPressed: () {
                        changeImage();
                      },
                    ),
                  ],
                ),
              ),
              //Name
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 950),
                  child: Text(
                    ": الاسم ",
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
                      createGroup(name, widget.db);
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddGroup2(
                                    db: widget.db,
                                  )),
                        );
                      });
                      //createGroup(name);
                    },
                    padding: EdgeInsets.all(0.0),
                    color: Color.fromARGB(255, 129, 190, 255),
                    textColor: Colors.white,
                    child: Text(
                      "إنشاء ",
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

void createGroup(String groupName, DataBase db) async {
    //check if the name of group greater than 3 character
    if (validName) {
      
      int code = 0;
      bool isFound = true;
      //check if code is not genetrated before
      while(isFound){
        //722933;
        code = Random().nextInt(1000000);
        
        isFound = await widget.db.checkGroupCode(code);
      }
      widget.db.createGroup(code, groupName, username, uid,"");
    }
  }
}

void changeImage() async {}
