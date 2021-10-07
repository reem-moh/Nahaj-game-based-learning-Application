import 'package:flutter/material.dart';
import 'package:nahaj/homePage.dart';
import 'database.dart';

class AddGroup2 extends StatefulWidget {
final DataBase db;
  AddGroup2({Key? key, required this.db}) : super(key: key);

  @override
  _AddGroup2 createState() => _AddGroup2();
}

class _AddGroup2 extends State<AddGroup2> {
  final _key = GlobalKey<FormState>();
  
    String name = "";
    bool validName = false;
    String nameoftheGroup= "0000000" ;


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
                
                    //Name
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Padding(
                        padding:EdgeInsets.only(top: 0, left:  0),
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
                 

                        //Name
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Padding(
                        padding:EdgeInsets.only(top: 0, left: 0),
                        child: Text(
                          nameoftheGroup+"",
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
