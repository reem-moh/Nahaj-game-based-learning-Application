import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nahaj/NahajClasses/classes.dart';
import 'package:nahaj/AdminPages/experimentAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:nahaj/presenter.dart';

//#FDE9A9
final Color backgroundColorOfSideBar = Color(0xffFDE9A9);

class AdminHomePage extends StatefulWidget {
  final Presenter db;
  AdminHomePage({Key? key, required this.db}) : super(key: key);

  @override
  _AdminHomePage createState() => _AdminHomePage();
}

class _AdminHomePage extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late int tappedIndex;

  Admin admin = Admin(
    adminId: '1',
    adminName: '1',
    email: '1',
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    tappedIndex = 0;
    print("inside initState admin home pAGE");
    _getInfoFromSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getInfoFromSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        String username = (prefs.getString('username') ?? "1");
        String userId = (prefs.getString('userId') ?? "1");
        String email = (prefs.getString('email') ?? "1");
        admin = Admin(
          adminId: userId,
          adminName: username,
          email: email,
        );
        print(
            "inside admin home paage username:$username userId:$userId email:$email");
      });
    }
  }

  _logout() {
    widget.db.signOut().then((s) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Signin', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColorOfSideBar,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.064.h, 0, 0, 0),
          children: [
            //profile image and name
            Container(
              alignment: Alignment.centerRight,
              height: 23.h,
              child: SizedBox(
                height: screenHeight * 0.9,
                child: UserAccountsDrawerHeader(
                  accountName: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight * 0.08,
                        child: admin.adminName == "1"
                            ? Text(
                                "...",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 2.7.w,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.fromLTRB(4.19.h, 0, 0, 0),
                                child: Text(
                                  admin.adminName,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 2.7.w,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  accountEmail: Text(""),
                  currentAccountPicture: CircleAvatar(
                    child: Image.asset(
                      'assets/user 2.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                    backgroundColor: Colors.white54,
                  ),
                  currentAccountPictureSize:
                      Size(screenHeight * 0.41, screenWidth * 0.1),
                  decoration: BoxDecoration(
                    color: backgroundColorOfSideBar,
                  ),
                ),
              ),
            ),
            //home page الرئيسية
            Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                selectedRowColor: Colors.white,
              ),
              child: ListTile(
                tileColor: tappedIndex == 0 ? Colors.white : null,
                trailing: Icon(Icons.home_rounded, size: screenHeight * 0.032),
                title: Text(
                  "الرئيسية",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 2.4.w,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  setState(() {
                    if (isCollapsed)
                      _controller.forward();
                    else
                      _controller.reverse();

                    isCollapsed = !isCollapsed;
                    tappedIndex = 0;
                  });
                },
              ),
            ),

            SizedBox(height: 45.w),

            //logout
            Theme(
              data: ThemeData(
                highlightColor: Colors.white,
              ),
              child: ListTile(
                tileColor: tappedIndex == 3 ? Colors.white : null,
                trailing: Icon(Icons.exit_to_app_rounded, size: 40),
                title: Text(
                  "خروج",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 2.4.w,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  setState(() {
                    showDialog(
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("هل تريد تسجيل الخروج ؟"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  tappedIndex = 3;
                                  _logout();
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
                                child: Text("لا",
                                    style: TextStyle(color: Colors.black)),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : -9.h,
      bottom: isCollapsed ? 0 : 0.9.h,
      left: isCollapsed ? 0 : -9.9.h,
      right: isCollapsed ? 0 : 10.h,
      child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            elevation: 8,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: [
                  //top image
                  Container(
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/homeTopBackground.jpg"),
                      alignment: Alignment.topRight,
                    ),
                    alignment: Alignment.topRight,
                  ),
                  //sidebar
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //sidebar
                        Container(
                          padding: const EdgeInsets.only(top: 23, right: 20),
                          child: InkWell(
                            child: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              size: MediaQuery.of(context).size.width.h / 20.h,
                              progress: _controller,
                              color: Colors.grey[800],
                            ),
                            onTap: () {
                              setState(() {
                                if (isCollapsed)
                                  _controller.forward();
                                else
                                  _controller.reverse();
                                isCollapsed = !isCollapsed;
                              });
                            },
                          ),
                          alignment: Alignment.topRight,
                        ),
                      ]),

                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 4.5.w),

                        //profile column
                        Container(
                            height:
                                MediaQuery.of(context).size.height.w / 4.18.w,
                            width: MediaQuery.of(context).size.height.w / 1.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: Color.fromARGB(200, 145, 111, 170),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 7,
                                  spreadRadius: 0,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/user 2.png',
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.10),
                                admin.adminName == "1"
                                    ? Text(
                                        "...",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                          fontSize: 3.6.w,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    : Text(
                                        'أهلاً، ${admin.adminName}',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.white,
                                          fontSize: 3.6.w,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ],
                            )),
                        Container(
                          child: Stack(children: [
                            //background bottom
                            Container(
                                width: MediaQuery.of(context).size.width.h,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width *
                                        0.2),
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/homeBottomBackground.png"))),
                            Column(
                              children: [
                                SizedBox(
                                  height: 7.w,
                                ),
                                //experiments
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(
                                      ':التجارب',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 3.0.w),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              80.h,
                                    ),
                                    Image.asset('assets/TabsIndicator.png'),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              40.h,
                                    ),
                                  ],
                                ),
                                //list view
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 25),
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  child: AdminExperimentsWidget(
                                    db: widget.db,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

//Experiments stream builder
// ignore: must_be_immutable
class AdminExperimentsWidget extends StatelessWidget {
  final Presenter db;

  AdminExperimentsWidget({
    required this.db,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ExperimentInfo>>(
        stream: db.getExp(),
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
                          final exp = allExperiments[index];
                          return AdminExperimentCard(
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

class AdminExperimentCard extends StatefulWidget {
  final Presenter db;
  final ExperimentInfo exp;
  const AdminExperimentCard({
    required this.db,
    required this.exp,
  });
  @override
  State<AdminExperimentCard> createState() => _AdminExperimentCardState();
}

class _AdminExperimentCardState extends State<AdminExperimentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ExperimentAdmin(db: widget.db, exp: widget.exp)),
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
                    Text(
                      widget.exp.category,
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          fontSize: 2.2.w,
                          color: Color.fromARGB(255, 114, 78, 140)),
                    ),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
