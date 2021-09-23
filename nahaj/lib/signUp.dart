import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/SignUpSignInbackground.png"),
                      fit: BoxFit.cover)),
            ),
            
              //mainAxisAlignment: MainAxisAlignment.end,
              
                Column(
                  children: [

                    /*
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.33,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/nahajLogo.png"),
                                fit: BoxFit.none)),
                      ),
                    ),
*/
 SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                        child:
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
                                            "assets/nahajLogo.png")),
                                            

                                  ],
                                )),

 ),

                    Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  
                 child:
                   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                  child:
                Text(
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
                      ],
                    ),



 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                 child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  child: const TextField(
  obscureText: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    
  ),
)
                ),
                   ),


                      Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  
                 child:
                   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                  child:
                Text(
                  ":البريد الإلكتروني ",
                  style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                  ),
                ),
                   ),
                        ),
                      ],
                    ),

 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                 child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  child: const TextField(
  obscureText: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    
  ),
)
                ),
                   ),


                      Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  
                 child:
                   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
                  child:
                Text(
                   ":كلمة السر",
                  style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                  ),
                ),
                   ),
                        ),
                      ],
                    ),

                   SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                 child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                   ),







                    Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  
                 child:
                   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 0),
                  child:
                Text(
                  ":إعادة كلمة السر ",
                  style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                  ),
                ),
                   ),
                        ),
                      ],
                    ),

                      SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                 child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
                  child: const TextField(
  obscureText: true,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    
  ),
)
                ),
                   ),

 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                 child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: 
Container(  
              margin: EdgeInsets.all(25),  
              child: FlatButton(  
                child:  Text(
                  "تسجيل ",
                  style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                  ),
                ), 
                color: Color.fromARGB(255, 129, 190, 255),  
                textColor: Colors.white,  
                onPressed: () {},  
              ),  
            ),
                ),
                ),










                  ],

                  
                ),
                  
            
            
          ],
        ),
      ),
    );
  }
}