import 'package:chatapp_ferolin/controller/chatroomController.dart';
import 'package:chatapp_ferolin/models/chatroom.dart';
import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import 'package:flutter/material.dart';
import '../common/packages.dart';
import '../models/appUsers.dart';
import '../models/chatMessages.dart';

class ChatPage extends StatefulWidget {
  final AppUser chattedUser;
  final User currentUser;
  final chatroomId;
  ChatPage({this.chattedUser, this.currentUser, this.chatroomId});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String message;
  String messageId = "";
  TextEditingController messageHolder = TextEditingController();

  getAndSetMessages() async {
    //some code to get the messages here
  }

  Widget _buildMessageBoxRow(){
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 15 * SizeConfig.heightMultiplier
        ),
        color: Colors.black.withOpacity(0.2),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.0),
                color: Colors.white,
                child: TextField(
                  controller: messageHolder,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Write your message here...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLength: 240,
                  maxLines: null,
                  onChanged: (input){
                    if(input.length > 240){
                      //some code to stop the user from writing
                      message = input.substring(0,240);
                    }else{
                      message = input;
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 2 * SizeConfig.heightMultiplier),
            GestureDetector(
              child: Container(
                child: Row(
                  children: [
                    Text("Send"),
                    SizedBox(width: 0.5 * SizeConfig.heightMultiplier),
                    Icon(
                      Icons.send,
                    ),
                  ],
                ),
              ),
              onTap: () {
                if(message.isNotEmpty){
                  var messageSent = DateTime.now();
                  messageId = ChatroomController().generateMessageId();
                  ChatMessages newMessage = 
                    new ChatMessages(
                      messageId: messageId,
                      message: message,
                      sender: widget.currentUser.displayName,
                      sentTime: messageSent,
                      displayPhoto: widget.currentUser.photoURL,
                    );
                  //Adds the message to the database
                  ChatroomController().addMessage(widget.chatroomId, newMessage).then((value){
                    Chatroom chatroomUpdates = 
                      new Chatroom(
                        lastMessage: message,
                        lastMessageSentTime: messageSent,
                        lastMessageSender: widget.currentUser.displayName
                      );
                    //Updates the Chatroom Details
                    ChatroomController().updateLastMessageSent(widget.chatroomId, chatroomUpdates);
                  });

                  //clears the message field
                  setState(() {
                    messageHolder.clear();
                  });
                  messageId = "";
                }
              }
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xfff1976d2), 
          title: Text(widget.chattedUser.username),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
              ),
            )
          ],
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: MediaQuery.of(context).size.width,
          // child: Container(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
                  
          //       ],
          //     ),
          //   ),
          // ),
          child: Stack(
            children: [
              _buildMessageBoxRow(),
            ],
          ),
        ),
      )
    );
  }
}