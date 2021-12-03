import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';
import '../../NahajClasses/child.dart';
import '../../database.dart';
import 'QuestionAdmin.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 150, vertical: 0),
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
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
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
/*
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
              */
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
                        });
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
              child: Text("$index",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 2.2.w,
                      color: Colors.black)),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
            )),
          ),
          Container(
            child: Text(
              "سؤال $index",
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
