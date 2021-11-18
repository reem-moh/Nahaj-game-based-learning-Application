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
                    if (paused) {
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
                    }
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
