import 'package:flutter/material.dart';
import 'package:nahaj/presenter.dart';

import 'package:nahaj/NahajClasses/classes.dart';
import 'package:sizer/sizer.dart';

class AddGroup2 extends StatefulWidget {
  final Presenter db;
  final String groupCode;
  final User user;
  AddGroup2(
      {Key? key, required this.db, required this.groupCode, required this.user})
      : super(key: key);

  @override
  _AddGroup2 createState() => _AddGroup2();
}

class _AddGroup2 extends State<AddGroup2> {
  final _key = GlobalKey<FormState>();

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
          ListView(
            key: _key,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),

              Image(
                  width: MediaQuery.of(context).size.width / 1.09,
                  height: MediaQuery.of(context).size.height / 4.18,
                  image: AssetImage("assets/party.png")),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              //Name
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.only(top: 0, left: 280),
                  child: Text(
                    " تم إنشاء المجموعة بنجاح",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),

              //Code
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.groupCode + "  :رمز المجموعة",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 7.w,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "بإمكانك مشاركة هذا الرمز مع أصدقائك للانضمام للمجموعة*",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                height: 60.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: Color.fromARGB(255, 129, 190, 255))),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/HomePage', (Route<dynamic> route) => false);
                      });
                      //createGroup(name);
                    },
                    padding: EdgeInsets.all(0.0),
                    color: Color.fromARGB(255, 129, 190, 255),
                    textColor: Colors.white,
                    child: Text(
                      "عودة ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
