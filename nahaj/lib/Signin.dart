import 'package:flutter/material.dart';
import 'package:nahaj/AuthonticationServices.dart';

import 'SignUp.dart';

class Signin extends StatefulWidget {
  //final DataBase db;
  //signUp({Key? key, required this.db}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _key = GlobalKey<FormState>();

  final AuthonticationServices _auth = AuthonticationServices();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/SignUpSignInbackground.png"),
                      fit: BoxFit.cover)),
            ),

            //mainAxisAlignment: MainAxisAlignment.end,

            SingleChildScrollView(
              child: Column(
                children: [
                  /*
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/nahajLogo.png"),
                                  fit: BoxFit.none)),
                        ),
                      ),
*/
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 0),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 130, vertical: 0),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            password = val;
                          },
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Container(
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: Text(
                            "تسجيل دخول",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 27,
                            ),
                          ),
                          color: Color.fromARGB(255, 129, 190, 255),
                          textColor: Colors.white,
                          onPressed: () {
                            // if(_key.currentContext.validate())
                            loginUser();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Container(
                      margin: EdgeInsets.all(25),
                      child: FlatButton(
                        child: Text(
                          " نسيت كلمة المرور؟ ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 106, 212),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: Text(
                            "تسجيل",
                            style: TextStyle(
                              color: Color.fromARGB(255, 6, 106, 212),
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 27,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
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
                              fontSize: 27,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    dynamic authResutl = await _auth.loginUser(email, password);
    if (authResutl == null) {
      print("login error");
    } else {
      print("log in Successuflly");
    }
  }
}