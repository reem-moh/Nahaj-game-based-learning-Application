import 'package:flutter/material.dart';
import 'package:nahaj/homePage.dart';
import 'database.dart';

class AddGroup extends StatefulWidget {
final DataBase db;
  AddGroup({Key? key, required this.db}) : super(key: key);

  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup> {
  final _key = GlobalKey<FormState>();
  
    String name = "";
    bool validName = false;


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
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Back button
                      // ignore: deprecated_member_use
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(top: 0, left: 0),
                          child:Image(
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
                      //Nahaj logo
                       FlatButton(
                        child: Image(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1,
                          image: AssetImage("assets/Groupimage.png"),alignment: Alignment.topCenter,),
                          
                          onPressed: () {
                        changeImage();
                        },
                      ),
                    ],
                  ),
                ),
                    //Name
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Padding(
                        padding:EdgeInsets.only(top: 0, left: 950),
                        child: Text(
                          ": الاسم ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            fontSize: 27,
                          ),
                        ),
                      ),
                    ),
                 
                //Name text field
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorRadius: Radius.circular(50),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        /*onChanged: (val) {
                          name = val;
                        },*/
                        validator: (val) {
                          if (val!.length <= 0) {
                            validName = false;
                            return 'هذا الحقل مطلوب';
                          } else if (val.length <= 2) {
                            validName = false;
                            print("name is not valid");
                            return 'الإسم يجب أن يكون من ثلاثة أحرف أو أكثر';
                          } else {
                            validName = true;
                            name = val;
                          }
                          /*if (loginErr) {
                            return 'البريد الإلكتروني أو كلمة المرور خاطئة';
                          }*/
                          return null;
                        },
                      )),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        db: widget.db,
                                      )),
                            );
                          });
                          //createGroup(name);
                        },
                      padding: EdgeInsets.all(0.0),
                      color: Color.fromARGB(255, 129, 190, 255),
                      textColor: Colors.white,
                      child: Text(
                    "إنشاء ",
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
  
void createGroup(String name) async {
    if (validName ) {
     
    }
  }



void changeImage() async {
   
  }



}
