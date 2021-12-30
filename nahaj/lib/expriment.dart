import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:nahaj/NahajClasses/classes.dart';
import 'package:sizer/sizer.dart';
import 'HomePage/category.dart';
import 'presenter.dart';

class Experiment extends StatefulWidget {
  final String category;
  final Presenter db;
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
              //Back button
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
                    showDialog(
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            "هل تريد الخروج بدون إنهاء التجربة؟",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  exitExperiment();
                                },
                                child: Text(
                                  "نعم",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                  ),
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                  ),
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
          barrierColor: Color.fromARGB(0, 0, 0, 0),
          context: context,
          builder: (BuildContext context) {
            return QuestionsWidget(
              db: widget.db,
              expID: widget.exp.id,
              exp: widget.exp,
              unityWidgetController: _unityWidgetController,
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
    _unityWidgetController.postMessage(
        'SceneManager', 'LoadScene', widget.exp.sceneIndex);
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
  late UnityWidgetController unityWidgetController;
  final String expID;
  final ExperimentInfo exp;
  final Presenter db;

  int i = 0;

  QuestionsWidget({
    required this.db,
    required this.expID,
    required this.exp,
    required this.unityWidgetController,
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
                return allQuestions == null || allQuestions.isEmpty
                    ? //buildText('لا توجد أسئلة')
                    AlertDialog(
                        backgroundColor: Color.fromARGB(0, 0, 0, 0),
                        content: Container(
                          alignment: Alignment.center,
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
                                margin: EdgeInsets.only(top: 5.w),
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'assets/FullRatingStar.png',
                                  width: 10.h,
                                  height: 10.w,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.w),
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(0),
                                      child: Image.asset(
                                        'assets/FullRatingStar.png',
                                        width: 5.h,
                                        height: 5.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.h,
                                    ),
                                    Container(
                                      child: Image.asset(
                                        'assets/FullRatingStar.png',
                                        width: 5.h,
                                        height: 5.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 7.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'لقد أتممت التجربة بنجاح',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 5.sp,
                                        color: Color.fromARGB(255, 0, 71, 147),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.w,
                                    ),
                                    Text(
                                      exp.experimentScore.toString() +
                                          "/" +
                                          exp.totalScore.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 5.sp,
                                        color: Color.fromARGB(255, 0, 71, 147),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.w,
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        'assets/ٍReturnButton.png',
                                        width: 10.h,
                                      ),
                                      onTap: () {
                                        unityWidgetController.resume()!.then(
                                            (value) => unityWidgetController
                                                    .unload()!
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Category(
                                                              categoryTitle:
                                                                  exp.category,
                                                              db: db,
                                                            )),
                                                  );
                                                }));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : QuestionCard(
                        db: db,
                        questions: allQuestions,
                        expID: expID,
                        exp: exp,
                        unityWidgetController: unityWidgetController,
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
  late UnityWidgetController unityWidgetController;
  final List<Question>? questions;
  final String expID;
  final ExperimentInfo exp;
  final Presenter db;

  QuestionCard({
    required this.questions,
    required this.db,
    required this.expID,
    required this.exp,
    required this.unityWidgetController,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int i = 0;
  int chosenAnswer = 0;
  int userScore = 0;
  double fontSize = 5;
  var star1 = '';
  var star2 = '';
  var star3 = '';

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
                  nextQuestion();
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

  void nextQuestion() {
//check if i is within array bounds
    if (i < widget.questions!.length) {
      //check if answer is chosen
      if (chosenAnswer == 0) {
        //banner error message
        showBanner(
            'يجب اختيار إجابة للانتقال للسؤال التالي',
            Icons.dnd_forwardslash_rounded,
            Colors.red,
            17.sp,
            EdgeInsets.only(left: 1.8.h, right: 2.h));
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
            showBanner('أحسنت، الإجابة صحيحة', Icons.check_circle_rounded,
                Colors.green, 17.sp, EdgeInsets.only(left: 1.8.h, right: 2.h));
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
            showBanner(
                "إجابة خاطئة، الإجابة هي " + widget.questions![i].correctAnswer,
                Icons.cancel_rounded,
                Colors.red,
                17.sp,
                EdgeInsets.only(left: 1.8.h, right: 2.h));
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
//check answer of last question
    if (widget.questions![i].answers[chosenAnswer - 1] ==
        widget.questions![i].correctAnswer) {
      //banner correct answer
      showBanner('أحسنت، الإجابة صحيحة', Icons.check_circle_rounded,
          Colors.green, 17.sp, EdgeInsets.only(left: 1.8.h, right: 2.h));
      userScore += widget.questions![i].score;
    } else {
      //banner wrong answer
      showBanner(
          "إجابة خاطئة، الإجابة هي " + widget.questions![i].correctAnswer,
          Icons.cancel_rounded,
          Colors.red,
          17.sp,
          EdgeInsets.only(left: 1.8.h, right: 2.h));
    }
    //update score with experiment score
    userScore += widget.exp.experimentScore;

    widget.db.updateUserScore(widget.expID, userScore);
    setStars();
    //questions widget disapear
    Navigator.pop(context);

    //alert of score
    showDialog(
        barrierColor: Color.fromARGB(0, 0, 0, 0),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            content: Container(
              alignment: Alignment.center,
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
                    margin: EdgeInsets.only(top: 5.w),
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      star2,
                      width: 10.h,
                      height: 10.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.w),
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Image.asset(
                            star1,
                            width: 5.h,
                            height: 5.w,
                          ),
                        ),
                        SizedBox(
                          width: 3.h,
                        ),
                        Container(
                          child: Image.asset(
                            star3,
                            width: 5.h,
                            height: 5.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 7.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لقد أجبت على جميع الأسئلة بنجاح',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize.sp,
                            color: Color.fromARGB(255, 0, 71, 147),
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                          userScore.toString() +
                              "/" +
                              widget.exp.totalScore.toString(),
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize.sp,
                            color: Color.fromARGB(255, 0, 71, 147),
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/ٍReturnButton.png',
                            width: 10.h,
                          ),
                          onTap: () {
                            widget.unityWidgetController.resume();
                            widget.unityWidgetController.unload();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Category(
                                        categoryTitle: widget.exp.category,
                                        db: widget.db,
                                      )),
                            );
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

  setStars() {
    var result = userScore * 3 / widget.exp.totalScore;
//FullRatingStar
    if (result == 0) {
      star1 = 'assets/EmptyRatingStar.png';
      star2 = 'assets/EmptyRatingStar.png';
      star3 = 'assets/EmptyRatingStar.png';
    } else if (result > 0 && result < 1) {
      star1 = 'assets/HalfRatingStar.png';
      star2 = 'assets/EmptyRatingStar.png';
      star3 = 'assets/EmptyRatingStar.png';
    } else if (result == 1) {
      star1 = 'assets/FullRatingStar.png';
      star2 = 'assets/EmptyRatingStar.png';
      star3 = 'assets/EmptyRatingStar.png';
    } else if (result > 1 && result < 2) {
      star1 = 'assets/FullRatingStar.png';
      star2 = 'assets/HalfRatingStar.png';
      star3 = 'assets/EmptyRatingStar.png';
    } else if (result == 2) {
      star1 = 'assets/FullRatingStar.png';
      star2 = 'assets/FullRatingStar.png';
      star3 = 'assets/EmptyRatingStar.png';
    } else if (result > 2 && result < 3) {
      star1 = 'assets/FullRatingStar.png';
      star2 = 'assets/FullRatingStar.png';
      star3 = 'assets/HalfRatingStar.png';
    } else if (result == 3) {
      star1 = 'assets/FullRatingStar.png';
      star2 = 'assets/FullRatingStar.png';
      star3 = 'assets/FullRatingStar.png';
    }
  }

  void showBanner(String msg, IconData icon, Color iconColor, double iconSize,
      EdgeInsetsGeometry iconMargin) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: Duration(seconds: 1),
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Banner(
            msg: msg,
            icon: icon,
            iconColor: iconColor,
            iconSize: iconSize,
            iconMargin: iconMargin,
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 170),
    ));
  }
}

class Banner extends StatefulWidget {
  final String msg;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry iconMargin;
  const Banner(
      {Key? key,
      required this.msg,
      required this.icon,
      required this.iconColor,
      required this.iconSize,
      required this.iconMargin})
      : super(key: key);
  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 44.h,
      height: 10.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/QuestionsBanner.png')),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.msg,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 6.sp,
                  color: Color.fromARGB(255, 0, 71, 147),
                ),
              ),
              Container(
                margin: widget.iconMargin,
                child: Icon(widget.icon,
                    color: widget.iconColor, size: widget.iconSize),
              )
            ],
          )
        ],
      ),
    );
  }
}
