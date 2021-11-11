import 'package:flutter/material.dart';
import 'package:nahaj/child.dart';
import 'package:nahaj/expriment.dart';

class Category extends StatefulWidget {
  final String categoryTitle;
  const Category({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends State<Category> {
  List<ExperimentInfo> experiments = [
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ]),
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ]),
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ]),
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ]),
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ]),
    ExperimentInfo(
        name: 'تجربة البركان',
        category: '',
        info: '',
        pathOfImage: '',
        totalScore: 15,
        experimentScore: 5,
        questions: [
          Question(
              question: 'question',
              answers: ['answers'],
              correctAnswer: 'correctAnswer',
              score: 2)
        ])
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
                  itemCount: 1 /*experiments.length*/,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 25,
                    );
                  },
                  itemBuilder: (_, i) {
                    return ExperimentCard(category: widget.categoryTitle);
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExperimentCard extends StatefulWidget {
  final String category;

  const ExperimentCard({required this.category});
  @override
  State<ExperimentCard> createState() => _ExperimentCardState();
}

class _ExperimentCardState extends State<ExperimentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 10),
      width: MediaQuery.of(context).size.width / 3.4,
      //height: MediaQuery.of(context).size.height / 3.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
          )
        ],
      ),
      child: Stack(children: [
        InkWell(
          child: Text('volcano'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Experiment(category: widget.category)),
            );
          },
        ),
      ]),
    );
  }
}
