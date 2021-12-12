import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nahaj/NahajClasses/classes.dart';
import 'package:nahaj/presenter.dart';
import 'package:sizer/sizer.dart';

class GroupInfo extends StatefulWidget {
  final Presenter db;
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

          //list view container
          Wrap(
            children: [
              Column(
                children: [
                  //Space between avatar and the screen
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  //Header
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      children: [
                        //back button
                        Container(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            child: Image(
                              image: AssetImage("assets/PreviosButton.png"),
                              alignment: Alignment.topCenter,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 46.w),
                        //image of group
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(1.h),
                            //Group Image
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                        120.0) //                 <--- border radius here
                                    ),
                                border: Border.all(color: Colors.grey)),

                            child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipOval(
                                  child: Image.network(widget.group.groupImage,
                                      fit: BoxFit.cover)),
                            ),
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
                        fontSize: 2.7.w,
                      ),
                    ),
                  ),
                  //goupCode
                  Center(
                    child: Text(
                      "${widget.group.goupCode} :رمز المجموعة ",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.black,
                        fontSize: 2.2.w,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  //list of members
                  Container(
                      alignment: Alignment.center,
                      height: 50.0.w,
                      width: 70.0.h,
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
                      child: Padding(
                        padding: EdgeInsets.all(1.8.w),
                        child: Center(
                          child: CardsOfMembers(
                            db: widget.db,
                            user: widget.user,
                            group: widget.group,
                            members: getMembers(widget.group.members),
                          ),
                        ),
                      )),

//3
                  // delete group
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5.0.w),
                      child: buildUpgradeButton()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: widget.group.leaderId == widget.user.userId
            ? 'حذف المجموعة'
            : 'الخروج من المجموعة',
        onClicked: () {
          showDialog(
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("هل انت متاكد ؟"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        //delete Group
                        widget.group.leaderId == widget.user.userId
                            ? widget.db.removeGroup(widget.group.groupId)
                            : widget.db.removeUserFromGroup(
                                widget.group.groupId, widget.user.userId);

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/HomePage', (Route<dynamic> route) => false);
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
                      child: Text("لا", style: TextStyle(color: Colors.black)),
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
        child: Container(
          padding: EdgeInsets.only(
              top: 1.6.w, bottom: 1.6.w, right: 1.7.w, left: 1.6.w),
          decoration: BoxDecoration(
            color: Colors.red,
            // border: BoxBorder()
          ),
          child: Text(
            widget.group.leaderId == widget.user.userId
                ? 'حذف المجموعة'
                : 'الخروج من المجموعة',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.white,
            ),
          ),
        ),
      );
  List getMembers(List members) {
    var users = [];

    members.forEach((member) {
      final list = member.values.toList();
      list.forEach((w) {
        print("Key: $w ");
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
    required this.onClicked,
    child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape: StadiumBorder(),
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.0.h, vertical: 1.5.h),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class CardsOfMembers extends StatelessWidget {
  final User user;
  final Presenter db;
  final Groups group;
  final List members;

  CardsOfMembers({
    required this.user,
    required this.db,
    Key? key,
    required this.group,
    required this.members,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<User>>(
        stream: db.getMembers(members),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('حدث خطا ما الرجاء المحاوله مره اخرى \n');
              } else {
                final allMembers = snapshot.data;
                allMembers != null
                    ? allMembers.sort((a, b) => b.level.compareTo(a.level))
                    : "";
                return allMembers == null
                    ? buildText('لا يوجد لديك اعضاء!')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: allMembers.length,
                        itemBuilder: (context, index) {
                          final member = allMembers[index]; //[index];

                          return Container(
                              alignment: Alignment.center,
                              height: 12.0.w,
                              width: 70.0.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  //bottomRight: Radius.circular(10)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: user.userId == member.userId
                                        ? Colors.purple.withOpacity(0.08)
                                        : Colors.grey.withOpacity(0.05),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: buildList(context, member, index));
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
          style: TextStyle(fontSize: 2.4.w),
        ),
      );

  Widget buildList(BuildContext context, User member, int index) => Container(
        margin: EdgeInsets.only(
          left: 15.00.h,
        ),
        child: MemberCard(
          db: db,
          member: member,
          group: group,
          me: user,
          index: index,
        ),
      );
}

class MemberCard extends StatelessWidget {
  final Presenter db;
  final User member;
  final Groups group;
  final User me;
  final int index;
  MemberCard(
      {Key? key,
      required this.db,
      required this.member,
      required this.group,
      required this.me,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return me.userId == group.leaderId
        ? FocusedMenuHolder(
            menuWidth: 40.0.w,
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
                  onPressed: () {
                    showDialog(
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("هل انت متاكد؟"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  db.removeUserFromGroup(
                                      group.groupId, member.userId);
                                  showDialog(
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text("تم حذف العضو بنجاح"),
                                      );
                                    },
                                    context: context,
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
                  }),
            ],
            openWithTap: member.userId == group.leaderId ? false : true,
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Image of rank
                Container(
                  padding: EdgeInsets.all(0).copyWith(left: 0),
                  child: Stack(
                    children: [
                      Container(
                          margin: EdgeInsets.all(1.0.w),
                          padding: EdgeInsets.all(.3.w),
                          child: index == 0 //rank 1
                              ? Image.asset(
                                  ("assets/Ranking.png"),
                                  fit: BoxFit.cover,
                                )
                              : (index == 1 //rank 2
                                  ? Image.asset("assets/Ranking2.png")
                                  : (index == 2 //rank3
                                      ? Image.asset("assets/Ranking3.png")
                                      : SizedBox(
                                          width: 5.h,
                                        ) //other
                                  ))),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.05,
                ),
                //member name
                Container(
                  child: Text(
                    member.username,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 3.w,
                        color: Color.fromARGB(170, 0, 0, 0)),
                  ),
                ),
                //leader name
                Container(
                  child: Text(
                    member.userId == group.leaderId
                        ? "\t\t\t\t(رئيس المجوعة)"
                        : "",
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 2.w,
                        color: Color.fromARGB(170, 0, 0, 0)),
                  ),
                ),
              ],
            ),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Image of rank
              Container(
                padding: EdgeInsets.all(0).copyWith(left: 0),
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.all(1.0.h),
                        padding: EdgeInsets.all(.3.h),
                        child: index == 0 //rank 1
                            ? Image.asset(
                                ("assets/Ranking.png"),
                                fit: BoxFit.cover,
                              )
                            : (index == 1 //rank 2
                                ? Image.asset("assets/Ranking2.png")
                                : (index == 2 //rank3
                                    ? Image.asset("assets/Ranking3.png")
                                    : SizedBox(
                                        width: 5.h,
                                      ) //other
                                ))),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.05,
              ),

              //member name
              Container(
                child: Text(
                  member.username,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 3.w,
                      color: Color.fromARGB(170, 0, 0, 0)),
                ),
              ),
              //leader
              Container(
                child: Text(
                  member.userId == group.leaderId
                      ? "\t\t\t\t(رئيس المجوعة)"
                      : "",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontSize: 2.w,
                      color: Color.fromARGB(170, 0, 0, 0)),
                ),
              ),
            ],
          );
  }
}
