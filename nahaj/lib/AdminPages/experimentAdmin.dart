import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';
import '../../NahajClasses/child.dart';
import '../../database.dart';
import 'QuestionAdmin.dart';
import 'AddQuestionCard.dart';

class ExperimentAdmin extends StatefulWidget {
  final DataBase db;
  final ExperimentInfo exp;
  const ExperimentAdmin({
    Key? key,
    required this.db,
    required this.exp,
  }) : super(key: key);

  @override
  _ExpInfo createState() => _ExpInfo();
}

class _ExpInfo extends State<ExperimentAdmin> {
  bool valid = false;
  bool validName = false;
  String name = "1";
  bool validCategory = false;
  String category = "1";
  bool validExperimentScore = false;
  int experimentScore = 0;
  bool validInfo = false;
  String info = "1";
  bool changes = false;
  bool savedChanges = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    ),
                    changes ? Center(child: buildUpgradeButton()) : Center(),
                    SizedBox(height: 9.0.w),
                  ],
                ),
              ),
            ],
          ),

          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /*
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0),
                    onPrimary: Colors.white.withOpacity(0),
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
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              Container(
                  child: Stack(children: [
                //background bottom
                Container(
                    width: MediaQuery.of(context).size.width.h,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.2),
                    child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/homeBottomBackground.png"))),
                */

            Column(
                //children: [
                //SizedBox(height: 2.0.w),
                //info
                //Expanded(
                //  child: ListView(
                //   physics: BouncingScrollPhysics(),

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ':معلومات التجربة',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontSize: 3.0.w),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width.h / 40.h,
                      ),
                      Image.asset('assets/TabsIndicator.png'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width.h / 20.h,
                      ),
                    ],
                  ),
                  //name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                initialValue: widget.exp.name,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.h, vertical: 0),
                          child: Text(
                            ": الأسم",
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
                  //Exp name

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
                                initialValue: widget.exp.category,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorRadius: Radius.circular(50),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  changes = true;
                                  savedChanges = false;
                                  if (val!.length <= 0) {
                                    validCategory = false;
                                    return 'هذا الحقل مطلوب';
                                  } else if (val.length <= 2) {
                                    validCategory = false;
                                    print("name is not valid");
                                    return 'الصنف يجب أن يكون من ثلاثة أحرف أو أكثر';
                                  } else {
                                    validCategory = true;
                                    category = val;
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.h, vertical: 0),
                          child: Text(
                            ":الصنف  ",
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
                                initialValue: widget.exp.info,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorRadius: Radius.circular(50),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  changes = true;
                                  savedChanges = false;
                                  if (val!.length <= 0) {
                                    validInfo = false;
                                    return 'هذا الحقل مطلوب';
                                  } else if (val.length <= 2) {
                                    validInfo = false;
                                    print("name is not valid");
                                    return 'الوصف يجب أن يكون من ثلاثة أحرف أو أكثر';
                                  } else {
                                    validInfo = true;
                                    info = val;
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.h, vertical: 0),
                          child: Text(
                            ":وصف التجربة  ",
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
                                initialValue:
                                    widget.exp.experimentScore.toString(),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                cursorRadius: Radius.circular(50),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (val) {
                                  changes = true;
                                  savedChanges = false;
                                  if (val!.length <= 0) {
                                    validExperimentScore = false;
                                    return 'هذا الحقل مطلوب';
                                  } else if (val as int < 1) {
                                    validExperimentScore = false;
                                    print("name is not valid");
                                    return 'لايمكن ان تكون درجه التجربة ٠ أو عدد سالب';
                                  } else {
                                    validExperimentScore = true;
                                    experimentScore = val as int;
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.h, vertical: 0),
                          child: Text(
                            ":درجة التجربة  ",
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
                ]),
/*
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80),
              //height: MediaQuery.of(context).size.height / 2.5,
              height: MediaQuery.of(context).size.height / 1,
              child: QuestionsWidget(
                db: widget.db,
                exp: widget.exp,
              ),
            ),*/
            //groups

            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //pluse sign
                      FocusedMenuHolder(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 114, 78,
                                140), //Color.fromARGB(255, 202, 203, 203),
                            shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(
                            right: 16.00.h,
                            top: 5.w,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 45,
                            color: Colors.white.withOpacity(.80),
                          ),
                        ),
                        onPressed: () {},
                        openWithTap: true,
                        menuWidth: MediaQuery.of(context).size.width * 0.30,
                        menuItems: [
                          FocusedMenuItem(
                              title: Text(
                                "إضافة سؤال",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 1.5.w,
                                ),
                              ),
                              trailingIcon: Icon(Icons.group_add),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddQuestionCard(
                                            db: widget.db,
                                            exp: widget.exp,
                                          )),
                                );
                              }),
                        ],
                      ),
                      Spacer(),
                      Text(
                        ':الاسئلة',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontSize: 3.0.w),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4.h,
                      ),
                      Image.asset('assets/TabsIndicator.png'),
                      SizedBox(
                        width: 2.h,
                      ),
                    ],
                  ),
                  //list view
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    height: 18.00.h,
                    child: QuestionsWidget(
                      db: widget.db,
                      exp: widget.exp,
                    ),
                  ),
                ],
              ),
            ),
          ]) //)
        ],
      ),
      // ],
      // ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'حفظ التغييرات',
        onClicked: () {
          if (updateExp(name, category, info, experimentScore)) {
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

  bool updateExp(
      String name, String category, String info, int experimentScore) {
    bool changed = false;

    if (validName) {
      if (widget.exp.name == name) {
        print("user did not change the name!");
      } else {
        widget.db.updateExpName(widget.exp.id, name);
        widget.exp.name = name;
        print("user changes the name");
        validName = false;
        changed = true;
      }
    }
    if (validCategory) {
      if (widget.exp.category == category) {
        print("user did not change the category!");
      } else {
        widget.db.updateExpCategory(widget.exp.id, category);
        widget.exp.category = category;
        print("user changes the category");
        validCategory = false;
        changed = true;
      }
    }

    if (validInfo) {
      if (widget.exp.info == info) {
        print("user did not change the info!");
      } else {
        widget.db.updateExpInfo(widget.exp.id, info);
        widget.exp.info = info;
        print("user changes the info");
        validInfo = false;
        changed = true;
      }
    }

    if (validExperimentScore) {
      if (widget.exp.experimentScore == experimentScore) {
        print("user did not change the experimentScore!");
      } else {
        widget.db.updateExpScor(widget.exp.id, experimentScore);
        widget.exp.experimentScore = experimentScore;
        print("user changes the experimentScore");
        validExperimentScore = false;
        changed = true;
      }
    }
    if (changed) return true;

    return false;
  }
}

// ignore: must_be_immutable
class QuestionsWidget extends StatefulWidget {
  final ExperimentInfo exp;
  final DataBase db;

  QuestionsWidget({
    required this.db,
    required this.exp,
  });

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  @override
  Widget build(BuildContext context) => StreamBuilder<List<Question>>(
        stream: widget.db.getQuestions(widget.exp.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('حدث خطأ ما! الرجاء التحقق من الانترنت');
              } else {
                final allQuestions = snapshot.data;
                return allQuestions == null
                    ? buildText('لا توجد أسئلة')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allQuestions.length,
                        itemBuilder: (context, index) {
                          final question = allQuestions[index]; //[index];

                          return Container(
                              margin: EdgeInsets.only(left: 30.0, right: 30.0),
                              height: 18.00.h,
                              child: CardsOfQuestions(
                                db: widget.db,
                                exp: widget.exp,
                                question: question,
                                index: index,
                              ));
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

class CardsOfQuestions extends StatelessWidget {
  final Question question;
  final DataBase db;
  final ExperimentInfo exp;
  final int index;

  const CardsOfQuestions({
    required this.question,
    required this.db,
    required this.exp,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = index + 1;

    return InkWell(
      onTap: () {
        print('Question');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionCard(
              db: db,
              question: question,
              exp: exp,
            ),
          ),
        );
      },
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
                child: Container(
              child: Text("$counter",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 7.2.w,
                      color: Colors.black)),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
            )),
          ),
          Container(
            child: Text(
              "سؤال $counter",
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
