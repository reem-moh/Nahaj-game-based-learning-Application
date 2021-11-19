import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/database.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  final DataBase db;
  final User user;

  const ProfilePage({Key? key, required this.db, required this.user})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String password = "";
  String repeatedPassword = "";
  bool validName = false;
  bool validEmail = false;
  bool validPass = false;
  bool validRePass = false;
  bool loginErr = false;
  bool changes = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/profileBackground.png"),
                    fit: BoxFit.cover)),
          ),

          Column(
            children: [
              const SizedBox(height: 30),
              //header
              Stack(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0),
                      onPrimary: Colors.white.withOpacity(0),
                      //minimumSize: Size(30, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(800.0)),
                      alignment: Alignment.topLeft,
                      elevation: 0.0,
                    ),
                    child: Image(
                      image: AssetImage("assets/PreviosButton.png"),
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
                  Container(
                    alignment: Alignment.topCenter,
                    child: ProfileWidget(
                      imagePath: user.avatar,
                      onClicked: () async {},
                    ),
                  ),
                ],
              ),
              buildName(user),
              const SizedBox(height: 110),
              //info
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    buildInfo(user),
                    const SizedBox(height: 24),
                    changes ? Center(child: buildUpgradeButton()) : Center(),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "المستوى: ${user.level}",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildInfo(User user) => Column(
        children: [
          //Name
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: MainAxisAlignment,
            children: [
              //Name
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        initialValue: user.username,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorRadius: Radius.circular(50),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          changes = true;
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
                          return null;
                        },
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    ": اسم المستخدم",
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
          const SizedBox(height: 40),
          //Email
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        initialValue: user.email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          changes = true;
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
                          return null;
                        },
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    ":البريد الإلكتروني ",
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
          const SizedBox(height: 40),
          //Password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Password text field
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        changes = true;
                        if (val!.length <= 0) {
                          validPass = false;
                          return '  ';
                        } else if (val.length <= 7) {
                          validPass = false;
                          print("pass is not valid");
                          return 'كلمة المرور يجب أن تكون من ٨ أرقام أو أحرف أو أكثر';
                        } else if (val.length >= 7) {
                          validPass = true;
                          password = val;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    ":كلمة السر الجديدة",
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
          const SizedBox(height: 40),
          //Repeat password
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Repeat password text field
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          changes = true;
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
                          return null;
                        },
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Text(
                    ":إعادة كلمة السر ",
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
          const SizedBox(height: 40),
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'level',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "${user.level}",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'حفظ التغييرات',
        onClicked: () {
          if (updateUser(name, email, password)) {
            print("inside dialog!");
            showDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('تم تحديث البيانات بنجاح'),
                  content: Image.asset("assets/party.png", fit: BoxFit.cover),
                );
              },
              context: context,
            );
          }
        },
      );
  bool updateUser(String name, String email, String password) {
    bool changed = false;
    bool passChanged = false;
    if (validPass && validRePass) {
      widget.db.changePassword(password);
      print(password);
      print("user changes the pass");
      validPass = false;
      validRePass = false;
      passChanged = true;
    }
    if (validName) {
      if (widget.user.username == name) {
        print("user did not change the name!");
      } else {
        widget.db.changeUserName(name, widget.user.userId);
        widget.user.username = name;
        print("user changes the name");
        validName = false;
        changed = true;
      }
    }
    if (validEmail) {
      if (widget.user.email == email) {
        print("user did not change the email!");
      } else {
        widget.db.changeEmail(email, widget.user.userId);
        widget.user.username = email;
        print("user changes the email");
        validEmail = false;
        changed = true;
      }
    }
    if (changed) widget.db.userInfo(widget.user.userId).then((value) {});

    if (passChanged || changed) return true;

    return false;
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  //style avatar
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.all(Radius.circular(
              //                   120.0),),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              //borderRadius: BorderRadius.circular(26),
              color: Colors.white,
              //border: RoundedRectangleBorder,
            ),
            child: buildImage(),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  //avatar image
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.fill,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  //avatar change icon
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
