import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';
import '../NahajClasses/child.dart';
import '../database.dart';

//List<ExperimentInfo> experiments = [];

class ExpInfo extends StatefulWidget {
  final DataBase db;
  final ExperimentInfo exp;
  const ExpInfo({
    Key? key,
    required this.db,
    required this.exp,
  }) : super(key: key);

  @override
  _ExpInfo createState() => _ExpInfo();
}

class _ExpInfo extends State<ExpInfo> {
  @override
  void initState() {
    super.initState();

    //print(experiments.first.id);
  }

  bool valid = false;
  bool validName = false;
  String name = "1";
  bool validCategory = false;
  String category = "1";
  bool validExperimentScore = false;
  int experimentScore = 0;
  bool validInfo = false;
  String info = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ElevatedButton(
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
                Column(children: [
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 0),
                          child: Text(
                            ':الأسم',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Exp name
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue: widget.exp.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.length <= 0) {
                            name = widget.exp.name;
                          } else {
                            valid = true;
                            validName = true;
                            name = val;
                          }
                          //if (loginErr) {
                          //return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),

                  //Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 0),
                          child: Text(
                            ':التصنيف',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //EXP Category
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue: widget.exp.category,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.length <= 0) {
                            category = widget.exp.name;
                          } else {
                            valid = true;
                            validCategory = true;
                            category = val;
                          }
                          //if (loginErr) {
                          //return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),

                  //ExperimentScore
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 0),
                          child: Text(
                            ':درجة اتمام التجربة',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //EXP ExperimentScore
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue: widget.exp.experimentScore.toString(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.length <= 0) {
                            experimentScore = widget.exp.experimentScore;
                          } else if (val as int < 1) {
                            valid = false;
                            validExperimentScore = false;
                            return 'لايمكن ان تكون درجه التجربة ٠ أو عدد سالب';
                          } else {
                            valid = true;
                            validExperimentScore = true;
                            experimentScore = val as int;
                          }
                          //if (loginErr) {
                          //return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),

                  //info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 150, vertical: 0),
                          child: Text(
                            ':الوصف',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //EXP Info
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue: widget.exp.info,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.length <= 0) {
                            info = widget.exp.info;
                          } else {
                            valid = true;
                            validInfo = true;
                            info = val;
                          }
                          //if (loginErr) {
                          //return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),
                ]),

                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80),
                  //height: MediaQuery.of(context).size.height / 2.5,
                  height: MediaQuery.of(context).size.height / 1,
                  child: QuestionsWidget(
                    db: widget.db,
                    exp: widget.exp,
                  ),
                ),
              ]))
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class QuestionsWidget extends StatelessWidget {
  final ExperimentInfo exp;
  final DataBase db;

  int i = 0;

  QuestionsWidget({
    required this.db,
    required this.exp,
  });
  @override
  Widget build(BuildContext context) => StreamBuilder<List<Question>>(
        stream: db.getQuestions(exp.id),
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
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allQuestions.length,
                        itemBuilder: (context, index) {
                          //final group = allQuestions[index]; //[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: QuestionCard(
                              db: db,
                              questions: allQuestions,
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

// ignore: must_be_immutable
class QuestionCard extends StatefulWidget {
  final List<Question>? questions;
  final ExperimentInfo exp;
  final DataBase db;

  QuestionCard({
    required this.questions,
    required this.db,
    required this.exp,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  //final _key = GlobalKey<FormState>();
  int i = 0;
  int chosenAnswer = 0;
  int userScore = 0;
  double fontSize = 5;

  bool valid = false;
  bool validQues1 = false;
  String ques1 = "1";
  bool validCategory = false;
  String category = "1";
  bool validExperimentScore = false;
  int experimentScore = 0;
  bool validInfo = false;
  String info = "1";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(0, 0, 0, 0),
      shadowColor: Color.fromARGB(0, 0, 0, 0),
      child: Container(
        margin: EdgeInsets.only(left: 14.5.h, top: 35.w),
        width: 70.h,
        height: 50.h,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 14.5.h),
              child: Column(
                children: [
                  //EXP Info
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        initialValue: widget.questions![i].question,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.length <= 0) {
                            info = widget.exp.info;
                          } else {
                            valid = true;
                            validInfo = true;
                            info = val;
                          }
                          //if (loginErr) {
                          //return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ),

                  /* Container(
                    margin: EdgeInsets.only(top: 3.w),
                    alignment: Alignment.topCenter,
                    width: 70.h,
                    child: Text(
                      widget.questions![i].question,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize.sp,
                        color: Color.fromARGB(170, 0, 0, 0),
                      ),
                    ),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 10.h,
                            top: widget.questions![i].answers[2] != ""
                                ? 0
                                : 6.w),
                        child: ButtonBar(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              alignment: Alignment.centerRight,
                              width: 20.h,
                              height: 5.w,
                              child: Text(
                                widget.questions![i].answers[0],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize.sp,
                                  color: Color.fromARGB(170, 0, 0, 0),
                                ),
                              ),
                            ),
                            Radio(
                                value: 1,
                                groupValue: chosenAnswer,
                                onChanged: onChanged),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              alignment: Alignment.centerRight,
                              width: 20.h,
                              height: 5.w,
                              child: Text(
                                widget.questions![i].answers[1],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize.sp,
                                  color: Color.fromARGB(170, 0, 0, 0),
                                ),
                              ),
                            ),
                            Radio(
                                value: 2,
                                groupValue: chosenAnswer,
                                onChanged: onChanged),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //if true and false question we don't need 4 answers
                  widget.questions![i].answers[2] != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10.h),
                              child: ButtonBar(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 0, right: 0),
                                    alignment: Alignment.centerRight,
                                    width: 20.h,
                                    height: 5.w,
                                    child: Text(
                                      widget.questions![i].answers[2],
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                        fontSize: fontSize.sp,
                                        color: Color.fromARGB(170, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  Radio(
                                      value: 3,
                                      groupValue: chosenAnswer,
                                      onChanged: onChanged),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 0, bottom: 0, left: 0, right: 0),
                                    alignment: Alignment.centerRight,
                                    width: 20.h,
                                    height: 5.w,
                                    child: Text(
                                      widget.questions![i].answers[3],
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                        fontSize: fontSize.sp,
                                        color: Color.fromARGB(170, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  Radio(
                                      value: 4,
                                      groupValue: chosenAnswer,
                                      onChanged: onChanged),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            //next/ send button
            Container(
              margin: i == widget.questions!.length - 1
                  ? EdgeInsets.only(left: 5.h, top: 17.w)
                  : EdgeInsets.only(left: 4.h, top: 19.w),
              child: InkWell(
                onTap: () {
                  //nextQuestion();
                },
                child: Image.asset(
                  i == widget.questions!.length - 1
                      ? 'assets/start_button.png'
                      : 'assets/ExperimentBackButton.png',
                  width: i == widget.questions!.length - 1
                      ? MediaQuery.of(context).size.width / 11
                      : MediaQuery.of(context).size.width / 20,
                  height: i == widget.questions!.length - 1
                      ? MediaQuery.of(context).size.width / 10
                      : MediaQuery.of(context).size.width / 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onChanged(int? value) {
    setState(() {
      chosenAnswer = value!;
    });
  }
}
