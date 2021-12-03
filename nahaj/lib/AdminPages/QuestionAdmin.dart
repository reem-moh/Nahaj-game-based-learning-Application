// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/database.dart';
import 'package:sizer/sizer.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final ExperimentInfo exp;
  final DataBase db;

  QuestionCard({
    required this.question,
    required this.db,
    required this.exp,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String questionString = "";
  bool validQuestion = false;
  bool validAnswer = false;
  List<String> answers = ['', '', '', ''];
  int _groupValue = -1;

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
            children: [
              SizedBox(height: 2.0.w),
              //info
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //exp name
                    buildExpName(widget.exp.name),
                    SizedBox(height: 30.1.w),
                    //Question and answers
                    buildInfo(widget.question),
                    SizedBox(height: 2.4.w),
                    CorrectAnswer(),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(800.0)),
                  alignment: Alignment.topLeft,
                  elevation: 0.0,
                ),
                child: Image(
                  image: AssetImage("assets/PreviosButton.png"),
                ),
                onPressed: () {
                  /*
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
               */
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container CorrectAnswer() {
    return Container(
      child: Column(
      children: <Widget>[
        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
                    child: Text(
                      ": الاجابه الصحيحه",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 2.7.w,
                      ),
                    ),
                  ),
                ),
             
        _myRadioButton(
          title: "الاجابة ١",
          value: 0,
        ),
        _myRadioButton(
          title: "الاجابة ٢",
          value: 1,
        ),
        _myRadioButton(
          title: "الاجابة ٣",
          value: 2,
        ),
        _myRadioButton(
          title: "الاجابة ٤",
          value: 3,
        ),
      ],
    ),);
  }

  Widget buildExpName(String expName) => Column(
        children: [
          SizedBox(height: 2.0.w),
          Text(
            expName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 2.7.w,
            ),
          )
        ],
      );

  Widget buildInfo(Question question) => Container(
        margin: EdgeInsets.only(left: 10.h),
        child: Column(
          children: [
            //Question
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Question field
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.h, vertical: 0),
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          initialValue: question.question,
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
                      ": السؤال",
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
            SizedBox(height: 9.0.w),
            //Answers 1 and 2
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                answerCard(question.answers[0], 0),
                SizedBox(width: 1.w),
                answerNumber(1),
                //SizedBox(height: 1.w),

                answerCard(question.answers[1], 1),
                SizedBox(width: 1.w),
                answerNumber(2),

                // answerCard(question.answers[2], 2),
                // answerNumber(1),
                //SizedBox(height: 1.w),
                // answerCard(question.answers[3], 3),
                // answerNumber(1),
              ],
            ),
            SizedBox(height: 4.0.w),
            //Answers 3 and 4
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                answerCard(question.answers[2], 2),
                SizedBox(width: 1.w),
                answerNumber(3),
                //SizedBox(height: 1.w),

                answerCard(question.answers[3], 3),
                SizedBox(width: 1.w),
                answerNumber(4),
              ],
            ),
            SizedBox(height: 4.0.w),
          ],
        ),
      );

  Expanded answerCard(String answer, int index) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              //height: MediaQuery.of(context).size.height * 0.08,
              //width: MediaQuery.of(context).size.width * 0.4,
              child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 5.0.h, vertical: 0),
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
          ],
        ),
      ),
    );
  }

  SizedBox answerNumber(int index) {
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
        child: Text(
          ":الاجابة رقم $index ",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            fontSize: 1.7.w,
          ),
        ),
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'حفظ التغييرات',
        onClicked: () {
          if (updateUser(questionString, email, password)) {
            print("inside dialog!");
            savedChanges = true;
            /*  showDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('تم تحديث البيانات بنجاح'),
                  content: Image.asset("assets/party.png", fit: BoxFit.cover),
                );
              },
              context: context,
            );
          */
          }
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

  Widget _myRadioButton({required String title, required int value}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: (int? newValue) {
        setState(() => _groupValue = newValue!);
      },
      title: Text(title), //onChanged: (int? value) {  },
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
