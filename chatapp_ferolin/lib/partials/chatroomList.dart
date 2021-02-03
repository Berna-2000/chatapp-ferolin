import 'package:chatapp_ferolin/common/packages.dart';
import 'package:chatapp_ferolin/controller/userController.dart';
import 'package:flutter/material.dart';
import '../partials/sizeconfig.dart';
import '../controller/chatroomController.dart';
import '../views/chatroomPage.dart';
import '../partials/loadingPage.dart';

class ChatroomList extends StatefulWidget {
  final emailAddress, lastMessage, chattedUser, currentUser;
  ChatroomList({this.emailAddress, this.lastMessage, this.chattedUser, this.currentUser});
  @override
  _ChatroomListState createState() => _ChatroomListState();
}

class _ChatroomListState extends State<ChatroomList> {
  bool isLoading = true;
  QuerySnapshot userInfoSnapshot;
  String username = "Username", displayPhoto, chatroomId;

  @override
  void initState(){
    getUserInformation();
    super.initState();
  }

  getUserInformation() async {
    await UserController().retrieveUserofChatroom(widget.emailAddress)
      .then((result){
        displayPhoto = result.docs[0]['displayPhoto'];
        username = result.docs[0]['username'];
        isLoading = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : 
      GestureDetector(
      onTap: () async {
        chatroomId = ChatroomController()
          .generateChatroomId(widget.chattedUser, widget.currentUser.displayName);
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context)=>
            ChatRoomPage(
              chattedUser: widget.chattedUser, 
              currentUser: widget.currentUser, 
              chatroomId: chatroomId)));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(
                      displayPhoto,
                      height: 12 * SizeConfig.imageSizeMultiplier,
                    ),
                  )
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chattedUser,
                  style: TextStyle(
                    fontSize: 2.75 * SizeConfig.textMultiplier, 
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Container(
                  width: 0.65 * MediaQuery.of(context).size.width,
                  child: Text(
                    widget.lastMessage,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}