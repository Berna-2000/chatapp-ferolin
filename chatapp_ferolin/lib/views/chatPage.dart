import 'package:chatapp_ferolin/controller/chatroomController.dart';
import 'package:chatapp_ferolin/models/chatroom.dart';
import 'package:chatapp_ferolin/partials/sizeconfig.dart';
import '../partials/loadingPage.dart';
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
  bool isFirstTime = true;
  Stream streamMessages;

  getAndSetMessages() async {
    //some code to get the messages here
    streamMessages = await ChatroomController().retrieveChatroomMessages(widget.chatroomId);
    setState(() {});
  }

  @override
  void initState(){
    getAndSetMessages();
    super.initState();
  }

  Widget _buildMessageBoxRow(){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 10.0),
      child: Container(
        height: 11 * SizeConfig.heightMultiplier,
        constraints: BoxConstraints(
          maxHeight: 15 * SizeConfig.heightMultiplier
        ),
        color: Colors.grey,
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
                    isFirstTime = false;
                    // FocusScope.of(context).unfocus();
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

  Widget _buildMessages(){
    return StreamBuilder(
      stream: streamMessages,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Loading();
        }else{
          isFirstTime = false;
        }
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 70.0, top: 16.0),
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            // reverse: true,
            itemBuilder: (context, index){
              DocumentSnapshot messageSnapshot = snapshot.data.docs[index];
              // return _buildChatMessageTile(messageSnapshot['message']);
              return Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: _buildChatMessageTile(messageSnapshot['message']),
              );
            }
          )
        );
      }
    );
  }

  Widget _buildChatMessageTile(String thisMessage){
    return Container(
      color: Colors.lightGreen[400],
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.all(10.0),
      child: Text(
        thisMessage,
      )
    );
  }

  Widget _buildEmptyConversation(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          "You can now start a conversation with this person.",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 3 * SizeConfig.textMultiplier,
          ),
          textAlign: TextAlign.center,
        ),
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
          child: Stack(
            children: [
              // Container(
              //   child: SingleChildScrollView(
              //     child: _buildMessages(),
              //   )
              // ),
              isFirstTime ? _buildEmptyConversation() : _buildMessages(),
              _buildMessageBoxRow(),
            ],
          ),
        ),
      )
    );
  }
}