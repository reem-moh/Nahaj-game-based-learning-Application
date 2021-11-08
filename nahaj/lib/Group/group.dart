import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/database.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nahaj/child.dart';

class Group extends StatefulWidget {
  final Groups group;
  final User user;
  final DataBase db;
  Group({Key? key, required this.db, required this.group, required this.user})
      : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  final _key = GlobalKey<FormState>();
  int numOfchate = 3;
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello", messageType: "receiver"),
    ChatMessage(messageContent: "HelloHelloHello", messageType: "receiver"),
    ChatMessage(messageContent: "Hello", messageType: "sender"),
    ChatMessage(
        messageContent:
            "HelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello",
        messageType: "receiver"),
    ChatMessage(messageContent: "IHelloHelloHelloHello", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 224, 224, 224),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    //back button
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(right: 850),
                      child: TextButton(
                        child: Icon(Icons.arrow_back, size: size.height * 0.05),
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
                    ),
                    
                    //Name of Group
                    Container(
                      //margin: EdgeInsets.only(left: 30.0),
                      child: Text(
                        widget.group.groupName,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w600,
                          fontSize: 27,
                        ),
                      ),
                    ),

                    //Group Image
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 110.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[350],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.group.pathOfImage),
                      ),
                    ),

                    //three dots
                    TextButton(
                      child: Image(
                        image: AssetImage("assets/Group13.png"),
                        alignment: Alignment.topLeft,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              //items inside the header
            ],
          ),

          //body
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                height: 550,
                child: ListView.separated(
                  itemCount: numOfchate,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 25,
                    );
                  },
                  itemBuilder: (_, i) {
                    return Container(
                      child: ListView.builder(
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Stack(
                              children: [
                                Align(
                                  alignment:
                                      (messages[index].messageType == "receiver"
                                          ? Alignment.topLeft
                                          : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (messages[index].messageType ==
                                              "receiver"
                                          ? Colors.grey.shade200
                                          : Colors.blue[200]),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Stack(
                                      children: [
                                        if (messages[index].messageType ==
                                            "receiver")
                                          (Padding(
                                            padding:
                                                (EdgeInsets.only(bottom: 0)),
                                            child: Text(
                                              "Reem",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )),
                                        Text(
                                          messages[index].messageContent,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Padding(
                                          padding:
                                              (messages[index].messageType ==
                                                      "receiver"
                                                  ? EdgeInsets.only(
                                                      top: 35, left: 0)
                                                  : EdgeInsets.only(
                                                      top: 35, right: 0)),
                                          child: Text(
                                            "5:10 PM",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),

          //text field of send message
          Row(
            children: [
              //text inside field
              Flexible(
                  child: Column(
                children: [
                  //text inside field
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 224, 224, 224),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 30.0, height: 2.0, color: Colors.black),
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              hintTextDirection: TextDirection.rtl,
                              hintText: " اكتب هنا... ",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 30),
                              border: InputBorder.none),
                        ),
                      ),
                      TextButton(
                        child: Icon(Icons.send, size: size.height * 0.065),
                        onPressed: () {},
                      ),
                    ]),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  /*Future<void> getGroupName(String uid) async {
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
  }*/

}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
