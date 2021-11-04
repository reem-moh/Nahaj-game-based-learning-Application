import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';

class Group extends StatefulWidget {
  //final DataBase db;
  //const Group({Key? key, /*required this.db*/}) : super(key: key);
 final DataBase db;
  Group({Key? key, required this.db, required String groupName}) : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  final _key = GlobalKey<FormState>();

  String nameOfTheGroup = "مجموعة 1";

  String name = "";
  bool validName = false;
  String username = "1";
  String uid = "0";
  bool entere = true;

  Future<void> _getInfoFromSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? "1");
      print('username inside getinfo from Group:' + username);
      uid = (prefs.getString('id') ?? "1");
      print('id inside getinfo from Group:' + uid);
    });
  }

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
if(entere){
      _getInfoFromSession();
      entere=false;
    }    getGroupName(uid);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 224, 224, 224),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  // ignore: deprecated_member_use

                  TextButton(
                    child: Padding(
                  padding: EdgeInsets.only(top: 0, right: 830),
                  child: Image(
                      image: AssetImage("assets/Group13.png"),
                      alignment: Alignment.topLeft,
                    ),
                      ),
                    onPressed: () {
// description of the group
                    },
                
              ),

                  Container(
                    margin: EdgeInsets.only(right: 30.0),
                    child: Text(
                      nameOfTheGroup,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                      ),
                    ),
                  ),

  Padding(
                  padding: EdgeInsets.only(top: 0, right: 50),
                  child:
                  Container(
                    width: 120.0,
                    height: 120.0,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[350],
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com:443/v0/b/nahaj-6104c.appspot.com/o/Avatar%2Fanimals.png?alt=media&token=734cf7d9-83e0-41d8-9249-c3b5b8144dc3'),
                    ),
                  ),
  ),
                ],
              )
            ],
          ),



          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 540,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
              ),
              //list view
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                height: 280,
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 25,
                    );
                  },
                  itemBuilder: (_, i) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 8, 128, 174),
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),





          Stack(
            children: [
              
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 224, 224, 224),
                ),
              ),
             Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child:
              Row(
                children: [

 Flexible(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
  decoration: InputDecoration(
   hintTextDirection: TextDirection.rtl,
               hintText: " اكتب ... ",
               
               hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black , fontSize: 30 )
              ),  
                      
                    ),
                  )
                  //container
                ],
              )),

     TextButton(
                    child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 0),
                  child: Icon(Icons.send, size: size.height * 0.1),
                      ),
                    onPressed: () {
// description of the group
                    },
                
              ),


                ],
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  Future<void> getGroupName(String uid) async {
    nameOfTheGroup = "مجموعه١";
    /*await firestore
        .collection('Groups')
        .where("CraetorId", isEqualTo: uid)
        .get()
    .then((value){
            nameOfTheGroup = value.docs;
          }).catchError((error) => print("Failed to get code: $error"));*/
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('Groups')
        .where("CraetorId", isEqualTo: uid)
        .get();
    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        nameOfTheGroup = await data['name'].toString();
      }
    }
  }
}

/*
          Column(
             children:[

// description of the group
Stack(
 children: [
              //Background
              Container(
                width: MediaQuery.of(context).size.height,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    color: Colors.red,),
              ),

              //Row(),

 ],
 
),



//shat
Stack(
 children: [
 Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/unnamed.jpg"),
                        fit: BoxFit.cover)),
              ),

          Row(
            children: [
              ListView(
                  
                    
              ),
            ],
          ),    

 ]
),


//send shat
Stack(
  children: [
              //Background
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Rectangle.png"),
                        fit: BoxFit.fitWidth)),
              ),

Row(
            children: [
              ListView(
                    
              ),
            ],
          ),   

 ],
),


             ]




          ),
        
*/
