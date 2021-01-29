import 'package:chatapp_ferolin/controller/chatroomController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../partials/sizeconfig.dart';
import '../models/appUsers.dart';
import '../common/packages.dart';
import '../views/chatPage.dart';


showAddToContactAlert(BuildContext context, AppUser addedUser, User currentUser, String chatID){
  String content = "Would you like to add "+addedUser.username+"?";
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Add contact',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Montserrat"
          )
        ),
        content: Text(
          content,
          style: TextStyle(
            fontSize: 2 * SizeConfig.textMultiplier,
            fontFamily: "Montserrat"
          )
        ),
        actions: [
          FlatButton(
            child: Text(
              'NO',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              'OKAY',
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Montserrat"
              )
            ),
            onPressed: () {
              //some code here to create the chat and navigate
              List<String> users = [addedUser.username, currentUser.displayName];
              ChatroomController().createChatroom(chatID, users);
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>
                  ChatPage(
                    chattedUser: addedUser, 
                    currentUser: currentUser, 
                    chatroomId: chatID)));
            },
          )
        ]
      );
    }
  );
}