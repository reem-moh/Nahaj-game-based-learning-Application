import 'package:flutter/material.dart';
import 'package:nahaj/SignPages/Signin.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  final DataBase db;
  SignUp({Key? key, required this.db}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  final _key = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";
  String repeatedPassword = "";
  bool validName = false;
  bool validEmail = false;
  bool validPass = false;
  bool validRePass = false;
  bool loginErr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Back button
                      // ignore: deprecated_member_use
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 0),
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
                                  builder: (context) => Signin(
                                        db: widget.db,
                                      )),
                            );
                          });
                        },
                      ),
                      //Nahaj logo
                      Image(
                          width: MediaQuery.of(context).size.width / 1.09,
                          height: MediaQuery.of(context).size.height / 4.18,
                          image: AssetImage("assets/nahajLogo.png"))
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Name
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 0),
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
                  ],
                ),
                //Name text field
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
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
                //Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                        child: Text(
                          ":البريد الإلكتروني ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Email text field
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        /*onChanged: (val) {
                          email = val;
                        },*/
                        validator: (val) {
                          bool emailValid = RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(val!);
                          if (val.length <= 0) {
                            validEmail = false;
                            return 'هذا الحقل مطلوب';
                          } else if (!emailValid) {
                            validEmail = false;
                            print("email is not valid");
                            return 'الرجاء إدخال بريد إلكتروني صحيح';
                          } else if (emailValid) {
                            validEmail = true;
                            email = val;
                          }
                          /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                          return null;
                        },
                      )),
                ),
                //Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                        child: Text(
                          ":كلمة السر",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Password text field
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      /*onChanged: (val) {
                          password = val;
                        },*/
                      validator: (val) {
                        if (val!.length <= 0) {
                          validPass = false;
                          return 'هذا الحقل مطلوب';
                        } else if (val.length <= 7) {
                          validPass = false;
                          print("pass is not valid");
                          return 'كلمة المرور يجب أن تكون من ٨ أرقام أو أحرف أو أكثر';
                        } else {
                          validPass = true;
                          password = val;
                        }
                        /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                        return null;
                      },
                    ),
                  ),
                ),
                //Repeat password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 0),
                        child: Text(
                          ":إعادة كلمة السر ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Repeat password text field
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        /*onChanged: (val) {
                            repeatedPassword = val;
                          },*/
                        validator: (val) {
                          if (val!.length <= 0) {
                            validRePass = false;
                            return 'هذا الحقل مطلوب';
                          } else if (val != password) {
                            validRePass = false;
                            print("repass is not valid");
                            return 'كلمة المرور غير متطابقة';
                          } else if (val == password) {
                            validRePass = true;
                            repeatedPassword = val;
                          }
                          /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                          return null;
                        },
                      )),
                ),
                //Sign up button
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
                        // var validate = _key.currentState.validate();
                        //if (validate) {
                        createUser(name, email, password);
                        //}
                      },
                      padding: EdgeInsets.all(0.0),
                      color: Color.fromARGB(255, 129, 190, 255),
                      textColor: Colors.white,
                      child: Text(
                        "تسجيل ",
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
      ),
    );
  }

  void createUser(String name, String email, String password) async {
    if (validName && validEmail && validPass && validRePass) {
      dynamic result = await widget.db.createNewUser(name, email, password);
      if (result == null) {
        print("Sign up error");
      } else {
        print('Sign up page/ createUser!!!!');
        print(result.toString());

        dynamic authResutl = await widget.db.loginUser(email, password);
        if (authResutl == null) {
          print("login error");
        } else {
          final prefs = await SharedPreferences.getInstance();

          prefs.setString('userId', '');
          prefs.setString('username', '');
          prefs.setString('avatar', '');
          prefs.setDouble('level', -1.0);
          prefs.setString('email', '');
          
          print("log in Successuflly, signin page");
          await widget.db.userInfo(authResutl.uid.toString()).then((value) {});
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      db: widget.db,
                    )),
          );
        }
      }
    }
  }
}
