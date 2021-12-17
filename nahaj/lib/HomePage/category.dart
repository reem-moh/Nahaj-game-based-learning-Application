import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/NahajClasses/classes.dart';
import 'package:nahaj/expriment.dart';
import 'package:sizer/sizer.dart';
import '../NahajClasses/classes.dart';
import '../presenter.dart';

bool showLevelDialog = false;
int userLevelUpdated = 0;

class Category extends StatefulWidget {
  final Presenter db;
  final String categoryTitle;

  const Category({
    Key? key,
    required this.categoryTitle,
    required this.db,
  }) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends State<Category> {
  @override
  void initState() {
    super.initState();
    checkUserLeve().then((value) {
      if (showLevelDialog) {
        Future.delayed(Duration(milliseconds: 10), () {
          showDialog(
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  "تهانينا🎉",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                  ),
                ),
                content: Text(
                  'لقد وصلت إلى المستوى ' + userLevelUpdated.toString(),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        showLevelDialog = false;
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "حسناً",
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
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.9,
                  child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/CategoryBackground.png"))),
              //list view
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 25),
                height: MediaQuery.of(context).size.height / 2.5,
                child: ExperimentsWidget(
                  category: widget.categoryTitle,
                  db: widget.db,
                ),
              ),
            ],
          ),
          //Back button
          // ignore: deprecated_member_use
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0.w, left: 0.0.w),
              child: Image(
                image: AssetImage("assets/PreviosButton.png"),
                alignment: Alignment.topLeft,
              ),
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              db: widget.db,
                            )));
              });
            },
          ),
          //Category
          Container(
            padding: EdgeInsets.only(top: 8.5.w),
            alignment: Alignment.topCenter,
            child: Text(
              widget.categoryTitle,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 5.w,
                  color: Color.fromARGB(255, 114, 78, 140)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkUserLeve() async {
    int x = 0;
    int newLevel = 0;
    await widget.db.getAllUserScores(user_.userId).then((value) => x = value);
    print('score is ' + x.toString());
    if (x >= 5 && x < 10)
      newLevel = 1;
    else if (x >= 10 && x < 15)
      newLevel = 2;
    else if (x >= 15 && x < 20)
      newLevel = 3;
    else if (x >= 20 && x < 25)
      newLevel = 4;
    else if (x >= 25 && x < 30)
      newLevel = 5;
    else if (x >= 30 && x < 35)
      newLevel = 6;
    else if (x >= 35 && x < 40)
      newLevel = 7;
    else if (x >= 40 && x < 45)
      newLevel = 8;
    else if (x >= 45 && x < 50)
      newLevel = 9;
    else if (x >= 50 && x < 55)
      newLevel = 10;
    else if (x >= 55 && x < 60)
      newLevel = 11;
    else if (x >= 60 && x < 65)
      newLevel = 12;
    else if (x >= 65 && x < 70)
      newLevel = 13;
    else if (x >= 70 && x < 75)
      newLevel = 14;
    else if (x >= 75 && x < 80)
      newLevel = 15;
    else if (x >= 80 && x < 85)
      newLevel = 16;
    else if (x >= 85 && x < 90)
      newLevel = 17;
    else if (x >= 90 && x < 95)
      newLevel = 18;
    else if (x >= 95 && x < 100)
      newLevel = 19;
    else if (x >= 100 && x < 105)
      newLevel = 20;
    else if (x >= 105 && x < 110)
      newLevel = 21;
    else if (x >= 110 && x < 115)
      newLevel = 22;
    else if (x >= 115 && x < 120)
      newLevel = 23;
    else if (x >= 120 && x < 125)
      newLevel = 24;
    else if (x >= 125 && x < 130) newLevel = 25;

    print(user_.level.toString() + " " + newLevel.toString());
    if (newLevel > user_.level) {
      widget.db.updateUserLevel(user_.userId, newLevel);
      widget.db.userInfo(user_.userId);
      setState(() {
        userLevelUpdated = newLevel;
        showLevelDialog = true;
      });
      print(user_.level.toString() + " " + newLevel.toString());
      return;
    }
  }
}

//Experiments stream builder
// ignore: must_be_immutable
class ExperimentsWidget extends StatelessWidget {
  final String category;
  final Presenter db;
  List<ExperimentInfo>? allExperiments;

  ExperimentsWidget({
    required this.db,
    required this.category,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ExperimentInfo>>(
        stream: db.getExperiments(category),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText(
                    'Something Went Wrong Try later ${snapshot.error}');
              } else {
                allExperiments = snapshot.data;
                //checkUserLeve();
                return allExperiments == null
                    ? buildText('لا توجد تجارب')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allExperiments!.length,
                        itemBuilder: (context, index) {
                          final exp = allExperiments![index]; //[index];

                          return ExperimentCard(
                            category: category,
                            db: db,
                            exp: exp,
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

class ExperimentCard extends StatefulWidget {
  final String category;
  final Presenter db;
  final ExperimentInfo exp;
  const ExperimentCard({
    required this.category,
    required this.db,
    required this.exp,
  });
  @override
  State<ExperimentCard> createState() => _ExperimentCardState();
}

class _ExperimentCardState extends State<ExperimentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Experiment(
                    category: widget.category,
                    db: widget.db,
                    exp: widget.exp,
                  )),
        );
      },
      //white container
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 10),
        width: MediaQuery.of(context).size.width / 3.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(7, 7),
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Stack(children: [
          //image container
          Container(
            alignment: Alignment.topCenter,
            width: (MediaQuery.of(context).size.width / 3.4).h,
            height: (MediaQuery.of(context).size.height / 3.8).w,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 1.w),
              child: Image.network(
                widget.exp.expImage,
                width: 200.h,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    padding: EdgeInsets.only(top: 10.w),
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          //info container
          Container(
            width: (MediaQuery.of(context).size.width / 3.4).h,
            height: (MediaQuery.of(context).size.height / 9).w,
            margin: EdgeInsets.only(top: 25.0.w),
            padding: EdgeInsets.only(top: 1.0.w, left: 1.0.h, right: 1.0.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                //experiment name and score stars
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //stars
                    ScoreStars(widget.exp.id, widget.exp.totalScore, widget.db),
                    //name
                    Text(
                      widget.exp.name,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 2.2.w,
                          color: Color.fromARGB(255, 114, 78, 140)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.6.w,
                ),
                //experiment info
                Wrap(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  direction: Axis.vertical, // main axis (rows or columns)
                  children: [
                    Text(
                      widget.exp.info,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 1.5.w,
                        color: Color.fromARGB(170, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class ScoreStars extends StatefulWidget {
  var totalScore, expId;
  late Presenter db;

  ScoreStars(expid, ts, d) {
    expId = expid;
    totalScore = ts;
    db = d;
  }

  @override
  State<ScoreStars> createState() => _ScoreStarsState();
}

class _ScoreStarsState extends State<ScoreStars> {
  var userScore = 0;

  String star1 = 'assets/EmptyRatingStar.png';

  String star2 = 'assets/EmptyRatingStar.png';

  String star3 = 'assets/EmptyRatingStar.png';

  @override
  void initState() {
    super.initState();
    setStars();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            star1,
            width: 3.h,
            height: 3.w,
          ),
          Image.asset(
            star2,
            width: 3.h,
            height: 3.w,
          ),
          Image.asset(
            star3,
            width: 3.h,
            height: 3.w,
          ),
        ],
      ),
    );
  }

  setStars() async {
    userScore = await widget.db.getUserScore(user_.userId, widget.expId);
    print(userScore);
    var result = userScore * 3 / widget.totalScore;
    print(result);
    if (this.mounted) {
      setState(() {
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
      });
    }
  }
}
