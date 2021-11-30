import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/expriment.dart';
import 'package:sizer/sizer.dart';
import '../NahajClasses/child.dart';
import '../database.dart';

bool showLevelDialog = false;
int userLevelUpdated = 0;

class Category extends StatefulWidget {
  final DataBase db;
  final String categoryTitle;
  final User user;
  const Category({
    Key? key,
    required this.categoryTitle,
    required this.db,
    required this.user,
  }) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends State<Category> {
  @override
  void initState() {
    super.initState();
    if (showLevelDialog) {
      Future.delayed(Duration(seconds: 2), () {
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
                  user: widget.user,
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
                Navigator.of(context).push(MaterialPageRoute(
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
}

//Experiments stream builder
// ignore: must_be_immutable
class ExperimentsWidget extends StatelessWidget {
  final User user;
  final String category;
  final DataBase db;
  List<ExperimentInfo>? allExperiments;

  ExperimentsWidget({
    required this.db,
    required this.category,
    required this.user,
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
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                allExperiments = snapshot.data;
                checkUserLeve(context);
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
  void checkUserLeve(BuildContext context) {
    int x = 0;
    int newLevel = 0;
    for (var exp in allExperiments!) {
      x += exp.userScore;
    }
    switch (x) {
      case 5:
        newLevel = 1;
        break;
      case 10:
        newLevel = 2;
        break;
      case 15:
        newLevel = 3;
        break;
      case 20:
        newLevel = 4;
        break;
      case 25:
        newLevel = 5;
        break;
      case 30:
        newLevel = 6;
        break;
      case 35:
        newLevel = 7;
        break;
      case 40:
        newLevel = 8;
        break;
      case 45:
        newLevel = 9;
        break;
      case 50:
        newLevel = 10;
        break;
      case 55:
        newLevel = 11;
        break;
      case 60:
        newLevel = 12;
        break;
      case 65:
        newLevel = 13;
        break;
      case 70:
        newLevel = 14;
        break;
      case 75:
        newLevel = 15;
        break;
      case 80:
        newLevel = 16;
        break;
      case 85:
        newLevel = 17;
        break;
      case 90:
        newLevel = 18;
        break;
      case 95:
        newLevel = 19;
        break;
      case 100:
        newLevel = 20;
        break;
      case 105:
        newLevel = 21;
        break;
      case 110:
        newLevel = 22;
        break;
      case 115:
        newLevel = 23;
        break;
      case 120:
        newLevel = 24;
        break;
      case 125:
        newLevel = 25;
        break;
    }
    if (newLevel > user.level) {
      db.updateUserLevel(user.userId, newLevel);
      db.userInfo(user.userId);
      userLevelUpdated = newLevel;
      showLevelDialog = true;
      print('\nuser new level after update' + user.level.toString());
    }
  }
}

class ExperimentCard extends StatefulWidget {
  final String category;
  final DataBase db;
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
            child: Image.network(
              widget.exp.expImage,
              width: 200.0.h,
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
                    ScoreStars(widget.exp.userScore, widget.exp.totalScore),
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
class ScoreStars extends StatelessWidget {
  var userScore, totalScore;
  String star1 = 'assets/EmptyRatingStar.png';
  String star2 = 'assets/EmptyRatingStar.png';
  String star3 = 'assets/EmptyRatingStar.png';

  ScoreStars(us, ts) {
    userScore = us;
    totalScore = ts;
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

  setStars() {
    var result = userScore * 3 / totalScore;
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
}
