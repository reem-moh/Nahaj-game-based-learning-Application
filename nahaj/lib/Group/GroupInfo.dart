import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:nahaj/database.dart';
import 'package:sizer/sizer.dart';

import 'addGroup.dart';
import 'groupChat.dart';

class GroupInfo extends StatefulWidget {
  final DataBase db;
  final User user;

  final Groups group;

  GroupInfo(
      {Key? key, required this.db, required this.group, required this.user})
      : super(key: key);

  @override
  _GroupInfo createState() => _GroupInfo();
}

class _GroupInfo extends State<GroupInfo> {
  get itemBuilder => null;
  File? pathOfImage;

  get db => null;

  get group => null;

  get user => null;

  get text => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/SignUpSignInbackground.png"),
                    fit: BoxFit.cover)),
          ),
          //
          //
          //list view container
          Wrap(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              //image of group
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.all(0).copyWith(right: 450, bottom: 40),
                      child: TextButton(
                        child: Image(
                          image: AssetImage("assets/PreviosButton.png"),
                          alignment: Alignment.topCenter,
                        ),
                        onPressed: () {
                          setState(() {
                             Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Group(db: db, group: group, user: user)),
        );;
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            //Group Image
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                        120.0) //                 <--- border radius here
                                    ),
                                border: Border.all(color: Colors.grey)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: pathOfImage != null
                                  ? ClipOval(
                                      child: Image.file(pathOfImage!,
                                          fit: BoxFit.cover),
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                          widget.group.pathOfImage,
                                          //"assets/owl1.png",
                                          fit: BoxFit.cover)),
                            ),
                          ),
                          //Camera Iamge
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // name of group
              Center(
                child: Text(
                  widget.group.groupName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                  ),
                ),
              ),
  SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),

//2
              //cards
              Center(
                child: Container(
                   alignment: Alignment.center,
                    height: 500,
                    width: 700,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        //bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 2,
                          blurRadius: 2,
                          //offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: CardsOfGroup(
                            db: widget.db,
                            user: widget.user,
                            group: widget.group,
                            members: getMembers(widget.group.members),
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.63,
              ),

//3
              // delete group
              Center(child: buildUpgradeButton()),

              
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
  
    text:( widget.user.userId == widget.group.leaderId)?
        ( 'حذف المجموعة'): 
( 'الخروج من المجموعة '),

 
  
  
    onClicked: () { 

    if( text == 'حذف المجموعة'){
                //method delet Group

    }
    else
    {
                 //method delet member


    }
     }, 
  
      );
  List getMembers(List members) {
    var users = [];

    members.forEach((member) {
      final list = member.values.toList();
      list.forEach((w) {
        print("Key: ${w} ");
        users.add(w);

      });
    });
    print("get members in group info list: $users member: $members");
    return users;
  }
}

class ButtonWidget extends StatelessWidget {
  final String text; 

  
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked, child, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class CardsOfGroup extends StatelessWidget {
  final User user;
  final DataBase db;
  final Groups group;
  final List members;


  //get group => null;

 // get user => null;


  CardsOfGroup({
    required this.user,
    required this.db,
    Key? key,
    required this.group,
    required this.members,
  }) : super(key: key);

  List members11 = [
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
    {
      'userId': 'leaderId',
      'userName': 'leaderName',
    },
  ];
  @override
  //change to Map
  Widget build(BuildContext context) => StreamBuilder<List<User>>(
        stream: db.getMembers(members),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText(
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allMembers = snapshot.data;
                return allMembers == null
                    ? buildText('لا يوجد لديك مجموعات!')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allMembers.length,
                        itemBuilder: (context, index) {
                          final member = allMembers[index]; //[index];

                          return Center(
                            child: Container( alignment: Alignment.center,
                              height: 90,
                              width: 700,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  //bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.05),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    //offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FocusedMenuHolder(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 15.00.h,
                                  ),
                                  child: Row( // if ranking == 1 || ranking == 2 || ranking == 3
                                    children: [ 
                                      
                                      
                                      
                                      Center(
                                      child: (/*member.level==1*/true)?
                                        Container(
  padding:
                            EdgeInsets.all(0).copyWith(left: 0),                                      child: Stack(
                                            //alignment: Alignment.topCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                padding: const EdgeInsets.all(3.0),
                                                //Group Image
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            50.0) //                 <--- border radius here
                                                        ),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                              
                                                      child: Image.asset(
                                                          ("assets/Ranking.png"), /* num1 */
                                                          fit: BoxFit.cover ,)
                                                
                                              ),
                                              //Camera Iamge
                                            ],
                                          ),
                                        // ignore: dead_code
                                        ):((member.level==2)?( Container(
  padding:
                            EdgeInsets.all(0).copyWith(left: 0),                                      child: Stack(
                                            //alignment: Alignment.topCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                padding: const EdgeInsets.all(3.0),
                                                //Group Image
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            50.0) //                 <--- border radius here
                                                        ),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                              
                                                      child: Image.asset(
                                                          ("assets/Ranking.png"), /* num2 */
                                                          fit: BoxFit.cover ,)
                                                
                                              ),
                                              //Camera Iamge
                                            ],
                                          ),
                                        )):((member.level==3)?( Container(
                                           padding:
                            EdgeInsets.all(0).copyWith(left: 0),
                                          child: Stack(
                                        //    alignment: Alignment.topCenter,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.all(10.0),
                                                padding: const EdgeInsets.all(3.0),
                                                //Group Image
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            50.0) //                 <--- border radius here
                                                        ),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                              
                                                      child: Image.asset(
                                                          ("assets/Ranking.png"), /* num3 */
                                                          fit: BoxFit.cover ,)
                                                
                                              ),
                                              //Camera Iamge
                                            ],
                                          ),
                                        )):(Container(/* without */)))),
                                    ),
  SizedBox(
                width: MediaQuery.of(context).size.height * 0.05 ,
              ),

(member.userId==group.leaderId)?Center(
  child:   (   Container(          alignment: Alignment.center,

              child: Text(
                "Leader",
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 3.2.w,
                    color: Color.fromARGB(170, 0, 0, 0)),
              ),
            )),
):(Container()),

                                      Container(   padding:
                            EdgeInsets.all(0).copyWith(right: 0),

                                        child: MembersCard(
                                          db: db,
                                          member: member,
                                          user: user,
                                        ),
                                      ),

                                      // Image.asset("assets/owl1.png")
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                                openWithTap: true,
                                menuWidth:
                                    MediaQuery.of(context).size.width * 0.30,
                                menuItems: [
                                   FocusedMenuItem(
                                      title: Text(
                                          member.username,
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 1.5.w,
                                        ),
                                      ),
                                    //  trailingIcon: Icon(Icons.group),
                                      onPressed: () {}),
                                  FocusedMenuItem(
                                      title: Text(
                                        "حذف العضو",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 1.5.w,
                                        ),
                                      ),
                                      trailingIcon: Icon(Icons.group),
                                      onPressed: () {}),
                                ],
                              ),
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical,
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

class MembersCard extends StatelessWidget {
  final DataBase db;
  final User member;
  final User user;
  MembersCard(
      {Key? key, required this.db, required this.member, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('مجموعة');
        /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Group(db: db, group: group, user: user)),
        );*/
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5.00.h,
            height: 5.00.w,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          Container(
            child: Text(
              member.username,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 3.2.w,
                  color: Color.fromARGB(170, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}
