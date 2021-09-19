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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
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
          //padding: EdgeInsets.zero,
          padding: EdgeInsets.fromLTRB(screenWidth * 0.7, 0, 0, 0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("reem",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  )),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/nahajLogo.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: backgroundColorOfSideBar,
              ),
            ),
            ListTile(
              trailing: Icon(Icons.home_rounded),
              title: Text("الرئيسية",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              onTap: () => null,
            ),
            ListTile(
              title: Text("ملف شخصي",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              //  style: TextStyle(color: Colors.black, fontSize: 22)),
              trailing: Icon(Icons.person_outline_rounded),
              onTap: () => null,
            ),
            ListTile(
              trailing: Icon(Icons.help),
              title: Text("مساعدة",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              onTap: () => null,
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
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.grey[800],
                                  size: MediaQuery.of(context).size.width / 20,
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
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Positioned(
                                  child: Text(
                                    ':الأقسام',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30),
                                  ),
                                ),
                                Image.asset('assets/TabsIndicator.png'),
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
                ],
              ),
            ),
          )),
    );
  }
}
