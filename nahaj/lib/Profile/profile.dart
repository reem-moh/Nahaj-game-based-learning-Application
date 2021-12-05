import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/presenter.dart';
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
  List avatars = [];
  bool savedChanges = true;

  @override
  void initState() {
    super.initState();
    getAvatarImages();
  }

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

          //user information
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2.0.w),
              //info
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //avatar
                    Container(
                      alignment: Alignment.topCenter,
                      child: ProfileWidget(
                        imagePath: user.avatar,
                        onClicked: () async {
                          showDialog(
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  'تغيير صورة العرض',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 2.7.w,
                                  ),
                                ),
                                content: Center(child: buildListOfAvatars()),
                              );
                            },
                            context: context,
                          );
                        },
                      ),
                    ),
                    //level
                    buildLevel(user),
                    SizedBox(height: 13.1.w),
                    buildInfo(user),
                    SizedBox(height: 2.4.w),
                    changes ? Center(child: buildUpgradeButton()) : Center(),
                    SizedBox(height: 9.0.w),
                  ],
                ),
              ),
            ],
          ),

          //back button
          Column(
            children: [
              SizedBox(height: 5.0.w),
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
                    if (changes && !savedChanges) {
                      showDialog(
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("هل تريد الخروج بدون حفظ التغييرات؟"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/HomePage',
                                            (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "نعم",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white.withOpacity(0),
                                    shadowColor: Colors.white.withOpacity(0),
                                    onPrimary: Colors.white,
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "لا",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white.withOpacity(0),
                                    shadowColor: Colors.white.withOpacity(0),
                                    onPrimary: Colors.white,
                                  )),
                            ],
                          );
                        },
                        context: context,
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLevel(User user) => Column(
        children: [
          SizedBox(height: 2.0.w),
          Text(
            "المستوى: ${user.level}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 2.7.w,
            ),
          )
        ],
      );

  Widget buildInfo(User user) => Container(
        margin: EdgeInsets.only(left: 10.h),
        child: Column(
          children: [
            //Name
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Name
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.h, vertical: 0),
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
                            savedChanges = false;
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
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
            SizedBox(height: 4.0.w),
            //Email
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.h, vertical: 0),
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          initialValue: user.email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            changes = true;
                            savedChanges = false;
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
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
            SizedBox(height: 4.0.w),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0.h, vertical: 0),
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          changes = true;
                          savedChanges = false;
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
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
            SizedBox(height: 4.0.w),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.h, vertical: 0),
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) {
                            changes = true;
                            savedChanges = false;
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
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
            SizedBox(height: 4.0.w),
          ],
        ),
      );

  Widget buildListOfAvatars() => Container(
        padding: EdgeInsets.symmetric(vertical: 5.0.w),
        child: Wrap(
          children: [
            for (int i = 0; i < avatars.length; i++)
              if (avatars[i] != null)
                Column(
                  children: [
                    SizedBox(
                      width: 12.0.w,
                    ),
                    SizedBox(
                      width: 10.0.w,
                      height: 10.0.w,
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(26),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 7,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: widget.user.level < avatars[i]['level']
                            ? Scaffold(
                                body: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    FadeInImage.assetNetwork(
                                      placeholder: 'assets/loading.gif',
                                      image: avatars[i]['url'],
                                    ),
                                    IconButton(
                                      alignment: Alignment.center,
                                      iconSize: 6.w,
                                      icon: Icon(Icons.lock),
                                      onPressed: () {
                                        showDialog(
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Text(
                                                  'سيتم فتح صورة العرض عندما تصل الى مستوى ${avatars[i]['level']}'),
                                            );
                                          },
                                          context: context,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  widget.db
                                      .changeAvatar(
                                          avatars[i]['url'], widget.user.userId)
                                      .then((value) => {
                                            showDialog(
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: Text(
                                                    'تم تحديث صورة العرض بنجاح',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 2.3.w,
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  '/HomePage',
                                                                  (Route<dynamic>
                                                                          route) =>
                                                                      false);
                                                        },
                                                        child: Text(
                                                          "حسنا",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.white
                                                              .withOpacity(0),
                                                          shadowColor: Colors
                                                              .white
                                                              .withOpacity(0),
                                                          onPrimary:
                                                              Colors.white,
                                                        )),
                                                  ],
                                                );
                                              },
                                              context: context,
                                            ),
                                            widget.db
                                                .userInfo(widget.user.userId)
                                                .then((value) {})
                                          });
                                },
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/loading.gif',
                                  image: avatars[i]['url'],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      //width: 7.w,
                      height: 2.w,
                    ),
                  ],
                ),
          ],
        ),
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'حفظ التغييرات',
        onClicked: () {
          if (updateUser(name, email, password)) {
            print("inside dialog!");
            savedChanges = true;
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
        widget.user.email = email;
        print("user changes the email");
        validEmail = false;
        changed = true;
      }
    }
    if (changed) widget.db.userInfo(widget.user.userId).then((value) {});

    if (passChanged || changed) return true;

    return false;
  }

   getAvatarImages() async {
    await widget.db.listOfAvatars().then((value) => avatars = value);
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
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: Colors.white38,
            ),
            child: buildImage(),
          ),
          Positioned(
            bottom: 0,
            right: .4.w,
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
          fit: BoxFit.contain,
          width: 12.8.h,
          height: 12.8.h,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  //avatar change icon
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: .3.h,
        child: buildCircle(
          color: color,
          all: .8.h,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 2.0.w,
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
          padding: EdgeInsets.symmetric(horizontal: 3.2.h, vertical: 1.2.w),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
