import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nahaj/database.dart';
import 'package:sizer/sizer.dart';


class Signin extends StatefulWidget {
  final DataBase db;
  Signin({Key? key, required this.db}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _key = GlobalKey<FormState>();

  String email = "reem@gmail.com";
  String password = "12345678";
  String username = "1";
  String avatar = "1";
  double level = 0;
  bool valid = false;
  bool vaildEmail = false;
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
            //listview container
            ListView(
              key: _key,
              children: [
                //Nahaj logo
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                //Email
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                //Email textfield
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                    child: TextFormField(
                      initialValue: "reem@gmail.com",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        if (val!.length <= 0) {
                          valid = false;
                          vaildEmail = false;
                          return 'هذا الحقل مطلوب';
                        } else {
                          valid = true;
                          vaildEmail = true;
                          email = val;
                        }
                        if (loginErr) {
                          return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                //Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 0),
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
                //Password textfield
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue:'12345678',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        /*onChanged: (val) {
                          password = val;
                        },*/
                        validator: (val) {
                          if (val!.length <= 0) {
                            valid = false;
                            return 'هذا الحقل مطلوب';
                          } else {
                            valid = true;
                            password = val;
                          }
                          return null;
                        },
                      )),
                ),
                //Sign in button
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
                      onPressed: () async {
                        loginErr = false;
                        // if(_key.currentContext.validate())
                        if (valid) {
                          if (await loginUser()) {
                            setState(() {
                              Navigator.of(context).pushNamed('/HomePage');
                            });
                          } else {
                            loginErr = true;
                          }
                        }
                      },
                      padding: EdgeInsets.all(0.0),
                      color: Color.fromARGB(255, 129, 190, 255),
                      textColor: Colors.white,
                      child: Text(
                        "تسجيل الدخول ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 2.7.w,
                        ),
                      ),
                    ),
                  ),
                ),
                //Forgot password
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Container(
                    margin: EdgeInsets.all(25),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: Text(
                        " نسيت كلمة المرور؟ ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 106, 212),
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 2.7.w,
                        ),
                      ),
                      onPressed: () {
                        if (vaildEmail && email.isNotEmpty) {
                          print("inside forget pass");
                          widget.db.resetPassword(email).then(
                                (value) => showDialog(
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                          'تم ارسال اعادة تعيين كلمة المرور الى الايميل'),
                                    );
                                  },
                                  context: context,
                                ),
                              );
                        } else {
                          print("inside forget pass2");
                          showDialog(
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                    'الرجاء ادخال البريد الالكتروني'),
                              );
                            },
                            context: context,
                          );
                        }
                      },
                    ),
                  ),
                ),
                //Sign up page button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(25),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        child: Text(
                          "تسجيل",
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 106, 212),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 2.7.w,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).pushNamed('/SignUp');
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Text(
                          " لاتمتلك حساب ؟  ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 2.7.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //sign in function
  Future<bool> loginUser() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', '');
    prefs.setString('username', '');
    prefs.setString('avatar', '');
    prefs.setDouble('level', -1.0);
    prefs.setString('email', '');
    
    dynamic authResutl = await widget.db.loginUser(email, password);
    if (authResutl == null) {
      print("login error");
      return false;
    } else {
      print("log in Successuflly, signin page");
      await widget.db.userInfo(authResutl.uid.toString()).then((value) {});
      return true;
    }
  }
}
