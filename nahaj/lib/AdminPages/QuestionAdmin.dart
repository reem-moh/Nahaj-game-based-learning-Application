// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/presenter.dart';
import 'package:sizer/sizer.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final ExperimentInfo exp;
  final DataBase db;
  final int index;

  QuestionCard({
    required this.question,
    required this.db,
    required this.exp,
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String questionString = "";
  bool validQuestion = false;
  bool validAnswer = false;
  List<String> answers = ['', '', '', ''];
  int _raidoButtonValue = -1;
  int dropdownvalue = 1;
  List<int> items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String email = "";

  String password = "";

  String repeatedPassword = "";
  bool validPass = false;

  bool validRePass = false;

  bool loginErr = false;

  bool changes = false;

  bool savedChanges = true;

  @override
  Widget build(BuildContext context) {
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

          //Question information
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 6.0.w),
              //info

              //Q detailes
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //Q number
                    Center(
                      child: textFieldInput('السؤال رقم ${widget.index}', 2.7),
                    ),

                    SizedBox(height: 18.1.w),
                    //Question and answers
                    buildInfo(widget.question),
                    SizedBox(height: 3.4.w),
                    //Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            buildUpgradeButton('حذف السؤال', 2),
                            SizedBox(width: 3.4.w),
                            buildUpgradeButton('حفظ التغييرات', 1),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0.w),
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
                                    Navigator.of(context).pop();
                                     Navigator.of(context).pop();
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

  Widget buildInfo(Question question) => Container(
        margin: EdgeInsets.only(left: 10.h),
        child: Column(
          children: [
            //question score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Score drop down Question
                Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.49,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 0),
                    child: dropDownScore()),
                //Score name
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textFieldInput(': نقاط السؤال', 2.7)),
              ],
            ),
            SizedBox(height: 3.0.w),

            //Question
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Question field
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 0),
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      initialValue: question.question,
                      textAlign: TextAlign.start,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) {
                        changes = true;
                        savedChanges = false;
                        if (val!.length <= 0) {
                          validQuestion = false;
                          return 'هذا الحقل مطلوب';
                        } else {
                          validQuestion = true;
                          questionString = val;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    //padding:
                    //  EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
                    child: textFieldInput(": السؤال", 2.7)),
              ],
            ),
            SizedBox(height: 6.0.w),

            //Answers 1 and 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                answerCard(question.answers[1], 1),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 2', 1.7),
                answerCard(question.answers[0], 0),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 1', 1.7),
              ],
            ),
            SizedBox(height: 3.0.w),

            //Answers 3 and 4
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                answerCard(question.answers[3], 3),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 4', 1.7),
                answerCard(question.answers[2], 2),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 3', 1.7),
              ],
            ),
            SizedBox(height: 6.0.w),

            //CorrectAnswer
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Expanded(flex: 1, child: correctAnswer()),
              SizedBox(width: 1.w),
              Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: textFieldInput(': الاجابة الصحيحة', 2.7)),
            ])
          ],
        ),
      );

  Row correctAnswer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text('الاجابة 4'),
              Radio(
                  value: 4,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text('الاجابة 3'),
              Radio(
                  value: 3,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text('الاجابة 2'),
              Radio(
                  value: 2,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text('الاجابة 1'),
              Radio(
                  value: 1,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
      ],
    );
  }

  InputDecorator dropDownScore() {
    return InputDecorator(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      child: DropdownButton(
        alignment: Alignment.centerRight,
        value: dropdownvalue,
        menuMaxHeight: 180,
        icon: Icon(Icons.keyboard_arrow_down),
        items: items.map((int items) {
          return DropdownMenuItem(value: items, child: Text("$items"));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            dropdownvalue = newValue as int;
          });
        },
      ),
    );
  }

  Container textFieldInput(String text, double size) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Text(
        "$text ",
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          fontSize: size.w,
        ),
      ),
    );
  }

  Expanded answerCard(String answer, int index) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
            child: TextFormField(
          textDirection: TextDirection.rtl,
          initialValue: answer,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (val) {
            changes = true;
            savedChanges = false;
            if (val!.length <= 0) {
              validAnswer = false;
              return 'هذا الحقل مطلوب';
            } else {
              validAnswer = true;
              answers[index] = val;
            }
          },
        )),
      ),
    );
  }

  Widget buildUpgradeButton(String text, int type) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: type == 1 ? Colors.blue : Colors.red,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 3.2.h, vertical: 1.2.w),
        ),
        child: Text(text),
        onPressed: () {
          showDialog(
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("هل انت متاكد ؟"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        // save changes
                        if (type == 1) {
                          if (updateUser(questionString, email, password)) {
                            print("inside dialog!");
                            savedChanges = true;
                            showDialog(
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text('تم تحديث البيانات بنجاح'),
                                  content: Image.asset("assets/party.png",
                                      fit: BoxFit.cover),
                                );
                              },
                              context: context,
                            );
                          }
                        } else {
                          //Delete question

                        }

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/AdminHomePage', (Route<dynamic> route) => false);
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
                      child: Text("لا", style: TextStyle(color: Colors.black)),
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
        },
      );

  bool updateUser(String name, String email, String password) {
    bool changed = false;
    bool passChanged = false;
    if (validPass && validRePass) {
      //db.changePassword(password);
      print(password);
      print("user changes the pass");
      validPass = false;
      validRePass = false;
      passChanged = true;
    }
    if (validQuestion) {
      if (widget.question.question == questionString) {
        print("question is the same as before!");
      } else {
        //db.updateQuesAns(name, user.userId);
        // widget.user.username = name;
        print("user changes the name");
        validQuestion = false;
        changed = true;
      }
    }
    /*if (validEmail) {
      
      if (widget.user.email == email) {
        print("user did not change the email!");
      } else {
        widget.db.changeEmail(email, widget.user.userId);
        widget.user.email = email;
        print("user changes the email");
        validEmail = false;
        changed = true;
      }
    }*/
    //if (changed) widget.db.userInfo(widget.user.userId).then((value) {});

    if (passChanged || changed) return true;

    return false;
  }
}
