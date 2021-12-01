import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/expriment.dart';
import 'package:sizer/sizer.dart';
import '../NahajClasses/child.dart';
import '../database.dart';
import 'ExpInfo.dart';

List<ExperimentInfo> experiments = [];

class Admin extends StatefulWidget {
  final DataBase db;
  final String categoryTitle;
  const Admin({
    Key? key,
    required this.categoryTitle,
    required this.db,
  }) : super(key: key);

  @override
  _Admin createState() => _Admin();
}

class _Admin extends State<Admin> {
  @override
  void initState() {
    super.initState();
    //print(experiments.first.id);
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
                  //List of Expreiments
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ':التجارب',
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
                ]),

                //list view
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80),
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: ExperimentsWidget(
                    category: widget.categoryTitle,
                    db: widget.db,
                  ),
                  /*ListView.separated(
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
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),*/
                ),
              ]))
            ],
          ),
          // ignore: deprecated_member_use
        ],
      ),
    );
  }
}

//Experiments stream builder
class ExperimentsWidget extends StatelessWidget {
  final String category;
  final DataBase db;

  const ExperimentsWidget({
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
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allExperiments = snapshot.data;
                return allExperiments == null
                    ? buildText('لا توجد تجارب')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allExperiments.length,
                        itemBuilder: (context, index) {
                          final exp = allExperiments[index]; //[index];

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
              builder: (context) => ExpInfo(
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
                    //ScoreStars(widget.exp.userScore, widget.exp.totalScore),
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
