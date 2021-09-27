import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nahaj/AuthonticationServices.dart';
import 'package:nahaj/Signin.dart';
import 'database.dart';

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

            InkWell(
              child: Padding(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Image(
                  /*
                          width: MediaQuery.of(context).size.width / 1.09,
                          height: MediaQuery.of(context).size.height / 4.18,*/
                  image: AssetImage("assets/PreviosButton.png"),
                  alignment: Alignment.topLeft,
                ),
              ),
              onTap: () {
                setState(() {
                  Navigator.pop(
                    context,
                  );
                });
              },
            ),

            //mainAxisAlignment: MainAxisAlignment.end,
            ListView(
              key: _key,
              //Column(
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

// ignore: deprecated_member_use
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          name = val;
                        },
                      )),
                ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                          //obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            email = val;
                          })),
                ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                    child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          password = val;
                        }),
                  ),
                ),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) {
                            repeatedPassword = val;
                          })),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Container(
                      margin: EdgeInsets.all(25),
                      child: FlatButton(
                        child: Text(
                          "تسجيل ",
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
                          // var validate = _key.currentState.validate();
                          //if (validate) {
                          createUser(name, email, password);
                          //}
                        },
                      ),
                    ),
                  ),
                ),
              ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  void createUser(String name, String email, String password) async {
    dynamic result = await widget.db.createNewUser(name, email, password);
    if (result == null) {
      print("email is not valid");
    } else {
      print(result.toString());
      Navigator.pop(context);
    }
  }
}
