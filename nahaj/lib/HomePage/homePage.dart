import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:nahaj/SignPages/Signin.dart';
import 'package:nahaj/Group/addGroup.dart';
import 'package:nahaj/Group/groupChat.dart';
import 'package:nahaj/Group/joinGroup.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'category.dart';
import 'package:nahaj/HomePage/category.dart';
import 'package:nahaj/database.dart';

//#FDE9A9
final Color backgroundColorOfSideBar = Color(0xffFDE9A9);

class HomePage extends StatefulWidget {
  final DataBase db;
  HomePage({Key? key, required this.db}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  late int tappedIndex;

  User user =
      User(userId: '1', username: '1', email: '1', avatar: '1', level: -1);

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

    _getInfoFromSession();

    widget.db.getExperiments().then((value) => experiments = value);
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
        String avatar = (prefs.getString('avatar') ?? "1");
        String username = (prefs.getString('username') ?? "1");
        String userId = (prefs.getString('userId') ?? "1");
        String email = (prefs.getString('email') ?? "1");
        double level = (prefs.getDouble('level') ?? -1);
        user = User(
            userId: userId,
            username: username,
            email: email,
            avatar: avatar,
            level: level);
      });
    }
  }

  _logout() {
    //Navigator.pushNamedAndRemoveUntil(context, "/SigninPage", (r) => false);

    widget.db.signOut().then((s) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Signin(
                  db: widget.db,
                )),
      );
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
          padding: EdgeInsets.fromLTRB(screenWidth * 0.07.h, 0, 0, 0),
          children: [
            //profile image and name
            SizedBox(
              height: screenHeight * 0.3,
              child: UserAccountsDrawerHeader(
                accountName: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.08,
                      child: user.username == "1"
                          ? Text(
                              "...",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                fontSize: 2.7.w,
                              ),
                            )
                          : Text(
                              user.username,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                fontSize: 2.7.w,
                              ),
                            ),
                    ),
                  ],
                ),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: user.avatar == "1"
                        ? CircularProgressIndicator()
                        : Image.network(
                            user.avatar,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                currentAccountPictureSize:
                    Size(screenHeight * 0.38, screenWidth * 0.1),
                decoration: BoxDecoration(
                  color: backgroundColorOfSideBar,
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

            SizedBox(height: 0.012.w),

            //profile ملف شخصي
            Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                selectedRowColor: Colors.white,
              ),
              child: ListTile(
                tileColor: tappedIndex == 1 ? Colors.white : null,
                title: Text(
                  "ملف شخصي",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 2.4.w,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                trailing: Icon(Icons.person, size: screenHeight * 0.032),
                onTap: () {
                  setState(() {
                    //Profile
                    //widget.db.addUser("reem", "reem", 90);
                    tappedIndex = 1;
                  });
                },
              ),
            ),

            SizedBox(height: 0.012.w),

            //help مساعدة
            Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                selectedRowColor: Colors.white,
              ),
              child: ListTile(
                tileColor: tappedIndex == 2 ? Colors.white : null,
                trailing: Icon(Icons.help, size: screenHeight * 0.032),
                title: Text(
                  "مساعدة",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 2.4.w,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  /*setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AR()),
                    );
                    
                  });*/
                  setState(() {
                    tappedIndex = 2;
                  });
                },
              ),
            ),

            SizedBox(height: 36.w),

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
                    tappedIndex = 3;
                    _logout();
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
                                user.avatar == "1"
                                    ? CircularProgressIndicator()
                                    : Image.network(
                                        user.avatar,
                                        fit: BoxFit.cover,
                                      ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.10),
                                user.username == "1"
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
                                        'أهلاً، ${user.username}',
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
                                //name of categories
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      ':الأقسام',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 3.0.w),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              800.h,
                                    ),
                                    Image.asset('assets/TabsIndicator.png'),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width.h /
                                              40.h,
                                    ),
                                  ],
                                ),
                                //cards
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CategoryCard(
                                      cardColor:
                                          Color.fromARGB(255, 223, 221, 223),
                                      title: 'الكيمياء',
                                      image: 'assets/chemistry.gif',
                                      db: widget.db,
                                    ),
                                    CategoryCard(
                                      cardColor:
                                          Color.fromARGB(255, 202, 203, 203),
                                      title: 'النباتات',
                                      image: 'assets/plants.gif',
                                      db: widget.db,
                                    ),
                                    CategoryCard(
                                      cardColor:
                                          Color.fromARGB(255, 230, 230, 230),
                                      title: 'الحيوانات',
                                      image: 'assets/animals.png',
                                      db: widget.db,
                                    ),
                                  ],
                                ),
                                //groups
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FocusedMenuHolder(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 9.00.h,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 40,
                                              ),
                                            ),
                                            onPressed: () {},
                                            openWithTap: true,
                                            menuWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            menuItems: [
                                              FocusedMenuItem(
                                                  title: Text(
                                                    "إنشاء مجموعة",
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 1.5.w,
                                                    ),
                                                  ),
                                                  trailingIcon:
                                                      Icon(Icons.group_add),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddGroup(
                                                                db: widget.db,
                                                                user: user,
                                                              )),
                                                    );
                                                  }),
                                              FocusedMenuItem(
                                                  title: Text(
                                                    "انضمام إلى مجموعة",
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 1.5.w,
                                                    ),
                                                  ),
                                                  trailingIcon:
                                                      Icon(Icons.group),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              JoinGroup(
                                                                db: widget.db,
                                                                user: user,
                                                              )),
                                                    );
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 65.h,
                                          ),
                                          Text(
                                            ':المجموعات',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 3.0.w),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.h,
                                          ),
                                          Image.asset(
                                              'assets/TabsIndicator.png'),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.h,
                                          ),
                                        ],
                                      ),
                                      //list view
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 30.0, right: 30.0),
                                        height: 18.00.h,
                                        child: CardsOfGroup(db: widget.db,
                                              user: user,)
                                      ),
                                    ],
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

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  CategoryCard({
    this.cardColor = Colors.grey,
    this.title = 'Title',
    this.image = 'assets/plants.gif',
    this.size1 = 30.0,
    this.size2 = 20.0,
    this.size3 = 30.0,
    this.fontSize = 2.4,
    required this.db,
  });

  Color cardColor;
  String title;
  String image;
  double size1, size2, size3, fontSize;
  DataBase db;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(title);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Category(
                    categoryTitle: title,
                    db: db,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cardColor, width: .20.h),
          color: cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 7,
              spreadRadius: 0,
              offset: Offset(4, 4),
            ),
          ],
        ),
        margin: EdgeInsets.all(0.08.w),
        height: size1.w,
        width: size3.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize.w,
                      color: Color.fromARGB(255, 114, 78, 140)),
                ),
              ],
            ),
            Image.asset(
              image,
              height: size2.w,
              width: size2.h,
            ),
          ],
        ),
      ),
    );
  }
}

class GroupsCard extends StatelessWidget {
  final DataBase db;
  final Groups group;
  final User user;
  GroupsCard(
      {Key? key, required this.db, required this.group, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
          print('مجموعة');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Group(
                    db: db, group: group, user: user)),
          );
   
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 13.00.h,
            height: 13.00.w,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[350],
            ),
            child: 
            CircleAvatar(radius: 45,
        child: ClipOval(
                    child: Image.network(
                            group.pathOfImage,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
             )),
          ),
          Container(
            child: Text(
              group.groupName,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 2.2.w,
                  color: Color.fromARGB(170, 0, 0, 0)),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsOfGroup extends StatelessWidget {
  final User user;
  final DataBase db;
  //final Groups group;

  const CardsOfGroup({
    required this.user,
    required this.db,
    Key? key,
  }) : super(key: key);



  @override
 Widget build(BuildContext context) => StreamBuilder<List<Groups>>(
        stream: db.getGroupsList(user.userId,user.username),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allGroups = snapshot.data;
                return allGroups == null
                    ? buildText('لا يوجد لديك مجموعات!')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allGroups.length,
                        itemBuilder: (context, index) {
                          final group = allGroups[index];//[index];

                          return GroupsCard(
                                        db: db,
                                              group: group,
                                              user: user,
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
