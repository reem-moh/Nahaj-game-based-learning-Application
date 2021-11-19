import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nahaj/Group/GroupInfo.dart';
import 'package:nahaj/NahajClasses/Chats.dart';
import 'package:nahaj/database.dart';
import 'package:nahaj/HomePage/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nahaj/NahajClasses/child.dart';
import 'package:sizer/sizer.dart';

class Group extends StatefulWidget {
  final Groups group;
  final User user;
  final DataBase db;
  Group({
    Key? key,
    required this.db,
    required this.group,
    required this.user,
  }) : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromARGB(255, 224, 224, 224),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(group: widget.group,db: widget.db, user: widget.user),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(
                      group: widget.group, user: widget.user, db: widget.db),
                ),
              ),
              NewMessageWidget(
                  user: widget.user,
                  db: widget.db,
                  groupId: widget.group.groupId)
            ],
          ),
        ),
      );
}

//header
class ProfileHeaderWidget extends StatelessWidget {
  final Groups group;
  final DataBase db;
  final User user;

  const ProfileHeaderWidget({
    required this.group,
    required this.db,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 14.w,
        padding: EdgeInsets.all(16).copyWith(left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    TextButton(
                            child: Image(
                              image: AssetImage("assets/PreviosButton.png"),
                              alignment: Alignment.topCenter,
                            ),
                            onPressed: () {
                             
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                        db: db,
                                      )),
                                );
                              
                            },
                          ),
                  ],
                ),
                //BackButton(color: Colors.blue[600]),
                Expanded(
                  child: Text(
                    group.groupName,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 2.4.w,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Wrap(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 6.2.w,
                      width: 8.0.h,
                      child: buildIcon(1, AssetImage(''), group.pathOfImage),
                    ),
                    //group image

                    SizedBox(
                      width: 4.0.h,
                      child: GestureDetector(
                        onTap: () {
                          print("pressed group info");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupInfo(db: db,group: group, user: user)),
                          );
                        },
                        child:
                            buildIcon(0, AssetImage("assets/Group13.png"), ''),
                      ),
                    ),
                    //three dots
                  ],
                ),
                SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(int type, AssetImage assetImage, String image) => Container(
        padding: EdgeInsets.all(3),
        height: 40,
        decoration: type == 1
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              )
            : BoxDecoration(),
        child: type == 1
            ? CircleAvatar(
                radius: 45,
                child: ClipOval(
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                ),
              )
            : Image(
                image: AssetImage("assets/Group13.png"),
              ),
      );
}

//read messages form db
class MessagesWidget extends StatelessWidget {
  final Groups group;
  final User user;
  final DataBase db;
  //final Groups group;

  const MessagesWidget({
    required this.group,
    required this.user,
    required this.db,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Chat>>(
        stream: db.getMessagesList(group.groupId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText(
                    'Something Went Wrong Try later ${snapshot.hasError}');
              } else {
                final allMessages = snapshot.data;
                return allMessages == null
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: allMessages.length,
                        itemBuilder: (context, index) {
                          final message = allMessages[index]; //[index];

                          return MessageWidget(
                            message: message,
                            userName: message.username,
                            isMe: message.userId == user.userId,
                          );
                        },
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

//send message tstyle
class NewMessageWidget extends StatefulWidget {
  final User user;
  final DataBase db;
  final String groupId;

  const NewMessageWidget({
    required this.user,
    required this.db,
    required this.groupId,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    // down the keyboard
    FocusScope.of(context).unfocus();

    await widget.db
        .uploadMessage(
            widget.groupId, widget.user.userId, widget.user.username, message)
        .then((value) => print("added success"));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            //text field
            Expanded(
              child: TextField(
                controller: _controller,
                textDirection: TextDirection.rtl,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintTextDirection: TextDirection.rtl,
                  hintText: 'اكتب رسالتك..',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            //space
            SizedBox(width: 20),
            //send icon
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}

//Styling of chat body
class MessageWidget extends StatelessWidget {
  final String userName;
  final Chat message;
  final bool isMe;

  const MessageWidget({
    required this.message,
    required this.userName,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Container(
                padding: EdgeInsets.only(top: 16),
                margin: EdgeInsets.only(top: 16, left: 16),
                child: Text(userName,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 2.w,
                    ),
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl),
              ),
            Container(
              padding: isMe
                  ? EdgeInsets.all(16)
                  : EdgeInsets.only(bottom: 16, left: 16, right: 16),
              margin: isMe
                  ? EdgeInsets.all(16)
                  : EdgeInsets.only(bottom: 16, left: 16, right: 16),
              constraints: BoxConstraints(maxWidth: 140),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
                borderRadius: isMe
                    ? borderRadius
                        .subtract(BorderRadius.only(bottomRight: radius))
                    : borderRadius
                        .subtract(BorderRadius.only(bottomLeft: radius)),
              ),
              child: buildMessage(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                color: isMe ? Colors.black : Colors.white),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
