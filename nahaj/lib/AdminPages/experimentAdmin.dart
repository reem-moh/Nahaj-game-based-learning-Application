import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';
import '../../NahajClasses/child.dart';
import 'package:nahaj/presenter.dart';
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
  bool validName = true;
  bool validCategory = true;
  bool validExperimentScore = true;
  bool validInfo = true;

  bool changes = false;
  bool savedChanges = true;

  int dropdownvalue = 1;
  List<int> items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String dropdownCategory = "الكيمياء";
  List<String> itemsCategory = ['الكيمياء', 'الحيوانات', "النباتات"];

  String name = "";
  String info = "";
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    dropdownCategory = widget.exp.category;
    info = widget.exp.info;
    name = widget.exp.name;
    dropdownvalue = widget.exp.experimentScore;
    totalScore = widget.exp.totalScore;
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

          //Exp information
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
                    //ِExperiment
                    Center(
                      child: textFieldInput('معلومات التجربة ', 3),
                    ),
                    SizedBox(height: 15.1.w),

                    //ِExperiment info
                    buildInfo(),
                    SizedBox(height: 3.4.w),

                    //Questions
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),

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
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.30,
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
                                              builder: (context) =>
                                                  QuestionCard(
                                                    db: widget.db,
                                                    exp: widget.exp,
                                                    question: new Question(
                                                        id: '',
                                                        expID: widget.exp.id,
                                                        question: '',
                                                        answers: [
                                                          '',
                                                          '',
                                                          '',
                                                          ''
                                                        ],
                                                        correctAnswer: '',
                                                        score: 1),
                                                    index: -1,
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
                    SizedBox(height: 3.4.w),

                    //Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 3.4.w),
                            buildButton('حفظ التغييرات'),
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
      // ],
      // ),
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

  Widget buildInfo() => Container(
        margin: EdgeInsets.only(left: 10.h),
        child: Column(
          children: [
            //exp name
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
                      initialValue: widget.exp.name,
                      textAlign: TextAlign.start,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true),
                      validator: (val) {
                        savedChanges = false;
                        name = val!;
                        if (val.length <= 0) {
                          validName = false;
                          return 'هذا الحقل مطلوب';
                        } else {
                          validName = true;
                        }
                        if (!validName) {
                          return 'الرجاء كتابة اسم التجربه';
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
                    child: textFieldInput(": أسم التجربة *", 2.7)),
              ],
            ),
            SizedBox(height: 6.0.w),

            //exp category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Score drop down Question
                Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width * 0.49,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 0),
                    child: dropDownCategory()
                    // Container()
                    ),
                //Score name
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textFieldInput(':  الصنف *', 2.7)),
              ],
            ),
            SizedBox(height: 3.0.w),

            //exp score
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
                    child: textFieldInput(': نقاط التجربة *', 2.7)),
              ],
            ),
            SizedBox(height: 3.0.w),

            //exp description
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
                      initialValue: widget.exp.name,
                      textAlign: TextAlign.start,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true),
                      validator: (val) {
                        savedChanges = false;
                        info = val!;
                        if (val.length <= 0) {
                          validInfo = false;
                          return 'هذا الحقل مطلوب';
                        } else {
                          validInfo = true;
                        }
                        if (!validInfo) {
                          return ' الرجاء كتابة وصف';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: textFieldInput(": وصف التجربة *", 2.7)),
              ],
            ),
            SizedBox(height: 6.0.w),

            //total score
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
                      enabled: false,
                      textDirection: TextDirection.rtl,
                      initialValue: "${widget.exp.totalScore}",
                      textAlign: TextAlign.start,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorRadius: Radius.circular(50),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                ),

                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.4,
                    //padding:
                    //  EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 0),
                    child: textFieldInput(": المجموع الكلي للتجربة ", 2.7)),
              ],
            ),
            SizedBox(height: 6.0.w),
          ],
        ),
      );

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
              widget.exp.totalScore =
                  totalScore - dropdownvalue + (newValue as int);
              dropdownvalue = newValue;
            });
          },
        ),
      ),
    );
  }

  Container dropDownCategory() {
    return Container(
      child: InputDecorator(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true),
        child: DropdownButton(
          alignment: Alignment.centerRight,
          value: dropdownCategory,
          menuMaxHeight: 180,
          icon: Icon(Icons.keyboard_arrow_down),
          items: itemsCategory.map((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              dropdownCategory = newValue as String;
            });
          },
        ),
      ),
    );
  }

  void updateExp(
      String name, String category, String info, int experimentScore) {

    if (widget.exp.name == name) {
      print("user did not change the name!");
    } else {
      print("inside ");
      widget.db
          .updateExpName(widget.exp.id, name)
          .then((value) => print("user changes the name"));
      widget.exp.name = name;
      validName = true;
    }

    widget.db
        .updateExpCategory(widget.exp.id, category)
        .then((value) => print("user changes the category"));
    widget.exp.category = category;
    validCategory = true;
    //changed = true;

    if (widget.exp.info == info) {
      print("user did not change the info!");
    } else {
      widget.db
          .updateExpInfo(widget.exp.id, info)
          .then((value) => print("user changes the info"));
      widget.exp.info = info;
      validInfo = true;
      //changed = true;
    }

    widget.db.updateExpScor(widget.exp.id, experimentScore).then((value) => print("user changes the experimentScore"));
    widget.exp.experimentScore = experimentScore;
    validExperimentScore = true;

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
  }

  Widget buildButton(String text) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
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
          if (noError()) {
            showDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                    title: Text("هل انت متاكد ؟"),
                    actions: [
                      //yes
                      ElevatedButton(
                          onPressed: () {
                            //new question
                            updateExp(
                                name, dropdownCategory, info, dropdownvalue);
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

  bool noError() {
    print("inside no error? ${validName && validInfo}");
    return validName && validInfo;
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
                    ? ListView(children: [
                        Container(
                            margin: EdgeInsets.only(left: 30.0, right: 30.0),
                            height: 18.00.h,
                            child: CardsOfQuestions(
                              db: widget.db,
                              exp: widget.exp,
                              question: new Question(
                                  id: '',
                                  expID: widget.exp.id,
                                  question: '',
                                  answers: ['', '', '', ''],
                                  correctAnswer: '',
                                  score: 1),
                              index: -1,
                            )),
                        buildText('لا توجد أسئلة')
                      ])
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
        index != -1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionCard(
                    db: db,
                    question: question,
                    exp: exp,
                    index: counter,
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionCard(
                    db: db,
                    question: question,
                    exp: exp,
                    index: index,
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
              child: index == -1
                  ? Icon(
                      Icons.add,
                      size: 85,
                      color: Colors.black,
                    )
                  : Text("$counter",
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
            child: index == -1
                ? Text(
                    "إضافة سؤال",
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 2.2.w,
                        color: Color.fromARGB(170, 0, 0, 0)),
                  )
                : Text(
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

  @override
  void initState() {
    super.initState();
    answers = widget.question.answers;
    questionString = widget.question.question;
    dropdownvalue = widget.question.score;
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
                        'يجب تعبئة البيانات المطلوبه (*)',
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
                            deleteQuestion(
                              widget.question.expID,
                              widget.question.id,
                            );
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
              dropdownvalue)
          .then((value) {
        print("update question");
        print(
            "${widget.question.expID},${widget.question.id},$questionString,${answers[0]},${answers[1]},${answers[2]},${answers[3]},${answers[_raidoButtonValue - 1]},${dropdownvalue}, ${savedChanges = true}");
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

  bool deleteQuestion(String expID, String questionId) {
    widget.db.deleteQuestion(expID, questionId).then((value) {
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
