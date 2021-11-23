import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:nahaj/HomePage/category.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';
import 'database.dart';

class Experiment extends StatefulWidget {
  final String category;
  final DataBase db;
  final ExperimentInfo exp;
  const Experiment(
      {Key? key, required this.category, required this.db, required this.exp})
      : super(key: key);

  @override
  _Experiment createState() => _Experiment();
}

class _Experiment extends State<Experiment> {
  late UnityWidgetController _unityWidgetController;
  bool paused = false;
  bool showQuestions = false;
  double buttonWidth = 0;
  double buttonHeight = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _unityWidgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonWidth = MediaQuery.of(context).size.width;
    buttonHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Card(
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              UnityWidget(
                borderRadius: BorderRadius.all(Radius.zero),
                onUnityCreated: _onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, top: 20),
                child: InkWell(
                  child: Image.asset(
                    'assets/ExperimentBackButton.png',
                    height: 60,
                    width: 60,
                  ),
                  onTap: () {
                    exitExperiment();
                    /*if (paused) {
                      _unityWidgetController.resume()!.then((value) =>
                          _unityWidgetController
                              .unload()!
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Category(
                                              categoryTitle: widget.category,
                                              db: widget.db,
                                            )),
                                  )));
                    } else {
                      _unityWidgetController
                          .unload()!
                          .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Category(
                                          categoryTitle: widget.category,
                                          db: widget.db,
                                        )),
                              ));
                    }*/
                  },
                ),
              ),
            ],
          )),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    if (message.toString() == "END") {
      //if quit shows error let user unload(), quit()
      _unityWidgetController.pause()!.then((value) => paused = true);
      print(paused);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return QuestionsWidget(
              db: widget.db,
              expID: widget.exp.id,
              exp: widget.exp,
            );
          });
    }
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo!.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
    _unityWidgetController.pause();
    _unityWidgetController.resume();
  }

  void exitExperiment() {
    if (paused) {
      _unityWidgetController.resume()!.then((value) =>
          _unityWidgetController.unload()!.then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Category(
                          categoryTitle: widget.category,
                          db: widget.db,
                        )),
              )));
    } else {
      _unityWidgetController.unload()!.then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                      categoryTitle: widget.category,
                      db: widget.db,
                    )),
          ));
    }
  }
}

//Experiments stream builder
// ignore: must_be_immutable
class QuestionsWidget extends StatelessWidget {
  final String expID;
  final ExperimentInfo exp;
  final DataBase db;
  int i = 0;

  QuestionsWidget({
    required this.db,
    required this.expID,
    required this.exp,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Question>>(
        stream: db.getQuestions(expID),
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
                        expID: expID,
                        exp: exp,
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
  final String expID;
  final ExperimentInfo exp;
  final DataBase db;

  QuestionCard({
    required this.questions,
    required this.db,
    required this.expID,
    required this.exp,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int i = 0;
  int chosenAnswer = 0;
  int userScore = 0;
  double fontSize = 6;

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
            Image.asset(
              'assets/QuestionBackground.png',
              width: 70.h,
            ),
            Container(
              margin: EdgeInsets.only(right: 14.5.h),
              child: Column(
                children: [
                  Container(
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 15.h,
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
                              margin: EdgeInsets.only(right: 15.h),
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
                  nextQuestion();
                },
                child: Image.asset(
                  i == widget.questions!.length - 1
                      ? 'assets/start_button.png'
                      : 'assets/ExperimentBackButton.png',
                  width: i == widget.questions!.length - 1
                      ? MediaQuery.of(context).size.width / 10
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

  void nextQuestion() {
//check if i is within array bounds
    if (i < widget.questions!.length) {
      //check if answer is chosen
      if (chosenAnswer == 0) {
        //banner error message

      } else {
        //check if last question
        if (i == widget.questions!.length - 1) {
          sendScore();
          //if not the last question
        } else {
          //if answered correctly
          if (widget.questions![i].answers[chosenAnswer - 1] ==
              widget.questions![i].correctAnswer) {
            //banner correct answer
            //update score
            userScore += widget.questions![i].score;
            print(widget.questions![i].correctAnswer +
                "  " +
                widget.questions![i].answers[chosenAnswer - 1] +
                " " +
                userScore.toString());
            //reset radio button group value and increment i
            setState(() {
              chosenAnswer = 0;
              i++;
            });
          } else {
            //answer wrong
            //banner wrong answer
            //reset radio button group value and increment i
            setState(() {
              chosenAnswer = 0;
              i++;
            });
          }
        }
      }
    }
  }

  void sendScore() {
    _Experiment _experiment = _Experiment();
//check answer of last question
    if (widget.questions![i].answers[chosenAnswer - 1] ==
        widget.questions![i].correctAnswer) {
      //banner correct answer
      userScore += widget.questions![i].score;
    } else {
      //banner wrong answer
    }
    //update score with experiment score
    userScore += widget.exp.experimentScore;

    widget.db.updateExpScore(widget.expID, userScore);

    //alert of score
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            content: Container(
              width: 30.h,
              height: 30.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ScoreBackground.png'),
                  scale: 0.5,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '🎊',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize.sp,
                            color: Color.fromARGB(255, 0, 71, 147),
                          ),
                        ),
                        Text(
                          'لقد أجبت على جميع الأسئلة بنجاح',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize.sp,
                            color: Color.fromARGB(255, 0, 71, 147),
                          ),
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/ٍReturnButton.png',
                            width: 10.h,
                          ),
                          onTap: () {
                            _experiment.exitExperiment();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
