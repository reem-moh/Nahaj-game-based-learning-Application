import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/expriment.dart';
import 'package:sizer/sizer.dart';
import '../NahajClasses/child.dart';
import '../database.dart';
import 'homePage.dart';

class Category extends StatefulWidget {
  final DataBase db;
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
  List<ExperimentInfo> experiments = [
    ExperimentInfo(
        name: 'تجربة البركان',
        category: "الكيمياء",
        info: 'تجربة كيميائية توضع طريقة التفاعل الكيميائي',
        pathOfImage: "",
        totalScore: 15,
        experimentScore: 7,
        questions: [],
        userScore: 2)
  ];

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
                child: ListView.separated(
                  reverse: true,
                  itemCount: experiments.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 25,
                    );
                  },
                  itemBuilder: (_, i) {
                    return ExperimentCard(
                      category: widget.categoryTitle,
                      db: widget.db,
                      exp: experiments.elementAt(i),
                      experiments: experiments,
                    );
                  },
                  scrollDirection: Axis.horizontal,
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
                          )),
                );
              });
            },
          ),
          //Category
          Container(
            padding: EdgeInsets.only(top: 3.5.w),
            alignment: Alignment.topCenter,
            child: CategoryCard(
              cardColor: widget.categoryTitle == 'الكيمياء'
                  ? Color.fromARGB(255, 223, 221, 223)
                  : widget.categoryTitle == 'النباتات'
                      ? Color.fromARGB(255, 202, 203, 203)
                      : Color.fromARGB(255, 230, 230, 230),
              title: widget.categoryTitle,
              image: widget.categoryTitle == 'الكيمياء'
                  ? 'assets/chemistry.gif'
                  : widget.categoryTitle == 'النباتات'
                      ? 'assets/plants.gif'
                      : 'assets/animals.png',
              size1: 23.0,
              size2: 15.0,
              size3: 20.0,
              fontSize: 2,
              db: widget.db,
            ),
          ),
        ],
      ),
    );
  }
}

class ExperimentCard extends StatefulWidget {
  final String category;
  final DataBase db;
  final ExperimentInfo exp;
  final List<ExperimentInfo> experiments;
  const ExperimentCard(
      {required this.category,
      required this.db,
      required this.exp,
      required this.experiments});
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
                    experiments: widget.experiments,
                  )),
        );
      },
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
          Container(
            //margin: EdgeInsets.only(left: 2.0.h),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 3.4,
            height: MediaQuery.of(context).size.height / 3.8,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Image.asset(
              "assets/VolcanoExperimebt.png",
              width: MediaQuery.of(context).size.width / 4,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.4,
            height: MediaQuery.of(context).size.height / 9,
            margin: EdgeInsets.only(top: 25.0.w),
            padding: EdgeInsets.only(top: 1.0.w, left: 1.0.h, right: 1.0.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.exp.name,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 2.2.w,
                          color: Color.fromARGB(170, 0, 0, 0)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.6.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.exp.info,
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
