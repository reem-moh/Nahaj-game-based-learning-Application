import 'package:flutter/material.dart';

//#FDE9A9
final Color backgroundColorOfSideBar = Color(0xffFDE9A9);

class HomePage extends StatefulWidget {
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
  late List<int> index;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          padding: EdgeInsets.fromLTRB(screenWidth * 0.7, 0, 0, 0),
          children: [
            SizedBox(height: 35),
            //profile image and name

            SizedBox(
              height: 220,
              child: UserAccountsDrawerHeader(
                accountName: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "ريم",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ],
                ),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    'assets/owl_defaultProfile.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  backgroundColor: Colors.grey[400],
                ),
                currentAccountPictureSize: Size(290, 80),
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
                trailing: Icon(Icons.home_rounded, size: 40),
                title: Text(
                  "الرئيسية",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
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

            SizedBox(height: 10),

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
                    fontSize: 24,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                trailing: Icon(Icons.person, size: 40),
                onTap: () {
                  setState(() {
                    tappedIndex = 1;
                  });
                },
              ),
            ),

            SizedBox(height: 10),

            //help مساعدة
            Theme(
              data: ThemeData(
                highlightColor: Colors.white,
                splashColor: Colors.white,
                selectedRowColor: Colors.white,
              ),
              child: ListTile(
                tileColor: tappedIndex == 2 ? Colors.white : null,
                trailing: Icon(Icons.help, size: 40),
                title: Text(
                  "مساعدة",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  setState(() {
                    tappedIndex = 2;
                  });
                },
              ),
            ),

            SizedBox(height: 850),

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
                    fontSize: 24,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () {
                  setState(() {
                    tappedIndex = 3;
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
      top: isCollapsed ? 0 : -0.1 * screenWidth,
      bottom: isCollapsed ? 0 : 0.01 * screenWidth,
      left: isCollapsed ? 0 : -0.2 * screenWidth,
      right: isCollapsed ? 0 : 0.2 * screenWidth,
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

                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(children: <Widget>[
                      //sidebar
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            //sidebar
                            Container(
                              child: InkWell(
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.menu_close,
                                  size: MediaQuery.of(context).size.width / 20,
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
                              padding: const EdgeInsets.only(right: 20),
                            ),
                          ]),
                      SizedBox(height: 10),

                      //profile column
                      Container(
                        height: MediaQuery.of(context).size.height / 3.18,
                        child: Stack(
                          children: [
                            //welcome message background
                            Positioned(
                                width: MediaQuery.of(context).size.width,
                                //top: MediaQuery.of(context).size.height / 11,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.09,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4.18,
                                        image: AssetImage(
                                            "assets/helloMessageBackground.png"))
                                  ],
                                )),

                            //welcome message text
                            Positioned(
                                width: MediaQuery.of(context).size.width / 1.09,
                                top: MediaQuery.of(context).size.height * 0.04,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/owl.png',
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.10),
                                    Text(
                                      'أهلاً، سلطان',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      //SizedBox(height: 350),
                      //categories
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ':الأقسام',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 800,
                                ),
                                Image.asset('assets/TabsIndicator.png'),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 40,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CategoryCard(
                                    cardColor:
                                        Color.fromARGB(255, 223, 221, 223),
                                    title: 'الكيمياء',
                                    image: 'assets/chemistry.gif'),
                                CategoryCard(
                                  cardColor: Color.fromARGB(255, 202, 203, 203),
                                  title: 'النباتات',
                                  image: 'assets/plants.gif',
                                ),
                                CategoryCard(
                                  cardColor: Color.fromARGB(255, 230, 230, 230),
                                  title: 'الحيوانات',
                                  image: 'assets/animals.png',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //background bottom
                      Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.zero,
                          child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/homeBottomBackground.jpg"))),
                    ]),
                  ),

                  //groups
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 350,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ':المجموعات',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                            Image.asset('assets/TabsIndicator.png'),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 40,
                            ),
                          ],
                        ),
                        //list view
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 140.0,
                          child: ListView.separated(
                            itemCount: 3,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 10,
                              );
                            },
                            itemBuilder: (_, i) => groupsCard(),
                            scrollDirection: Axis.horizontal,
                          ),
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    this.cardColor = Colors.grey,
    this.title = 'Title',
    this.image = 'assets/plants.gif',
  });

  final Color cardColor;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cardColor, width: 2.0),
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
      margin: EdgeInsets.all(8),
      height: 250,
      width: 210,
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
                    fontSize: 24.0,
                    color: Color.fromARGB(255, 114, 78, 140)),
              ),
            ],
          ),
          /*SizedBox(
            height: 0.0,
          ),*/
          Image.asset(
            image,
            height: 201,
            width: 210,
            //fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class groupsCard extends StatelessWidget {
  const groupsCard({
    this.groupImage = 'assets/animals.png',
    this.groupName = 'group name',
  });

  final String groupImage;
  final String groupName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C4D03AQFgZBilNtPUMA/profile-displayphoto-shrink_800_800/0/1604728137407?e=1632960000&v=beta&t=QKa1Nq3WKWQGEGaiKdZ1ovp1h6uAbwPZfihdqY2_pNU'),
          ),
        ),
        /*Container(
          child: Text(
            groupName,
            style: TextStyle(
                fontFamily: 'Cairo',
                //fontWeight: FontWeight.w700,
                fontSize: 30),
          ),
        ),*/
      ],
    );
  }
}
