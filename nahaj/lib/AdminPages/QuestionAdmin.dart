// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/classes.dart';
import 'package:nahaj/presenter.dart';
import 'package:sizer/sizer.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final ExperimentInfo exp;
  final Presenter db;
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
  bool validAnswer = true;
  List<String> answers = ['', '', '', ''];
  int _raidoButtonValue = -1;
  int dropdownvalue = 1;
  List<int> items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  bool changes = false;
  bool error = false;
  bool answer3And4 = false;
  bool savedChanges = true;
  int oldScore = 0;

  bool emptyQ = false;
  bool emptyA1 = false;
  bool emptyA2 = false;
  bool emptyA3 = false;
  bool emptyA4 = false;

  @override
  void initState() {
    super.initState();
    answers = widget.question.answers;
    questionString = widget.question.question;
    dropdownvalue = widget.question.score;
    oldScore = widget.question.score;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == widget.question.correctAnswer) {
        _raidoButtonValue = i + 1;
        break;
      } else {
        print(answers[i]);
      }
    }
  }

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
              SizedBox(height: 5.0.w),
              //info Q detailes
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //Q number
                    Center(
                      child: widget.index == -1
                          ? textFieldInput('سؤال جديد', 4.5)
                          : textFieldInput('السؤال رقم ${widget.index}', 2.7),
                    ),
                    SizedBox(height: 15.1.w),

                    //Question and answers
                    buildInfo(widget.question),
                    SizedBox(height: 3.4.w),

                    //Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            widget.index == -1
                                ? Container()
                                : buildButton('حذف السؤال', 2),
                            SizedBox(width: 3.4.w),
                            widget.index == -1
                                ? buildButton('إضافة سؤال ', 1)
                                : buildButton('حفظ التغييرات', 1),
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
                    if (!savedChanges) {
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
            //error
            error
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'يجب تعبئة البيانات المطلوبه *',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 1.7.w,
                        ),
                      ),
                    ))
                : Container(),

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
                    child: textFieldInput(': نقاط السؤال *', 2.7)),
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
                          fillColor: Colors.white,
                          filled: true),
                      validator: (val) {
                        savedChanges = false;
                        questionString = val!;
                        if (val.length <= 0) {
                          validQuestion = false;
                          return 'هذا الحقل مطلوب';
                        } else {
                          validQuestion = true;
                        }
                        if (!validQuestion) {
                          return 'الرجاء كتابة سؤال';
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
                    child: textFieldInput(": السؤال *", 2.7)),
              ],
            ),
            SizedBox(height: 6.0.w),

            //Answers 1 and 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                answerCard(question.answers[1], 1),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 2 *', 1.7),
                answerCard(question.answers[0], 0),
                SizedBox(width: 1.w),
                textFieldInput(': الاجابة رقم 1 *', 1.7),
              ],
            ),
            SizedBox(height: 3.0.w),

            //error
            answer3And4
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      'يجب تعبئة الاجابتين الثالثه والرابعه',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 1.7.w,
                      ),
                    ))
                : Container(),
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
                  child: textFieldInput(': الاجابة الصحيحة *', 2.7)),
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
              Text(
                'الاجابة 4',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 2.w,
                ),
              ),
              Radio(
                  value: 4,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    changes = true;
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                'الاجابة 3',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 2.w,
                ),
              ),
              // Text(),
              Radio(
                  value: 3,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    changes = true;
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                'الاجابة 2',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 2.w,
                ),
              ),
              Radio(
                  value: 2,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    changes = true;
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                'الاجابة 1',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 2.w,
                ),
              ),
              Radio(
                  value: 1,
                  groupValue: _raidoButtonValue,
                  onChanged: (newValue) {
                    changes = true;
                    setState(() => _raidoButtonValue = newValue as int);
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Container dropDownScore() {
    return Container(
      child: InputDecorator(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true),
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
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (val) {
            savedChanges = false;
            if (index < 2) {
              if (val!.length <= 0) {
                validAnswer = false;
                return 'هذا الحقل مطلوب';
              } else {
                validAnswer = true;
                answers[index] = val;
                widget.question.answers[index] = val;
              }
            } else {
              validAnswer = true;
              answers[index] = val!;
              widget.question.answers[index] = val;
            }
            if (!validAnswer) {
              return 'هذا الحقل مطلوب';
            }
          },
        )),
      ),
    );
  }

  Widget buildButton(String text, int type) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: type == 1 ? Colors.blue : Colors.red,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 3.2.h, vertical: 1.2.w),
        ),
        child: Text(
          "$text ",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            fontSize: 2.w,
          ),
        ),
        onPressed: () {
          //update add Q
          if (type == 1) {
            if (updateQuestion()) {
              showDialog(
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                      title: Text("هل انت متاكد ؟"),
                      actions: [
                        //yes
                        ElevatedButton(
                            onPressed: () {
                              //new question
                              saveChanges(context);
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
                        //no
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("لا",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(0),
                              shadowColor: Colors.white.withOpacity(0),
                              onPrimary: Colors.white,
                            )),
                      ]);
                },
                context: context,
              );
            }
          }
          //delete Q
          else {
            showDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                    title: Text("هل انت متاكد من حذف السؤال ؟"),
                    actions: [
                      //yes
                      ElevatedButton(
                          onPressed: () {
                            deleteQuestion(widget.question.expID,
                                widget.question.id, widget.question.score);
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
                      //no
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              Text("لا", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0),
                            shadowColor: Colors.white.withOpacity(0),
                            onPrimary: Colors.white,
                          )),
                    ]);
              },
              context: context,
            );
          }
        },
      );

  void saveChanges(BuildContext context) {
    if (widget.index == -1) {
      print('inside new question');
      widget.db
          .addNewQuestion(
              questionString,
              answers[_raidoButtonValue - 1],
              answers[0],
              answers[1],
              answers[2],
              answers[3],
              dropdownvalue,
              widget.exp.id)
          .then((value) {
        savedChanges = true;
        print("added new question");
        showDialog(
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
                title: Text('تم تحديث البيانات بنجاح'),
                content: Image.asset("assets/party.png", fit: BoxFit.cover),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
                ]);
          },
          context: context,
        );

        return true;
      });
    } else {
      print('inside update question');
      widget.db
          .updateQuesAns(
              widget.question.expID,
              widget.question.id,
              questionString,
              answers[0],
              answers[1],
              answers[2],
              answers[3],
              answers[_raidoButtonValue - 1],
              dropdownvalue,
              oldScore)
          .then((value) {
        print("update question");
        print(
            "${widget.question.expID},${widget.question.id},$questionString,${answers[0]},${answers[1]},${answers[2]},${answers[3]},${answers[_raidoButtonValue - 1]},$dropdownvalue, ${savedChanges = true}");
        showDialog(
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
                title: Text('تم تحديث البيانات بنجاح'),
                content: Image.asset("assets/party.png", fit: BoxFit.cover),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
                ]);
          },
          context: context,
        );

        return true;
      });
    }
  }

  bool updateQuestion() {
    if (!validQuestion) {
      if (questionString != "") {
        validQuestion = true;
        questionString = widget.question.question;
      }
    }
    if (validAnswer) {
      if (answers[0] == '' || answers[1] == '') {
        validAnswer = false;
        error = true;
      } else if (answers[2] != "" && answers[3] == "") {
        answer3And4 = true;
        validAnswer = false;
        error = true;
      } else if (answers[2] == "" && answers[3] != "") {
        validAnswer = false;
        answer3And4 = true;
        error = true;
      }
    }
    setState(() {
      error = true;
    });
    if (validQuestion && validAnswer && _raidoButtonValue != -1) {
      error = false;
      print(
          "validQuestion: $questionString,length: ${widget.question.answers.length}\n validAnswer: ${answers[0] + " " + answers[1] + " " + answers[2] + " " + answers[3]}\n_raidoButtonValue $_raidoButtonValue");

      //check if radio answer has value
      if ((_raidoButtonValue == 3 || _raidoButtonValue == 4) &&
          (answers[2] == "" || answers[3] == "")) {
        print("_raidoButtonValue in 3 or 4 ${answers[2]} ${answers[3]}");
        print("_raidoButtonValue in 3 or 4 is empty");
        setState(() {
          error = true;
        });
        return false;
      }
      setState(() {
        error = false;
      });
      return true;
    }
    print("not true");
    print(
        "validQuestion: $validQuestion,\n validAnswer: $validAnswer \nanswers:${answers[0] + "  " + answers[1] + "  " + answers[2] + "  " + answers[3]}\nwidgetQuestionanswers: ${widget.question.answers[0] + "  " + widget.question.answers[1] + "  " + widget.question.answers[2] + "  " + widget.question.answers[3]}\n_raidoButtonValue $_raidoButtonValue");
    setState(() {
      error = true;
    });
    return false;
  }

  bool deleteQuestion(String expID, String questionId, int questionScore) {
    widget.db.deleteQuestion(expID, questionId, questionScore).then((value) {
      print("update question");
      savedChanges = true;
      showDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text('تم حذف السؤال بنجاح'),
              content: Image.asset("assets/party.png", fit: BoxFit.cover),
              actions: [
                ElevatedButton(
                    onPressed: () {
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
              ]);
        },
        context: context,
      );

      return true;
    });
    return false;
  }
}
