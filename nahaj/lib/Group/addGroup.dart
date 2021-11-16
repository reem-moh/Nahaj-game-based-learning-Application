import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nahaj/Group/addGroup2.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:nahaj/database.dart';
import 'dart:math';

import 'package:nahaj/NahajClasses/child.dart';

class AddGroup extends StatefulWidget {
  final DataBase db;
  final User user;
  AddGroup({Key? key, required this.db, required this.user}) : super(key: key);

  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup> {
  final _key = GlobalKey<FormState>();
  String groupName = "";
  bool validName = false;
  File? pathOfImage;
  String image = "";
  String defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/nahaj-6104c.appspot.com/o/Avatar%2Fowl.png?alt=media&token=1e5f590d-ce96-4f4a-82d0-5a455d197585";
  int code = 0;

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
              //back button
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 1050),
                  child: Image(
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
              //image of group
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //change the image of group
                    Expanded(
                      child: TextButton(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(13.0),
                              //Group Image
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                          120.0) //                 <--- border radius here
                                      ),
                                  border: Border.all(color: Colors.grey)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: pathOfImage != null
                                    ? ClipOval(
                                        child: Image.file(pathOfImage!,
                                            fit: BoxFit.cover),
                                      )
                                    : ClipOval(
                                        child: Image.asset("assets/owl1.png",
                                            fit: BoxFit.cover)),
                              ),
                            ),
                            //Camera Iamge
                            ClipRRect(
                              borderRadius: new BorderRadius.circular(40.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 160, right: 120),
                                child: Image.asset("assets/EditImage.png",
                                    height: 150, width: 1000),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          pickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //Name
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 950),
                  child: Text(
                    ": الاسم",
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
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 0),
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
                          groupName = val;
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
                    onPressed: () async {
                      bool check = await createGroup(groupName, widget.db);
                      if (check) {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddGroup2(
                                      db: widget.db,
                                      nameoftheGroup: "$code",
                                      user: widget.user,
                                    )),
                          );
                        });
                      }
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

  Future<bool> createGroup(String groupName, DataBase db) async {
    //check if the name of group greater than 3 character
    if (validName) {
      bool isFound = true;
      //check if code is not genetrated before
      while (isFound) {
        code = Random().nextInt(1000000);

        isFound = await widget.db.checkGroupCode(code);
      }
      if (pathOfImage != null) {
        print("pathOfImage: $pathOfImage");
        String imageURL =
            await widget.db.storeImage('/GroupsAvatars/$code', pathOfImage!);
        //thats mean there is no error
        if (imageURL != "-1") {
          widget.db.createGroup(code, groupName, widget.user.username,
              widget.user.userId, imageURL);
        }
      } else {
        //using default image
        String imageUrl = await widget.db.loadImage('/Avatar/owl.png');
        widget.db.createGroup(code, groupName, widget.user.username,
            widget.user.userId, imageUrl);
        print("default image inside method createGrou, in addGroup class ");
      }
      return true;
    }
    //it's not a valid name
    return false;
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      setState(() => this.pathOfImage = imageTemporary);
      print("pathOfImage inside pickImage");
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
