import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/expriment.dart';
import 'package:sizer/sizer.dart';
import 'package:nahaj/database.dart';

//#FDE9A9
final Color backgroundColorOfSideBar = Color(0xffFDE9A9);
//late final DataBase db;

class Admin extends StatefulWidget {
  final DataBase db;
  Admin({Key? key, required this.db}) : super(key: key);
  //Admin({Key? key}) : super(key: key);

  //get db => null;

  @override
  _Admin createState() => _Admin();
}

class _Admin extends State<Admin> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late int tappedIndex;
  late String adminName = "شهد";
  late String adminEmail = "shahad@gmail.com";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    tappedIndex = 0;

    //widget.db.getExperiments().then((value) => experiments = value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _logout() {
    //Navigator.pushNamedAndRemoveUntil(context, "/SigninPage", (r) => false);

    widget.db.signOut().then((s) {
      Navigator.of(context).pushNamed('/Admin');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColorOfSideBar,
      body: Stack(
        children: <Widget>[
          // menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : -9.h,
      bottom: isCollapsed ? 0 : 0.9.h,
      left: isCollapsed ? 0 : -9.9.h,
      right: isCollapsed ? 0 : 10.h,
      child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            elevation: 8,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: [
                  //top image
                  Container(
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/homeTopBackground.jpg"),
                      alignment: Alignment.topRight,
                    ),
                    alignment: Alignment.topRight,
                  ),
                  //log out
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.white,
                    ),
                    child: ListTile(
                      tileColor: tappedIndex == 3 ? Colors.white : null,
                      trailing: Icon(Icons.exit_to_app_rounded, size: 40),
                      title: Text(
                        "خروج",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 2.4.w,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      onTap: () {
                        setState(() {
                          tappedIndex = 3;
                          _logout();
                        });
                      },
                    ),
                  ),

                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 4.5.w),

                        //profile column
                        Container(
                            height:
                                MediaQuery.of(context).size.height.w / 4.18.w,
                            width: MediaQuery.of(context).size.height.w / 1.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: Color.fromARGB(200, 145, 111, 170),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 7,
                                  spreadRadius: 0,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.10),
                                adminName == "1"
                                    ? Text(
                                        "...",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                          fontSize: 3.6.w,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : Text(
                                        'أهلاً، ${adminName}',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                          fontSize: 3.6.w,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ],
                            )),
                        Container(
                          child: Stack(children: [
                            //background bottom
                            Container(
                                width: MediaQuery.of(context).size.width.h,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.2),
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/homeBottomBackground.png"))),
                            Column(
                              children: [
                                //List of Expreiments
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      ':التجارب',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 3.0.w),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              800.h,
                                    ),
                                    Image.asset('assets/TabsIndicator.png'),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              40.h,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 30.0, right: 30.0),
                                      height: 18.00.h,
                                      child: CardsOfExp(
                                        db: widget.db,
                                      )),
                                  onTap: () {
                                    InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 30.0, right: 30.0),
                                          height: 18.00.h,
                                          child: CardsOfExp(
                                            db: widget.db,
                                          )),
                                    );
                                  },
                                )
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class expQuestion extends StatelessWidget {
  final DataBase db;
  final ExperimentInfo exp;
  //final User user;
  expQuestion({Key? key, required this.db, required this.exp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /* onTap: () {
        print('مجموعة');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Group(db: db, group: group)),
        );
      },*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 13.00.h,
            height: 13.00.h,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: exp.pathOfImage,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            child: Text(
              exp.name,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 2.2.w,
                  color: Color.fromARGB(170, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsOfQuestion extends StatelessWidget {
  final DataBase db;
  //final ExperimentInfo exp;

  const CardsOfQuestion({
    required this.db,
    Key? key,
    // required this.exp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ExperimentInfo>>(
        stream: db.getExp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText(
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allExps = snapshot.data;
                return allExps == null
                    ? buildText('لا توجد تجارب!')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allExps.length,
                        itemBuilder: (context, index) {
                          final exp = allExps[index]; //[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: expQuestion(
                              db: db,
                              exp: exp,
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}

class ExpCard extends StatelessWidget {
  final DataBase db;
  final ExperimentInfo exp;
  //final User user;
  ExpCard({Key? key, required this.db, required this.exp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /* onTap: () {
        print('مجموعة');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Group(db: db, group: group)),
        );
      },*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 13.00.h,
            height: 13.00.h,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: exp.pathOfImage,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            child: Text(
              exp.name,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 2.2.w,
                  color: Color.fromARGB(170, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsOfExp extends StatelessWidget {
  final DataBase db;
  //final ExperimentInfo exp;

  const CardsOfExp({
    required this.db,
    Key? key,
    // required this.exp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Question>>(
        stream: db.getQuestions("EC9BomGkVs0EGBodta1W"),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText(
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allQuestions = snapshot.data;
                return allQuestions == null
                    ? buildText('لا توجد أسئلة')
                    : QuestionCard(
                        db: db,
                        questions: allQuestions,
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}

// ignore: must_be_immutable
class QuestionCard extends StatelessWidget {
  final List<Question>? questions;
  final DataBase db;
  int i = 0;
  int chosenAnswer = -1;

  QuestionCard({required this.questions, required this.db});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 70.h,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/QuestionBackground.png',
            width: 70.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                questions![i].question,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 5.w,
                  color: Color.fromARGB(170, 0, 0, 0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonBar(
                    children: [
                      Text(questions![i].answers[0]),
                      Radio(
                          value: 0,
                          groupValue: chosenAnswer,
                          onChanged: onChanged),
                      Text(questions![i].answers[1]),
                      Radio(
                          value: 1,
                          groupValue: chosenAnswer,
                          onChanged: onChanged),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonBar(
                    children: [
                      Text(questions![i].answers[2]),
                      Radio(
                          value: 2,
                          groupValue: chosenAnswer,
                          onChanged: onChanged),
                      Text(questions![i].answers[3]),
                      Radio(
                          value: 3,
                          groupValue: chosenAnswer,
                          onChanged: onChanged),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (i < questions!.length) {
                    if (i == questions!.length - 1) {
                      //update score
                      //alert of score
                    }
                    if (chosenAnswer == -1) {
                      //error message
                    } else {
                      if (questions![i].answers[chosenAnswer] ==
                          questions![i].correctAnswer) {
                        //banner correct answer
                        i++;
                      } else {
                        //banner wrong answer
                        i++;
                      }
                    }
                  }
                },
                child: Image.asset(
                  i == questions!.length - 1
                      ? 'assets/start_button.png'
                      : 'assets/ExperimentBackButton.png',
                  width: MediaQuery.of(context).size.width / 10,
                  height: MediaQuery.of(context).size.width / 10,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onChanged(int? value) {
    chosenAnswer = value!;
  }
}
